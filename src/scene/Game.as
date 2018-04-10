package scene
{
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import entity.Plane;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	
	//-----------------------------------------------------------
	// Game
	//-----------------------------------------------------------
	
	public class Game extends DisplayState
	{
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_gameLayer:DisplayStateLayer;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Game()
		{
			super();
			trace("gamestate");
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**	
		 * init
		 * override
		 */
		override public function init():void {
			this.m_initLayers();
			var p:Plane = new Plane();
			p.x = 400;
			p.y = 200;
			this.m_gameLayer.addChild(p);
		}
		
		/**	
		 * m_initLayers
		 */
		private function m_initLayers():void {
			this.m_gameLayer = this.layers.add("game");
			
		}
	}
}