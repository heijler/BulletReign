package scene
{
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	public class Menu extends DisplayState
	{
		public function Menu()
		{
			super();
			trace("scene.Menu");
			
		}
		
		override public function init():void {
			// När displaystate läggs ut och blir synligt
		}
		
		override public function update():void {
			// Gameloop
			this.m_updateControls();
		}
		
		override public function dispose():void {
			// Ta bort displaystate, tömmer minne
		}
		
		private function m_updateControls():void {
			if (Input.keyboard.justPressed("SPACE")) {
				Session.application.displayState = new Game();
			}
		}
	}
}