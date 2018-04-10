package
{
	import scene.Menu;
	
	import se.lnu.stickossdk.system.Engine;
	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#000000")]
	
	public class BulletReign extends Engine
	{
		public function BulletReign()
		{
			
		}
		
		override public function setup():void {
			this.initId = 36;
			this.initBackgroundColor = 0x000000;
			this.initDebugger = true;
			this.initDisplayState = Menu;
		}
	}
}