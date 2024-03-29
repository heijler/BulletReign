package state.menustate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.Bitmap;
	import flash.text.TextField;
	import flash.geom.Point;
	
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	import state.menustate.infoScreen.DogfightInfo;
	import state.menustate.infoScreen.ConquerInfo;
	import state.menustate.infoScreen.HowToPlay;
	import state.menustate.infoScreen.Credits;
	
	//-----------------------------------------------------------
	// MainMenu
	// Represents the MainMenu
	//-----------------------------------------------------------
	
	public class MainMenu extends Menu {
		
		//-----------------------------------------------------------
		// Embeds
		//-----------------------------------------------------------
		
		[Embed(source="../../../asset/png/mainmenu/logo.png")]
		private const Logo:Class;
		
		[Embed(source="../../../asset/png/mainmenu/art1.png")]
		private const Art1:Class;
		
		[Embed(source="../../../asset/png/mainmenu/art2.png")]
		private const Art2:Class;
		
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
		
		/**
		 * Gets called on Parent class init.
		 * Initializes components to make the main menu.
		 */
		override protected function _initMenu():void {
			this.m_drawLogo();
			this.m_drawArt();
			this.m_menuMusic.play();
			this.m_menuMusic.volume = 0.9;
			this._addMenuItems(
				new <Object>[
					{name:"Dogfight", state: DogfightInfo},
					{name:"Conquer the Banner", state: ConquerInfo},
					{name: "How to Play", state: HowToPlay},
					{name: "Credits", state: Credits}
				]
			);
			this._addCopy();
		}
		
		
		/**
		 * Gets called from parent class dispose
		 */
		override protected function _disposeMenu():void {
			trace("MainMenu dispose");
			this.m_menuMusic = null;
		}
		
		
		/**
		 * Creates and adds logotyp/image
		 */
		private function m_drawLogo():void {
			var logo:Bitmap = new Logo();
				logo.scaleX = 2;
				logo.scaleY = 2;
			var pos:Point = new Point((Session.application.size.x * 0.5) - (logo.width*0.5) , -25);
				this._addImage(logo, pos);
		}
		
		
		/**
		 * Creates and adds art
		 */
		private function m_drawArt():void {
			var art1:Bitmap = new Art1;
				art1.scaleX = 2.5;
				art1.scaleY = 2.5;
			var pos1:Point = new Point(0, 0); //0, 220
				this._addArt(art1, pos1);
				
			var art2:Bitmap = new Art2;
				art2.scaleX = 2.5;
				art2.scaleY = 2.5;
			var pos2:Point = new Point(Session.application.size.x - art2.width, 0);
			this._addArt(art2, pos2);
		}
		
		
		/**
		 * Initializes the Main Menu music
		 */
		private function m_initMusic():void {
			Session.sound.musicChannel.sources.add("menu", BulletReign.MENU_MUSIC);
			this.m_menuMusic = Session.sound.musicChannel.get("menu");
//			this.m_menuMusic.volume = 0.3;
		}
	}
}