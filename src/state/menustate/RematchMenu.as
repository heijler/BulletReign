package state.menustate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import state.menustate.infoScreen.HowToPlay;
	import state.gamestate.Dogfight;
	import state.menustate.MainMenu;
	import state.gamestate.Conquer;
	
	//-----------------------------------------------------------
	// RematchMenu
	// Represents the menu that shows the Rematch options
	//-----------------------------------------------------------
	
	public class RematchMenu extends Menu {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_gamemode:int;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		public function RematchMenu(gamemode:int) {
			super();
			this.m_gamemode = gamemode;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**
		 * Gets called on Parent class init
		 */
		override protected function _initMenu():void {
			this._addMenuItems(
				new <Object>[
					{name:"Rematch", state: (this.m_gamemode ? Conquer : Dogfight)},
					{name:"Main Menu", state: MainMenu},
					{name: "How to Play", state: HowToPlay}
				]
			);
		}
		
		
		/**
		 * Gets called on parent class dispose
		 */
		override protected function _disposeMenu():void {
			trace("RematchMenu");
			this.m_gamemode = 0;
		}
	}
}