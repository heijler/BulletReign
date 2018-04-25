package state.menustate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	
	
	//-----------------------------------------------------------
	// RematchMenu
	//-----------------------------------------------------------
	
	public class RematchMenu extends Menu {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		public function RematchMenu() {
			super();
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		override protected function initMenu():void {
//			this._addMenuItems(new Vector.<String>["Rematch", "Main Menu", "How to Play"]);
			
			this._addMenuItems(
				new <Object>[
					{name:"Rematch", state: "Rematch"},
					{name:"Main Menu", state: "Main Menu"},
					{name: "How to Play", state: "How to PLay"}
				]
			);
		}
	}
}