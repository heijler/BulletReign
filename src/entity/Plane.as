package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	
	import asset.Plane1GFX;
	import asset.Plane2GFX;
	
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.tween.easing.Cubic;
	
	//-----------------------------------------------------------
	// Plane
	//-----------------------------------------------------------
	
	public class Plane extends MotionEntity {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_skin:MovieClip;
		private var m_controls:EvertronControls;
		private var m_activePlayer:int = 0;
		private var m_bullet:Bullet;

		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Plane(player:int) {
			super();
			this.m_activePlayer = player;
			this.m_controls = new EvertronControls(this.m_activePlayer);
			this.m_bullet = new Bullet();
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
			//this.m_skin.scaleX = 2;
			//this.m_skin.scaleY = 2;
			this.addChild(this.m_skin);
		}
		
		/**	
		 * update
		 * override, gameloop
		 */
		override public function update():void {
			this.m_updateControls();
			this.m_defaultSpeed();
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
				var newDownAngle:Number = 1.5 * (this._velocity/1.5);
				if (this.m_activePlayer == 0) {
					this._angle += newDownAngle;
				} else if (this.m_activePlayer == 1) {
					this._angle -= newDownAngle;
				}
			}
			
			if (instruction == "angleup") {
				var newUpAngle:Number = 1.5 * (this._velocity/1.5);
				if (this.m_activePlayer == 0) {
					this._angle -= newUpAngle;
				} else if (this.m_activePlayer == 1) {
					this._angle += newUpAngle;
				}
			}
			
			if (this.m_activePlayer == 0 && instruction == "fire") {
				
			} else if (this.m_activePlayer == 1 && instruction == "fire") {
				
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
		}
	}
}