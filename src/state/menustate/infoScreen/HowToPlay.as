package state.menustate.infoScreen {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.system.Session;

	import state.menustate.MainMenu;
	
	//-----------------------------------------------------------
	// HowToPlay
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
		 * 
		 */
		override protected function _newState():void {
			Session.application.displayState = new MainMenu;
		}
		
		
		/**
		 * 
		 */
		override protected function _initInfoScreen():void {
			this._infoScreen = new InstructionsSheet;
		}
	}
}