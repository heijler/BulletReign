package state.menustate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	
	//-----------------------------------------------------------
	// MainMenu
	//-----------------------------------------------------------
	
	public class MainMenu extends Menu {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function MainMenu() {
			super();
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		override protected function initMenu():void {
			//this._addMenuItems(new <String>["Dogfight", "Conquer the Banner", "How to Play", "Credits"]);
			
			var menuItems:Vector.<Object> = new <Object>[
				{
					name: "Dogfight", 
					state: "state"
				},
				{
					name: "Conquer the Banner",
					state: "state"
				},
				{
					name: "How to Play",
					state: "state"
				}, 
				{
					name: "Credits",
					state: "state"
				}
			];
			
			this._addMenuItems(
				new <Object>[
					{name:"Dogfight", state: "DFstate"},
					{name:"Conquer the Banner", state: "CTBstate"},
					{name: "How to Play", state: "HTPstate"},
					{name: "Credits", state: "Cstate"}
				]
			);
		}
	}
}