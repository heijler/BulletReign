package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.DisplayObjectContainer;
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
		private var m_ebulletManager:BulletManager;
		private var m_durability:Number;
		private var m_controls:EvertronControls;
		private var m_activePlayer:int = 0;
		private var m_pos:Point;
		private var m_gameLayer:DisplayStateLayer;

		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Plane(player:int, gameLayer:DisplayStateLayer, bulletMngr:BulletManager, ebulletMngr:BulletManager, pos:Point) {
			super();
			this.m_gameLayer = gameLayer;
			this.m_bulletManager = bulletMngr;
			this.m_ebulletManager = ebulletMngr;
			this.m_durability = 100;
			this.m_activePlayer = player;
			this.m_gameLayer = gameLayer;
			this.m_controls = new EvertronControls(this.m_activePlayer);
			this.m_pos = pos;
			this._velocity = 3;
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
			this.m_skin.x = this.m_pos.x;
			this.m_skin.y = this.m_pos.y;
		}
		
		/**	
		 * update
		 * override, gameloop
		 */
		override public function update():void {
			this.m_updateControls();
			this.m_defaultSpeed();
			this.m_collisionControl();
			
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
					this.m_skin.x += xVel;
					this.m_skin.y += yVel;
				} else if (this.m_activePlayer == 1) {
					this.m_skin.x -= xVel;
					this.m_skin.y -= yVel;
				}
			}
	
			this.m_skin.rotation = this._angle;
			
			if (instruction == "angledown") {
				// Rename newDownAngle to newAngle when this method is smaller.
				var newDownAngle:Number = 1.5 * (this._velocity/1.5);
				if (this.m_activePlayer == 0) {
					this._angle += newDownAngle;
				} else if (this.m_activePlayer == 1) {
					this._angle -= newDownAngle;
				}
			}
			
			if (instruction == "angleup") {
				// Rename newUpAngle to newAngle when this method is smaller.
				var newUpAngle:Number = 1.5 * (this._velocity/1.5);
				if (this.m_activePlayer == 0) {
					this._angle -= newUpAngle;
				} else if (this.m_activePlayer == 1) {
					this._angle += newUpAngle;
				}
			}
			
			if (instruction == "fire") {
				this.m_bulletManager.add(this._angle, this._velocity, this.x, this.y, this.m_activePlayer);
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
				this.m_skin.x += xVel;
				this.m_skin.y += yVel;
			} else if (this.m_activePlayer == 1) {
				this.m_skin.x -= xVel;
				this.m_skin.y -= yVel;
			}
			this.x = this.m_skin.x;
			this.y = this.m_skin.y;
		}
		
		/**	
		 * m_checkCollision
		 * Check whether bullet objects collides with plane skin
		 */
		private function m_collisionControl():void {
			var bullet:Vector.<Bullet> = (this.m_ebulletManager.get());
			var i:int;
			for(i = 0; i < bullet.length; i++) {
				if(this.m_skin.hitTestObject(bullet[i])) {
					m_damageControl("hit");
				}
			}
			// Temporary LINES***REMOVE***
			if(this.m_skin.hitTestObject(this.m_gameLayer.getChildAt(0))) {
				this._velocity = 0;
			}
			
			if(this.m_skin.hitTestObject(this.m_gameLayer.getChildAt(1))) {
				this._velocity = 0;
			}
			
		}
		
		private function m_damageControl(hitValue:String):void {
			if(hitValue == "hit") {
				this.m_durability -= 10;
			}
			
			trace(this.m_durability);
		}
		
	}
}