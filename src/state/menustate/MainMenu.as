package state.menustate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	import state.gamestate.Conquer;
	import state.gamestate.Dogfight;
	import state.menustate.infoScreen.Credits;
	import state.menustate.infoScreen.HowToPlay;
	
	//-----------------------------------------------------------
	// MainMenu
	//-----------------------------------------------------------
	
	public class MainMenu extends Menu {
		
		//-----------------------------------------------------------
		// Embeds
		//-----------------------------------------------------------
		
		[Embed(source="../../../asset/png/mainmenu/logo.png")]
		private const Logo:Class;
		
		[Embed(source="../../../asset/png/mainmenu/art.png")]
		private const Art:Class;
		
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
			this.m_drawLogo();
			this.m_drawArt();
			this.m_menuMusic.play(); //Låten sätts till play(), låtvalet kan diskuteras
			this._addMenuItems(
				new <Object>[
					{name:"Dogfight", state: Dogfight},
					{name:"Conquer the Banner", state: Conquer},
					{name: "How to Play", state: HowToPlay},
					{name: "Credits", state: Credits}
				]
			);
		}
		
		
		/**
		 * m_drawLogo
		 * 
		 */
		private function m_drawLogo():void {
			var logo:Bitmap = new Logo();
				logo.scaleX = 2;
				logo.scaleY = 2;
			var pos:Point = new Point((Session.application.size.x * 0.5) - (logo.width*0.5) , 0);
				this._addImage(logo, pos);
		}
		
		
		/**
		 * m_drawArt
		 * 
		 */
		private function m_drawArt():void {
			var art:Bitmap = new Art();
				art.scaleX = 2.5;
				art.scaleY = 2.5;
			var pos:Point = new Point(0, 220);
				this._addArt(art, pos);
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