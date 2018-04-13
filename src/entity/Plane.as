package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import asset.Plane1GFX;
	import asset.Plane2GFX;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	
	//-----------------------------------------------------------
	// Plane
	//-----------------------------------------------------------
	
	public class Plane extends MotionEntity {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_skin:MovieClip;
		private var m_bulletManager:BulletManager;
		private var m_controls:EvertronControls;
		private var m_activePlayer:int = 0;
		private var m_gameLayer:DisplayStateLayer;
		private var m_fireRate:Number = 4; //bullets per second

		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Plane(player:int, gameLayer:DisplayStateLayer, bulletMngr:BulletManager, pos:Point) {
			super();
			this.m_gameLayer = gameLayer;
			this.m_bulletManager = bulletMngr;
			this.m_activePlayer = player;
			this.m_gameLayer = gameLayer;
			this.m_controls = new EvertronControls(this.m_activePlayer);
			this.m_pos = pos;
			this._velocity = 5;
			this._angle = 0;
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
			} else if (m_activePlayer == 1) {
				this.m_skin = new Plane2GFX;
			}
			// Would be nice to avoid this scaling here
			this.m_skin.scaleX = 2;
			this.m_skin.scaleY = 2;
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
			this.m_updateControls();
			this.m_defaultSpeed();
			this.m_checkCollision();
			this.m_updatePosition();
		}
		
		
		/**	
		 * m_updateControls
		 * Update the planes position.
		 */
		private function m_updateControls():void {
			if (this.m_controls != null) {
				if (Input.keyboard.pressed(this.m_controls.PLAYER_UP)) {
					this.m_navigate("angledown");
				}
				
				if (Input.keyboard.pressed(this.m_controls.PLAYER_DOWN)) {
					this.m_navigate("angleup");
				}
				
				if (Input.keyboard.pressed(this.m_controls.PLAYER_BUTTON_7)) {
					this.m_navigate("accelerate");
				}
				
				if (Input.keyboard.pressed(this.m_controls.PLAYER_BUTTON_1)) {
					this.m_navigate("fire");
				}
			}
		}
		
		
		/**	
		 * m_navigate
		 * Update the planes position.
		 * @TODO: Divide this method in to several smaller methods
		 */
		private function m_navigate(instruction:String):void {
			if (instruction == "accelerate") {
				
				this._velocity = 2;
				
				var xVel:Number = Math.cos(this._angle * (Math.PI / 180)) * this._velocity;
				var yVel:Number = Math.sin(this._angle * (Math.PI / 180)) * this._velocity;
				
				if (this.m_activePlayer == 0) {
					this.x += xVel;
					this.y += yVel;
				} else if (this.m_activePlayer == 1) {
					this.x -= xVel;
					this.y -= yVel;
				}
			}
	
			this.m_skin.rotation = this._angle;
			
			if (instruction == "angledown") {
				// Rename newDownAngle to newAngle when this method is smaller.
				var newDownAngle:Number = this._velocity/1.5;
				if (this.m_activePlayer == 0) {
					this._angle += newDownAngle;
				} else if (this.m_activePlayer == 1) {
					this._angle -= newDownAngle;
				}
			}
			
			if (instruction == "angleup") {
				// Rename newUpAngle to newAngle when this method is smaller.
				var newUpAngle:Number = this._velocity/1.15;
				if (this.m_activePlayer == 0) {
					this._angle -= newUpAngle;
				} else if (this.m_activePlayer == 1) {
					this._angle += newUpAngle;
				}
			}
			
			if (instruction == "fire") {
				this.m_bulletManager.add(this._angle, this._velocity, this.m_getPos(), this.m_activePlayer, this.m_fireRate);
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
	
			if(this.x < -this.width) {
				this.x = 800;
			} else if (this.x > 800) {
				this.x = -this.width;
			}
			
		}
		
		
		/**	
		 * m_defaultSpeed
		 * Default speed of planes, no acceleration needed to keep in air
		 */
		private function m_defaultSpeed():void {
			this.applyGravity();
			var xVel:Number = Math.cos(this._angle * (Math.PI / 180)) * this._velocity;
			var yVel:Number = Math.sin(this._angle * (Math.PI / 180)) * this._velocity;
			
			
			
			if (this.m_activePlayer == 0) {
				this.x += xVel;
				this.y += yVel;
			} else if (this.m_activePlayer == 1) {
				this.x -= xVel;
				this.y -= yVel;
			}
		}
		
		
		// Temporary Method ***REMOVE***
		
		/**
		 * m_checkColiision
		 * 
		 */
		private function m_checkCollision():void {
			
			if(this.m_skin.hitTestObject(this.m_gameLayer.getChildAt(0))) {
				this._velocity = 0;
			}
			
			if(this.m_skin.hitTestObject(this.m_gameLayer.getChildAt(1))) {
				this._velocity = 0;
			}
			
		}
		
	}
}