package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	
	import asset.Plane1GFX;
	import asset.Plane2GFX;
	
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	
	//-----------------------------------------------------------
	// Plane
	//-----------------------------------------------------------
	
	public class Plane extends Projectile {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_skin:MovieClip;
		private var m_controls:EvertronControls;
		private var m_activePlayer:int = 0;
		private var velocity:Number;
		private var angle:Number;

		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Plane(player:int) {
			this.m_activePlayer = player;
			this.m_controls = new EvertronControls(this.m_activePlayer);
			this.velocity = 8;
			this.angle = 0;
			super();
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
			this.m_skin.scaleX = 2;
			this.m_skin.scaleY = 2;
			this.m_skin.x = x;
			this.m_skin.y = y;
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
		 * m_updateControls
		 * Update the planes position.
		 */
		private function m_navigate(pressed:String):void {
			
			this.m_skin.x += Math.cos(this.angle * (Math.PI / 180)) * this.velocity;
			this.m_skin.y += Math.sin(this.angle * (Math.PI / 180)) * this.velocity;
			this.m_skin.rotation = this.angle;
			
			if (this.m_activePlayer == 0 && pressed == "accelerate") {
				
			} else if (this.m_activePlayer == 1 && pressed == "accelerate") {
				
			}
			
			if (this.m_activePlayer == 0 && pressed == "angledown") {
				this.angle += 1.5 * (this.velocity/1.5);
			} else if (this.m_activePlayer == 1 && pressed == "angledown") {
				this.angle += 1.5 * (this.velocity/1.5);
			}
			
			if (this.m_activePlayer == 0 && pressed == "angleup") {
				this.angle -= 1.5 * (this.velocity/1.5);
			} else if (this.m_activePlayer == 1 && pressed == "angleup") {
				this.angle -= 1.5 * (this.velocity/1.5);
			}
			
			if (this.m_activePlayer == 0 && pressed == "fire") {
				
			} else if (this.m_activePlayer == 1 && pressed == "fire") {
				
			}
		}
		
		/**	
		 * m_updatePosition
		 * Update the planes position.
		 */
		private function m_defaultSpeed():void {
			if (this.m_activePlayer == 0) {
				this.m_skin.x += Math.cos(this.angle * (Math.PI / 180)) * this.velocity;
			} else if (this.m_activePlayer == 1) {
				this.m_skin.x -= Math.cos(this.angle * (Math.PI / 180)) * this.velocity;
			}
		}
	}
}