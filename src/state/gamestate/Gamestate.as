package state.gamestate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.Graphics; // Temporary REMOVE
	import flash.display.Sprite; // Temporary REMOVE
	
	import entity.Plane;
	import entity.BulletManager;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import flash.geom.Point;
	
	//-----------------------------------------------------------
	// Gamestate
	//-----------------------------------------------------------
	
	public class Gamestate extends DisplayState {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		public var m_gameLayer:DisplayStateLayer;
		
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
			this.layers.container.scaleX = 2;
			this.layers.container.scaleY = 2;
			this.m_initLayers();
            
			var bm1:BulletManager = new BulletManager(this.m_gameLayer);
			var p1:Plane = new Plane(0, this.m_gameLayer, bm1, new Point(0, 250));
			this.m_gameLayer.addChild(p1);
			
			var bm2:BulletManager = new BulletManager(this.m_gameLayer);
			var p2:Plane = new Plane(1, this.m_gameLayer, bm2, new Point(400, 250));
			this.m_gameLayer.addChild(p2);
			
			// Temporary  Lines REMOVE
			var skyline:Sprite = new Sprite();
			var sl:Graphics = skyline.graphics;
			sl.lineStyle(2, 0xFFFFFF);
			sl.moveTo((this.m_gameLayer.width - this.m_gameLayer.width), (this.m_gameLayer.height - this.m_gameLayer.height));
			sl.lineTo(this.m_gameLayer.width * 2, (this.m_gameLayer.height - this.m_gameLayer.height));
			this.m_gameLayer.addChild(skyline);

			var ground:Sprite = new Sprite();
			var gd:Graphics = ground.graphics;
			gd.lineStyle(2, 0xFFFFFF);
			gd.moveTo((this.m_gameLayer.width - this.m_gameLayer.width), this.m_gameLayer.height * 1.1);
			gd.lineTo(this.m_gameLayer.width * 2, (this.m_gameLayer.height * 1.1));
			this.m_gameLayer.addChild(ground);
			// END Lines Temporary
		}
		
		/**	
		 * m_initLayers
		 */
		private function m_initLayers():void {
			this.m_gameLayer = this.layers.add("game");
		}
	}
}