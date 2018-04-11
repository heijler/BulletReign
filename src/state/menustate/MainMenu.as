package state.menustate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import state.gamestate.Gamestate;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	//-----------------------------------------------------------
	// MainMenu
	//-----------------------------------------------------------
	
	public class MainMenu extends DisplayState {
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function MainMenu() {
			super();
			trace("state.menustate.MainMenu");
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**	
		 * init
		 * override
		 */
		override public function init():void {
			// När displaystate läggs ut och blir synligt
		}
		
		/**	
		 * update
		 * override
		 */
		override public function update():void {
			// Gameloop
			this.m_updateControls();
		}
		
		/**	
		 * dispose
		 * override
		 */
		override public function dispose():void {
			// Ta bort displaystate, tömmer minne
		}
		
		/**	
		 * m_updateControls
		 */
		private function m_updateControls():void {
			if (Input.keyboard.justPressed("SPACE")) {
				Session.application.displayState = new Gamestate();
			}
		}
	}
}