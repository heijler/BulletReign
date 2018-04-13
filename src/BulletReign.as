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