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
		 * 
		 */
		override protected function _newState():void {
			Session.application.displayState = new Dogfight;
		}
		
		
		/**
		 * 
		 */
		override protected function _initInfoScreen():void {
			this._infoScreen = new InstructionsSheet;
		}
	}
}