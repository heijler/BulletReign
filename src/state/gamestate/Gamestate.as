package state.gamestate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	import entity.BulletManager;
	import entity.Plane;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	
	//-----------------------------------------------------------
	// Gamestate
	//-----------------------------------------------------------
	
	public class Gamestate extends DisplayState {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		public var m_gameLayer:DisplayStateLayer;
		public var m_worldLayer:DisplayStateLayer;
		
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
			var p1:Plane = new Plane(0, this.m_worldLayer, bm1, new Point(0, 150));
			this.m_gameLayer.addChild(p1);
			
			var bm2:BulletManager = new BulletManager(this.m_gameLayer);
			var p2:Plane = new Plane(1, this.m_worldLayer, bm2, new Point(400, 150));
			this.m_gameLayer.addChild(p2);
			
			// Temporary  Lines REMOVE
			var skyline:Sprite = new Sprite();
			var sl:Graphics = skyline.graphics;
				sl.lineStyle(2, 0xFFFFFF);
				sl.moveTo(0, 0);
				sl.lineTo(800, 0);
			this.m_worldLayer.addChild(skyline);

			var ground:Sprite = new Sprite();
			var gd:Graphics = ground.graphics;
				gd.lineStyle(2, 0xFFFFFF);
				gd.moveTo(0, 600);
				gd.lineTo(800, 600);
			this.m_worldLayer.addChild(ground);
			// END Lines Temporary
		}
		
		/**	
		 * m_initLayers
		 */
		private function m_initLayers():void {
			this.m_gameLayer = this.layers.add("game");
			this.m_worldLayer = this.layers.add("world");
		}
	}
}