package state.menustate.infoScreen {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.system.Session;
	import state.gamestate.Conquer;
	
	//-----------------------------------------------------------
	// ConquerInfo
	//-----------------------------------------------------------
	
	public class ConquerInfo extends InfoScreen {
		
		//-----------------------------------------------------------
		// Embeds
		//-----------------------------------------------------------
		
		[Embed(source="../../../../asset/png/infoscreen/conquer/conquer.png")]
		private const InstructionsSheet:Class;

		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function ConquerInfo() {
			super();
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		/**
		 * 
		 */
		override protected function _newState():void {
			Session.application.displayState = new Conquer;
		}
		
		
		/**
		 * 
		 */
		override protected function _initInfoScreen():void {
			this._infoScreen = new InstructionsSheet;
		}
	}
}