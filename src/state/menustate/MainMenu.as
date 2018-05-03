package state.menustate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	import flash.geom.Point;
	import flash.display.Bitmap;
	
	//-----------------------------------------------------------
	// MainMenu
	//-----------------------------------------------------------
	
	public class MainMenu extends Menu {
		
		//-----------------------------------------------------------
		// Embeds
		//-----------------------------------------------------------
		
		[Embed(source="../../../asset/png/mainmenu/logo.png")]
		private const Logo:Class;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_menuMusic:SoundObject;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function MainMenu() {
			super();
			m_initMusic();
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
			this.m_drawLogo();
			this.m_menuMusic.play(); //Låten sätts till play(), låtvalet kan diskuteras
			this._addMenuItems(
				new <Object>[
					{name:"Dogfight", state: "Dogfight"},
					{name:"Conquer the Banner", state: "Conquer the Banner"},
					{name: "How to Play", state: "How to Play"},
					{name: "Credits", state: "Credits"}
				]
			);
		}
		
		
		/**
		 * m_drawLogo
		 * 
		 */
		private function m_drawLogo():void {
			var logo:Bitmap = new Logo();
				logo.scaleX = 2.5;
				logo.scaleY = 2.5;
			var pos:Point = new Point((Session.application.size.x * 0.5) - (logo.width*0.5) , 50);
				this._addImage(logo, pos);
		}
		
		
		/**
		 * m_initMusic
		 * 
		 */
		private function m_initMusic():void {
			Session.sound.musicChannel.sources.add("menu", BulletReign.MENU_MUSIC);
			this.m_menuMusic = Session.sound.musicChannel.get("menu");
			this.m_menuMusic.volume = 0.2;
			
		}
	}
}