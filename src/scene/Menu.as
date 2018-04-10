package scene
{
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	//-----------------------------------------------------------
	// Menu
	//-----------------------------------------------------------
	
	public class Menu extends DisplayState
	{
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Menu()
		{
			super();
			trace("scene.Menu");
			
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
				Session.application.displayState = new Game();
			}
		}
	}
}