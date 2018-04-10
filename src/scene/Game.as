package scene
{
	import entity.Plane;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	
	public class Game extends DisplayState
	{
		private var m_gameLayer:DisplayStateLayer;
		
		public function Game()
		{
			super();
			trace("gamestate");
		}
		
		override public function init():void {
			this.m_initLayers();
			var p:Plane = new Plane();
			p.x = 400;
			p.y = 200;
			this.m_gameLayer.addChild(p);
		}
		
		private function m_initLayers():void {
			this.m_gameLayer = this.layers.add("game");
			
		}
	}
}