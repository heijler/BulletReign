package state.menustate.infoScreen {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	import state.menustate.MainMenu;
	
	//-----------------------------------------------------------
	// Credits
	//-----------------------------------------------------------
	
	public class Credits extends InfoScreen {
		
		//-----------------------------------------------------------
		// Embeds
		//-----------------------------------------------------------
		
		[Embed(source="../../../../asset/png/infoscreen/credits/credits.png")]
		private const InstructionsSheet:Class;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Credits() {
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
		
		
		/**
		 * 
		 */
		override protected function _controlMove(control:EvertronControls):void {
			if (Input.keyboard.pressed(control.PLAYER_UP)) {
				BulletReign.rb = true;
				BulletReign.rbp = control.player;
			}
			
			if (Input.keyboard.anyPressed()) {
				this._newState();
			}
		}
	}
}