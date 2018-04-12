package state.gamestate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import entity.Plane;
	import entity.BulletManager;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.system.Session;
	import flash.geom.Point;
	
	//-----------------------------------------------------------
	// Gamestate
	//-----------------------------------------------------------
	
	public class Gamestate extends DisplayState {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_gameLayer:DisplayStateLayer;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Gamestate() {
			super();
			trace("state.gamestate.Gamestate");
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**	 w
		 * init
		 * override
		 */
		override public function init():void {
			this.m_initLayers();
			var bm1:BulletManager = new BulletManager(this.m_gameLayer);
			var p1:Plane = new Plane(bm1, this.m_gameLayer, 0, new Point(0, 250));
				//p1.x = 0;
				//p1.y = 250;
			this.m_gameLayer.addChild(p1);
			
			var bm2:BulletManager = new BulletManager(this.m_gameLayer);
			var p2:Plane = new Plane(bm2, this.m_gameLayer, 1, new Point(400, 250));
				//p2.x = Session.application.width;
				//p2.y = 250;
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