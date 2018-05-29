package state.menustate.infoScreen {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.system.Session;

	import state.menustate.MainMenu;
	
	//-----------------------------------------------------------
	// HowToPlay
	// Represents the How To Play Information screen
	//-----------------------------------------------------------
	
	public class HowToPlay extends InfoScreen {
		//-----------------------------------------------------------
		// Embeds
		//-----------------------------------------------------------
		
		[Embed(source="../../../../asset/png/infoscreen/howtoplay/howtoplay.png")]
		private const InstructionsSheet:Class;

		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function HowToPlay() {
			super();
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**
		 * Sets the state to MainMenu on activation.
		 * Overrides function that is called in parent.
		 */
		override protected function _newState():void {
			Session.application.displayState = new MainMenu;
		}
		
		
		/**
		 * Sets the infoscreen/background to be the embedded image.
		 * Overrides function that is called in parent.
		 */
		override protected function _initInfoScreen():void {
			this._infoScreen = new InstructionsSheet;
		}
	}
}