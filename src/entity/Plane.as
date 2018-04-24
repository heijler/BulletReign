package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import asset.Plane1GFX;
	import asset.Plane2GFX;
	
	import entity.fx.FXManager;
	import entity.fx.Trail;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	
	//-----------------------------------------------------------
	// Plane
	//-----------------------------------------------------------
	
	public class Plane extends MotionEntity {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		public var crashed:Boolean = false;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const FIRE_DELAY:int = 4;
		private const ACCELERATE_FACTOR:Number = 0.25;
		private const BASE_SPEED:Number = 4;
		public const m_durability:Number = 10;
		public var m_wins:Number = 0;
		public var m_newWins:Number;
		private var m_fxMan:FXManager;
		private var m_skin:MovieClip;
		private var m_bulletManager:BulletManager;
		private var m_ebulletManager:BulletManager;
		public var m_newDurability:Number;
		private var m_controls:EvertronControls;
		public var m_activePlayer:int = 0;
		private var m_fireDelay:Number = FIRE_DELAY;
		private var m_burstSize:int = 5;
		private var m_scaleFactor:int = 1;
		private var m_steering:Boolean = true;

		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Plane(player:int, bulletMngr:BulletManager, ebulletMngr:BulletManager, pos:Point, scaleFactor) {
			super();
			this.m_bulletManager = bulletMngr;
			this.m_ebulletManager = ebulletMngr;
			this.m_newDurability = this.m_durability;
			this.m_activePlayer = player;
			this.m_controls = new EvertronControls(this.m_activePlayer);
			this.m_pos = pos;
			this._velocity = this.BASE_SPEED;
			this._angle = 0;
			this.m_scaleFactor = scaleFactor;
			this.m_fxMan = new FXManager();
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**	
		 * init
		 * override
		 */
		override public function init():void {
			this.m_initSkin();
			this.m_setSpawnPosition();
		}
		
		
		/**	
		 * m_initSkin
		 * Initialize skin
		 */
		private function m_initSkin():void {
			if (m_activePlayer == 0) {
				this.m_skin = new Plane1GFX;
				this._setScale(this.m_skin, 2, 2);
			} else if (m_activePlayer == 1) {
				this.m_skin = new Plane2GFX;
				this._setScale(this.m_skin, -2, 2);
			}
			this.m_skin.cacheAsBitmap = true;
			this.addChild(this.m_skin);
		}
		
		
		/**
		 * m_setSpawnPosition
		 * 
		 */
		private function m_setSpawnPosition():void {
			this.x = this.m_pos.x;
			this.y = this.m_pos.y;
		}
		
		
		/**	
		 * update
		 * override, gameloop
		 */
		override public function update():void {
			this.applyGravity();
			this.m_updateControls();
			this.m_defaultSpeed();
			this.m_collisionControl()
			this.m_updatePosition();
			this.m_checkwin();
		}
		
		
		/**	
		 * m_updateControls
		 * Update the planes position.
		 */
		private function m_updateControls():void {
			if (this.m_controls != null) {
				if (Input.keyboard.pressed(this.m_controls.PLAYER_UP)) {
					this.m_anglePlane(1);
				}
				
				if (Input.keyboard.pressed(this.m_controls.PLAYER_DOWN)) {
					this.m_anglePlane(0);
				}
				
				if (Input.keyboard.pressed(this.m_controls.PLAYER_BUTTON_7)) {
					this.m_accelerate();
				}
				
				if (Input.keyboard.pressed(this.m_controls.PLAYER_BUTTON_1)) {
					this.m_fireBullets();
				}
			}
		}
		
		
		/**
		 * m_anglePlane
		 * owner: 0 or 1
		 * direction: 0 [up], 1 [down]
		 */
		private function m_anglePlane(direction:int):void {
			var newAngle:Number = this._velocity / (direction ? 1.5 : 1.15);
			
			if (this.m_steering && direction == 0) {
				this._angle -= newAngle * this.m_scaleFactor;
			} else if (this.m_steering && direction == 1) {
				this._angle += newAngle * this.m_scaleFactor;
			}
			
			this._angle %= 360; // resets angle at 360
			if (this._angle < 0) this._angle = this._angle + 360; // Prevents minus angles
			this.updateRotation();
		}
		
		
		/**
		 * reflectAngle
		 * 
		 */
		public function reflectAngle():void {
			this._angle = 360 - this._angle; 
		}
		
		
		/**
		 * updateRotation
		 * Updates the skins rotation to match the angle.
		 */
		public function updateRotation():void {
			//this.rotation = this._angle;
			this.rotation = this._angle;
		}
		
		
		/**
		 * m_accelerate
		 * 
		 */
		private function m_accelerate():void {
			var xVel:Number = Math.cos(this._angle * (Math.PI / 180)) * (this._velocity * 0.25);
			var yVel:Number = Math.sin(this._angle * (Math.PI / 180)) * (this._velocity * 0.25);
			
			this.x += xVel * this.m_scaleFactor;
			this.y += yVel * this.m_scaleFactor;
			
			
			this.m_fxMan.add(new entity.fx.Trail);
		}
		
		
		/**
		 * m_fireBullets
		 * 
		 */
		private function m_fireBullets():void {
			this.m_fireDelay--;
			if (this.m_fireDelay == 0) {
				this.m_bulletManager.add(this._angle, this._velocity, m_getPos(), this.m_activePlayer);
				this.m_fireDelay = FIRE_DELAY;
			}
		}
		
		
		/**
		 * m_getPos
		 * 
		 */
		private function m_getPos():Point {
			return new Point(this.x, this.y);
		}
		
		
		/**
		 * m_updatePosition
		 * 
		 */
		private function m_updatePosition():void {
			this.wrapAroundObjects();
		}
		
		
		/**	
		 * m_defaultSpeed
		 * Default speed of planes, no acceleration needed to keep in air
		 */
		private function m_defaultSpeed():void {
			var xVel:Number = Math.cos(this._angle * (Math.PI / 180)) * this._velocity;
			var yVel:Number = Math.sin(this._angle * (Math.PI / 180)) * this._velocity;
			
			this.x += xVel * this.m_scaleFactor;
			this.y += yVel * this.m_scaleFactor;
		}
		

		/**	
		 * m_checkCollision
		 * 
		 */
		private function m_collisionControl():void {
			this.m_bulletCollision();		
		}
		
		
		/**
		 * m_bulletCollision
		 * 
		 */
		private function m_bulletCollision():void {
			if (this.crashed == false && this.m_ebulletManager.checkCollision(this)) {
				this.m_damageControl();
			}
		}
		
		
		/**
		 * crash
		 * 
		 */
		public function crash(layer:DisplayStateLayer):void {
			this._velocity = 0;
			this.removeGravity();
			this._shake(layer, 5);
			this._flicker(this, 500);
		}
		
		/**
		 * m_damageControl
		 * 
		 */
		private function m_damageControl():void {
			if(this.m_newDurability != 0) {
				this.m_newDurability -= this.m_ebulletManager.damage;
			} else if (this.m_newDurability <= 0) {
				this.m_steering = false;
				this.m_freeFall();
				this._flicker(this, 500);
			}
		}
		
		
		/**
		 * m_freeFall
		 * @TODO: Move this to MotionEntity
		 */
		private function m_freeFall():void {
			this._velocity = 5;
			this._angle = this._angle + 5 * this.m_scaleFactor;
			this.setGravityFactor(7);
			this.updateRotation();
		}
		
		private function m_checkwin():void {
			this.m_newWins = this.m_wins + 1; //OBS. Methoden fungerar ej!
			if(this.m_newWins != 2) {
				this.m_wins = this.m_newWins;
			} else if (this.m_wins >= 2) {
				trace("Du vann");
			}
		}
	}
}