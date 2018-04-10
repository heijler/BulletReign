package scene {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import entity.Plane;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.system.Session;
	
	//-----------------------------------------------------------
	// Game
	//-----------------------------------------------------------
	
	public class Game extends DisplayState {
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_gameLayer:DisplayStateLayer;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Game() {
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
			var p1:Plane = new Plane(0);
			p1.x = 0;
			p1.y = 250;
			this.m_gameLayer.addChild(p1);
			
			var p2:Plane = new Plane(1);
			p2.x = Session.application.width;
			p2.y = 250;
			this.m_gameLayer.addChild(p2);
		}
		
		/**	
		 * m_initLayers
		 */
		private function m_initLayers():void {
			this.m_gameLayer = this.layers.add("game");
			
		}
	}
}