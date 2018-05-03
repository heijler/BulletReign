package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import asset.Plane1GFX;
	import asset.Plane2GFX;
	
	import entity.BulletManager;
	import entity.fx.FXManager;
	import entity.fx.Trail;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	
	//-----------------------------------------------------------
	// Plane
	//-----------------------------------------------------------
	
	public class Plane extends MotionEntity {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		public const PLANE_DURABILITY:Number = 10;
		
		public var crashed:Boolean = false;
		public var m_wins:Number = 0; //@TODO: Rename if public, does it need to be public?
		public var m_newWins:Number; //@TODO: Rename if public, does it need to be public?
		public var m_newDurability:Number; //@TODO: Rename if public, does it need to be public?
		public var m_activePlayer:int = 0; //@TODO: Rename if public, does it need to be public?
		public var m_noAccelDuration:Boolean = false;
		public var m_noDamage:Boolean = false;
		public var m_noFireCounter:Boolean = false;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const FIRE_DELAY:int = 4; //4
		private const ACCELERATE_FACTOR:Number = 0.25;
		private const ACCELERATE_DURATION:int = 80;
		private const BASE_SPEED:Number = 4; //4
		private const FIRE_BURST_SIZE:int = 20;
		
		private var m_fxMan:FXManager;
		private var m_skin:MovieClip;
		private var m_bulletManager:BulletManager;
		private var m_ebulletManager:BulletManager;
		private var m_controls:EvertronControls;
		private var m_fireDelay:Number = FIRE_DELAY;
		private var m_burstSize:int = 5;
		private var m_scaleFactor:int = 1;
		private var m_steering:Boolean = true;
		private var m_accelDuration:int;
		private var m_accelerating:Boolean = true;
		private var m_fireCounter:int;
		private var m_firing:Boolean = true;
		private var m_openFire:SoundObject;
		private var m_crashing:SoundObject;
		private var m_engineSound:SoundObject;
		private var m_fallingPlane:SoundObject;
		private var m_screamSound:SoundObject;
		private var m_takingFire:Vector.<SoundObject>;

		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Plane(player:int, bulletMngr:BulletManager, ebulletMngr:BulletManager, pos:Point, scaleFactor, fxMan) {
			super();
			this.m_activePlayer = player;
			this.m_bulletManager = bulletMngr;
			this.m_ebulletManager = ebulletMngr;
			this.m_pos = pos;
			this.m_scaleFactor = scaleFactor;
			this.m_fxMan = fxMan;
			
			this.m_newDurability = this.PLANE_DURABILITY;
			this.m_controls = new EvertronControls(this.m_activePlayer);
			this._velocity = this.BASE_SPEED;
			this._angle = 0;
			this.m_accelDuration = this.ACCELERATE_DURATION;
			this.m_fireCounter = this.FIRE_BURST_SIZE;
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
			this.m_initSound();
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
			this.m_skin.gotoAndStop(1);
			this.m_setHitboxes();
			
			this.addChild(this.m_skin);
		}
		
		
		/**
		 * m_setHitboxes
		 * 
		 */
		private function m_setHitboxes():void {
			var tailHitbox:Sprite = new Sprite();
				tailHitbox.graphics.beginFill(0xFF0000);
				tailHitbox.graphics.drawRect(-8, -1, 7, 3);
				tailHitbox.graphics.endFill();
			this.m_skin.addChild(tailHitbox);
			
			var bodyHitbox:Sprite = new Sprite();
				bodyHitbox.graphics.beginFill(0xFFFF00);
				bodyHitbox.graphics.drawRect(-1, -2, 9, 6);
				bodyHitbox.graphics.endFill();
			this.m_skin.addChild(bodyHitbox);
		}
		
		
		/**
		 * m_setSpawnPosition
		 * 
		 */
		private function m_setSpawnPosition():void {
			this.x = this.m_pos.x;
			this.y = this.m_pos.y;
		}
		
		private function m_initSound():void {
			Session.sound.soundChannel.sources.add("machinegun", BulletReign.GUN_FIRE);
			Session.sound.soundChannel.sources.add("planecrashing", BulletReign.PLANE_CRASH);
			Session.sound.soundChannel.sources.add("enginesound", BulletReign.ENGINE_SOUND);
			Session.sound.soundChannel.sources.add("fallingplane", BulletReign.CRASH_SOUND);
			Session.sound.soundChannel.sources.add("scream", BulletReign.SCREAM_SOUND);
			Session.sound.soundChannel.sources.add("takingFire1", BulletReign.HIT1_SOUND);
			Session.sound.soundChannel.sources.add("takingFire2", BulletReign.HIT2_SOUND);
			Session.sound.soundChannel.sources.add("takingFire3", BulletReign.HIT3_SOUND);
			this.m_openFire = Session.sound.soundChannel.get("machinegun");
			this.m_crashing = Session.sound.soundChannel.get("planecrashing");
			this.m_engineSound = Session.sound.soundChannel.get("enginesound"); //VAR SKA DEN VARA?
			this.m_fallingPlane = Session.sound.soundChannel.get("fallingplane");
			this.m_screamSound = Session.sound.soundChannel.get("scream");
			this.m_takingFire = new Vector.<SoundObject>;
			this.m_takingFire.push(Session.sound.soundChannel.get("takingFire1"), Session.sound.soundChannel.get("takingFire2"), Session.sound.soundChannel.get("takingFire3"));
			
		}
		/**	
		 * update
		 * override, gameloop
		 */
		override public function update():void {
			this.applyGravity();
			this.m_updateControls();
			this.m_defaultSpeed();
			this.m_collisionControl();
			this.m_updatePosition();
			this.m_checkwin();
		}
		
		
		/**
		 * 
		 */
		override public function dispose():void {
			trace("Dispose plane! REMOVE ME WHEN ACTUALLY DISPOSING.");
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
				
				if (Input.keyboard.pressed(this.m_controls.PLAYER_BUTTON_2)) {
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
			this.rotation = this._angle;
		}
		
		
		/**
		 * m_accelerate
		 * 
		 */
		private function m_accelerate():void {
			if (this.m_steering && this.m_accelDuration != 0 && this.m_accelerating) {
				var xVel:Number = Math.cos(this._angle * (Math.PI / 180)) * (this._velocity * 0.25);
				var yVel:Number = Math.sin(this._angle * (Math.PI / 180)) * (this._velocity * 0.25);
				if(this.m_noAccelDuration == false) {
				this.m_accelDuration--;
				} else {
					var timeout:Timer = Session.timer.create(5000, this.m_clearNoAccelDuration);
				}
				this.x += xVel * this.m_scaleFactor;
				this.y += yVel * this.m_scaleFactor;
				this.m_fxMan.add(new Trail(this.m_getPos(), this._angle));
				
			} else if (this.m_accelDuration <= 0 && this.m_accelerating){
				this.m_accelerating = false;
				var timer:Timer = Session.timer.create(2000, this.m_resetAcceleration);
			}
		}
		
		
		private function m_clearNoAccelDuration():void {
			this.m_noAccelDuration = false;
		}
		
		private function m_clearNoFireCounter():void {
			this.m_noFireCounter = false;
		}
		
		private function m_clearNoDamage():void {
			this.m_noDamage = false;
		}
		
		/**
		 * m_resetAcceleration
		 * 
		 */
		private function m_resetAcceleration():void {
			if (!this.m_accelerating) {
				this.m_accelerating = true;
				this.m_accelDuration = this.ACCELERATE_DURATION;
			}
		}
		
		
		/**
		 * m_fireBullets
		 * 
		 */
		private function m_fireBullets():void {
			if (this.m_steering) {
				this.m_fireDelay--;
				if (this.m_fireDelay <= 0 && this.m_fireCounter > 0 && this.m_firing) {
					this.m_openFire.play();
					if(this.m_noFireCounter == false) {
					this.m_fireCounter--;
					} else {
					var timeout:Timer = Session.timer.create(5000, this.m_clearNoFireCounter);
					}
					this.m_bulletManager.add(this._angle, this._velocity, this.m_getPos(), this.m_scaleFactor);
					this.m_fireDelay = FIRE_DELAY;
				} else if (this.m_fireCounter <= 0 && this.m_firing){
					this.m_firing = false;
					var timer:Timer = Session.timer.create(1000, this.m_resetFireRate);
				}
			}
		}
		
		
		/**
		 * 
		 * 
		 */
		private function m_resetFireRate():void {
			if (!this.m_firing) {
				this.m_firing = true;
				this.m_fireCounter = this.FIRE_BURST_SIZE;
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
			this.m_fallingPlane.stop();
			this.m_crashing.play();
		}
		
		/**
		 * m_damageControl
		 * 
		 */
		private function m_damageControl():void {
			if(this.m_noDamage == false) {
			this.m_newDurability -= this.m_ebulletManager.damage;
			} else {
			var timeout:Timer = Session.timer.create(5000, this.m_clearNoDamage);
			}
			if(this.m_takingFire != null) {
				this.m_takingFire[Math.floor(Math.random() * this.m_takingFire.length)].play(); //Spelar ett random träffljud
			}
			
			if (this.m_newDurability <= 0) {
				this.m_steering = false;
				this.m_freeFall();
				this._flicker(this, 500);
				this.m_screamSound.play();
				this.m_fallingPlane.play();
			}
		}
		
		
		/**
		 * m_freeFall
		 * @TODO: Move this to MotionEntity
		 */
		private function m_freeFall():void {
			this._velocity = 4;
			this.setGravityFactor(4);
			this.reflectAngle();
			this.updateRotation();
		}
		
		
		/**
		 * m_checkwin
		 * 
		 */
		private function m_checkwin():void {
			this.m_newWins = this.m_wins + 1; //OBS. Methoden fungerar ej!
			if(this.m_newWins != 2) {
				//this.m_wins = this.m_newWins;
			} else if (this.m_wins >= 2) {
				trace("Du vann");
			}
		}
	}
}