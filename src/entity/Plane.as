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

		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Plane(player:int) {
			this.m_activePlayer = player;
			this.m_controls = new EvertronControls(this.m_activePlayer);
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
			this.addChild(this.m_skin);
		}
		
		/**	
		 * update
		 * override, gameloop
		 */
		override public function update():void {
			this.m_updateControls();
			this.m_updatePosition();
		}
		
		/**	
		 * m_updateControls
		 * Update the planes position.
		 */
		private function m_updateControls():void {
			if (this.m_controls != null) {
				if (Input.keyboard.pressed(this.m_controls.PLAYER_RIGHT)) {
					this.m_forward();
				}
			}
		}
		
		/**	
		 * m_updateControls
		 * Update the planes position.
		 */
		private function m_forward():void {
			if (this.m_activePlayer == 0) {
				this.x += 5;
			} else if (this.m_activePlayer == 1) {
				this.x -= 5;
			}
		}
		
		/**	
		 * m_updatePosition
		 * Update the planes position.
		 */
		private function m_updatePosition():void {
			if (this.m_activePlayer == 0) {
				this.x += 5;
			} else if (this.m_activePlayer == 1) {
				this.x -= 5;
			}
		}
	}
}