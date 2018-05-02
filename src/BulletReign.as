package {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.geom.Point;
	
	import se.lnu.stickossdk.system.Engine;
	
	import state.menustate.MainMenu;
	
	//-----------------------------------------------------------
	// Evertron settings
	//-----------------------------------------------------------
	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#ffffff")]
	
	//-----------------------------------------------------------
	// BulletReign
	//-----------------------------------------------------------
	
	public class BulletReign extends Engine {
		
		[Embed(source = "../asset/ttf/adore64.ttf", fontFamily = "adore64", mimeType = "application/x-font", embedAsCFF="false")]
		private static const COUNTER_TEXT:Class;
		
		[Embed(source = "../asset/sound/music/bgm_menu.mp3")]
		public static const MENU_MUSIC:Class;
		
		[Embed(source = "../asset/sound/music/bgm_action_3.mp3")]
		public static const INGAME_MUSIC:Class;
		
		[Embed(source = "../asset/sound/plane/sfx_wpn_machinegun_loop2.mp3")]
		public static const GUN_FIRE:Class;
		
		[Embed(source = "../asset/sound/plane/sfx_wpn_cannon2.mp3")]
		public static const PLANE_CRASH:Class;
		
		[Embed(source = "../asset/sound/plane/planeEngine.mp3")]
		public static const ENGINE_SOUND:Class;
		
		[Embed(source = "../asset/sound/plane/sfx_sounds_falling8.mp3")]
		public static const CRASH_SOUND:Class;
		
		[Embed(source = "../asset/sound/plane/sfx_deathscream_human14.mp3")]
		public static const SCREAM_SOUND:Class;
		
		[Embed(source = "../asset/sound/plane/sfx_damage_hit6.mp3")]
		public static const HIT1_SOUND:Class;
		
		[Embed(source = "../asset/sound/plane/sfx_damage_hit5.mp3")]
		public static const HIT2_SOUND:Class;
		
		[Embed(source = "../asset/sound/plane/sfx_damage_hit4.mp3")]
		public static const HIT3_SOUND:Class;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function BulletReign() {
			
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		override public function setup():void {
			this.initId = 36;
			this.initBackgroundColor = 0x000000;
			this.initSize = new Point(800,600);
			this.initScale = new Point(1, 1);
			this.initDebugger = true;
			this.initDisplayState = MainMenu;
		}
	}
}