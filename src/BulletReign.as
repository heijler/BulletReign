package {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import scene.Menu;
	import se.lnu.stickossdk.system.Engine;
	
	//-----------------------------------------------------------
	// Evertron settings
	//-----------------------------------------------------------
	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#000000")]
	
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
			this.initDebugger = true;
			this.initDisplayState = Menu;
		}
	}
}