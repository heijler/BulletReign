package state.menustate.infoScreen {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.system.Session;
	import state.gamestate.Dogfight;
	
	//-----------------------------------------------------------
	// DogfightInfo
	//-----------------------------------------------------------
	
	public class DogfightInfo extends InfoScreen {
		
		//-----------------------------------------------------------
		// Embeds
		//-----------------------------------------------------------
		
		[Embed(source="../../../../asset/png/infoscreen/dogfight/dogfight.png")]
		private const InstructionsSheet:Class;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function DogfightInfo() {
			super();
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**
		 * Sets the state to DogFight on activation.
		 * Overrides function that is called in parent.
		 */
		override protected function _newState():void {
			Session.application.displayState = new Dogfight;
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