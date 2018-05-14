package state.menustate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import state.gamestate.Dogfight;
	import state.gamestate.Conquer;
	import state.menustate.MainMenu;
	import state.menustate.infoScreen.HowToPlay;
	
	//-----------------------------------------------------------
	// RematchMenu
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
			trace("Rematch gamemode:", this.m_gamemode);
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		override protected function initMenu():void {
			this._addMenuItems(
				new <Object>[
					{name:"Rematch", state: (this.m_gamemode ? Conquer : Dogfight)},
					{name:"Main Menu", state: MainMenu},
					{name: "How to Play", state: HowToPlay}
				]
			);
		}
	}
}