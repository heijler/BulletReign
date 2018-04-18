package state.gamestate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import entity.BulletManager;
	import entity.Plane;
	import entity.PlaneManager;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	
	import ui.HUD;
	import ui.HUDManager;
	
	//-----------------------------------------------------------
	// Gamestate
	//-----------------------------------------------------------
	
	public class Gamestate extends DisplayState {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		public var m_planeLayer:DisplayStateLayer;
		public var m_worldLayer:DisplayStateLayer;
    	public var m_HUDLayer:DisplayStateLayer;
		
		private var m_planes:Vector.<Plane>;
		private var m_bulletManagers:Vector.<BulletManager>;
		private var m_sky:Sprite;
		private var m_ground:Sprite;
		

		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Gamestate() {
			super();
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
			this.m_initSky();
			this.m_initGround();
			this.m_initPlanes();
			this.m_initHUD();
		}
		
		
		/**	
		 * m_initLayers
		 */
		private function m_initLayers():void {
			this.m_planeLayer = this.layers.add("plane");
			this.m_worldLayer = this.layers.add("world");
			this.m_HUDLayer = this.layers.add("HUD");
		}
		
		
		/**
		 * m_initPlanes
		 * 
		 */
		private function m_initPlanes():void {
			var bm1:BulletManager = new BulletManager(this.m_planeLayer);
			var bm2:BulletManager = new BulletManager(this.m_planeLayer);
			
			var planeManager:PlaneManager = new PlaneManager(this.m_planeLayer);
				planeManager.add(new Plane(0, bm1, bm2, new Point(0, 150), 1));
				planeManager.add(new Plane(1, bm2, bm1, new Point(800, 150), -1));
			this.m_planes = planeManager.getPlanes();
		}
		
		
		/**
		 * m_initSky
		 * 
		 */
		private function m_initSky():void {
			this.m_sky = new Sprite();
			this.m_sky.graphics.lineStyle(2, 0xFFFFFF);
			this.m_sky.graphics.moveTo(0, 0);
			this.m_sky.graphics.lineTo(800, 0);
			this.m_worldLayer.addChild(this.m_sky);
		}
		
		
		/**
		 * m_initGround
		 * 
		 */
		private function m_initGround():void {
			this.m_ground = new Sprite();
			this.m_ground.graphics.lineStyle(2, 0xFFFFFF);
			this.m_ground.graphics.moveTo(0, 600);
			this.m_ground.graphics.lineTo(800, 600);
			this.m_worldLayer.addChild(this.m_ground);
		}
		
		
		/**
		 * m_initHUDLayer
		 * 
		 */
		private function m_initHUD():void {
			var hudManager:HUDManager = new HUDManager(this.m_HUDLayer);
				hudManager.add(new HUD(0, new Point(10, 10)));
				hudManager.add(new HUD(1, new Point(690, 10)));
			
		}
		
		
		/**
		 * update
		 * Override
		 */
		override public function update():void {
			this.m_skyCollision();
			this.m_groundCollision();
		}
		
		
		/**
		 * m_skyCollision
		 * Bounces plane back in reflected angle from where it came in
		 */
		private function m_skyCollision():void {
			for (var i:int = 0; i < this.m_planes.length; i++) {
				if (this.m_planes[i].hitTestObject(this.m_sky)) {
					this.m_planes[i].reflectAngle();
					this.m_planes[i].updateRotation();
					
				}
			}
		}
		
		
		/**
		 * m_groundCollision
		 * Causes crash 
		 */
		private function m_groundCollision():void {
			for (var i:int = 0; i < this.m_planes.length; i++) {
				if (this.m_planes[i].hitTestObject(this.m_ground)) {
					if (this.m_planes[i].crashed == false) {
						this.m_planes[i].crashed = true;
						this.m_planes[i].crash(this.m_worldLayer);
						
					}
				}
			}
		}
	}
}