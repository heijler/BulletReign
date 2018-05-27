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
	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#000000")]
	
	//-----------------------------------------------------------
	// BulletReign
	//-----------------------------------------------------------
	
	public class BulletReign extends Engine {
		
		static public var debug:Boolean = false;
		
		[Embed(source = "../asset/ttf/BulletReign.ttf", fontFamily = "bulletreign", mimeType = "application/x-font", embedAsCFF="false")]
		private static const COUNTER_TEXT:Class;
		
		[Embed(source = "../asset/sound/music/bgm_menu.mp3")]
		public static const MENU_MUSIC:Class;
		
		[Embed(source = "../asset/sound/music/bgm_action_3.mp3")]
		public static const INGAME_MUSIC:Class;
		
		[Embed(source = "../asset/sound/music/rotv-8bit.mp3")]
		public static const RB_INGAME_MUSIC:Class;
		
		[Embed(source = "../asset/sound/plane/sfx_wpn_machinegun_loop2.mp3")]
		public static const GUN_FIRE:Class;
		
		[Embed(source = "../asset/sound/plane/sfx_wpn_cannon2.mp3")]
		public static const PLANE_CRASH:Class;
		
		[Embed(source = "../asset/sound/plane/planeEngine.mp3")]
		public static const ENGINE_SOUND:Class;
		
		[Embed(source = "../asset/sound/plane/planeEngineOverdrive.mp3")]
		public static const ENGINEOVERDRIVE_SOUND:Class;
		
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
		
		[Embed(source = "../asset/sound/powerup/sfx_coin_cluster1.mp3")]
		public static const POWERUP_SOUND:Class;
		
		[Embed(source = "../asset/sound/menu/sfx_menu_move3.mp3")]
		public static const MENUMOVE_SOUND:Class;
		
		[Embed(source = "../asset/sound/menu/sfx_menu_select2.mp3")]
		public static const MENUSELECT_SOUND:Class;
		
		[Embed(source = "../asset/sound/win/sfx_sounds_fanfare3.mp3")]
		public static const WIN_SOUND:Class;
		
		[Embed(source = "../asset/sound/banner/sfx_sounds_interaction21.mp3")]
		public static const BANNER_PICKUP:Class;
		
		[Embed(source = "../asset/sound/banner/sfx_sounds_interaction22.mp3")]
		public static const BANNER_DROP:Class;
		
		[Embed(source = "../asset/sound/banner/sfx_movement_jump13_landing.mp3")]
		public static const BANNER_LAND:Class;
		
		[Embed(source = "../asset/sound/banner/sfx_sounds_error10.mp3")]
		public static const BANNER_RESPAWN:Class;
		
		static public var rb:Boolean = false;
		static public var rbp:int = -1;
		
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