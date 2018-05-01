package state.menustate {
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;

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
		
		private var m_menuMusic:SoundObject;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function MainMenu() {
			super();
			initMusic();
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		override protected function initMenu():void {
			//this._addMenuItems(new <String>["Dogfight", "Conquer the Banner", "How to Play", "Credits"]);
			
//			var menuItems:Vector.<Object> = new <Object>[
//				{
//					name: "Dogfight", 
//					state: "state"
//				},
//				{
//					name: "Conquer the Banner",
//					state: "state"
//				},
//				{
//					name: "How to Play",
//					state: "state"
//				}, 
//				{
//					name: "Credits",
//					state: "state"
//				}
//			];
			this.m_menuMusic.play(); //Låten sätts till play(), låt valet kan diskuteras
			this._addMenuItems(
				new <Object>[
					{name:"Dogfight", state: "Dogfight"},
					{name:"Conquer the Banner", state: "Conquer the Banner"},
					{name: "How to Play", state: "How to Play"},
					{name: "Credits", state: "Credits"}
				]
			);
		}
		
		private function initMusic():void {
			Session.sound.musicChannel.sources.add("menu", BulletReign.MENU_MUSIC);
			this.m_menuMusic = Session.sound.musicChannel.get("menu");
			
		}
	}
}