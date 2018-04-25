package state.gamestate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import entity.BulletManager;
	import entity.Crate;
	import entity.CrateManager;
	import entity.Plane;
	import entity.PlaneManager;
	import entity.fx.FXManager;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	
	import ui.HUD;
	import ui.HUDManager;
	
	
	//-----------------------------------------------------------
	// Gamestate
	//-----------------------------------------------------------
	
	public class Gamestate extends DisplayState {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		[Embed(source="../../../asset/png/backgrounds/mountain-bg.png")]
		private const BG:Class;
		
		public var m_backgroundLayer:DisplayStateLayer;
		public var m_planeLayer:DisplayStateLayer;
		public var m_worldLayer:DisplayStateLayer;
    	public var m_HUDLayer:DisplayStateLayer;
		public var m_crateLayer:DisplayStateLayer;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_planes:Vector.<Plane>;
		private var m_crates:Vector.<Crate>;
		private var m_crateSpawn:Point;
		private var m_wins:int;
//		private var m_bulletManagers:Vector.<BulletManager>;
		private var m_bm1:BulletManager; // @FIX, put into Vector?
		private var m_bm2:BulletManager; // @FIX, put into Vector?
		
		private var m_sky:Sprite;
		private var m_ground:Sprite;
		private var m_background:DisplayObject;
		
		private var m_hudManager:HUDManager;
		private var m_crateManager:CrateManager;
		private var m_fxMan1:FXManager;
		private var m_fxMan2:FXManager;
		//private var m_round:Round;
		

		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Gamestate() {
			super();
//			this.m_bulletManagers = new Vector.<BulletManager>()
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
			this.m_initBackground();
			this.m_initFX();
			this.m_initPlanes();
			this.m_initHUD();
			this.m_initCrates();
			//this.m_initRound();
		}
		
		
		/**	
		 * m_initLayers
		 */
		private function m_initLayers():void {
			this.m_backgroundLayer = this.layers.add("background");
			this.m_planeLayer = this.layers.add("plane");
			this.m_worldLayer = this.layers.add("world");
			this.m_HUDLayer = this.layers.add("HUD");
			this.m_crateLayer = this.layers.add("crate");
		}
		
		
		/**
		 * m_initPlanes
		 * 
		 */
		private function m_initPlanes():void {
			this.m_bm1 = new BulletManager(this.m_planeLayer);
			this.m_bm2 = new BulletManager(this.m_planeLayer);
			
			var planeManager:PlaneManager = new PlaneManager(this.m_planeLayer);
				planeManager.add(new Plane(0, this.m_bm1, this.m_bm2, new Point(0, 150), 1, this.m_fxMan1));
				planeManager.add(new Plane(1, this.m_bm2, this.m_bm1, new Point(800, 150), -1, this.m_fxMan2));
				
			this.m_planes = planeManager.getPlanes();
		}
		
		
		/**
		 * m_initFX
		 * 
		 */
		private function m_initFX():void {
			this.m_fxMan1 = new FXManager(this.m_planeLayer);
			this.m_fxMan2 = new FXManager(this.m_planeLayer);
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
		 * 
		 */
		private function m_initBackground():void {
			this.m_background = new BG();
			this.m_background.scaleX = 2.5;
			this.m_background.scaleY = 2.5;
			this.m_background.x = 50; 
			this.m_backgroundLayer.addChild(this.m_background);
		}
		
		
		/**
		 * m_initHUDLayer
		 * 
		 */
		private function m_initHUD():void {
			this.m_hudManager = new HUDManager(this.m_HUDLayer);
			this.m_hudManager.add(new HUD(0, new Point(10, 10)));
			this.m_hudManager.add(new HUD(1, new Point(690, 10)));
		
		}
		
		private function m_initCrates():void {
			this.m_crateManager = new CrateManager(this.m_crateLayer);
			this.m_initCrateTimer();
			//this.m_generateCrates();
			//new Point(100,0
			
		}

		/**
		 * 
		 */
		/*
		private function m_initRound():void {
			this.m_round = new Round();
		}
		*/
		
		/**
		 * update
		 * Override
		 */
		override public function update():void {
			this.m_skyCollision();
			this.m_groundCollision();
			this.m_crateGroundCollision();
			this.m_cratePlaneCollision();
			this.m_resolveRound();
			this.m_durabilityChange();
			this.m_removeInactiveBullets();
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
		
		private function m_crateGroundCollision():void {
			if (this.m_crates != null) {
				for (var i:int = 0; i < this.m_crates.length; i++) {
					if (this.m_crates[i].hitTestObject(this.m_ground)) {
						if (this.m_crates[i].hitGround == false) {
							this.m_crates[i].hitGround = true;
							this.m_crates[i].m_groundCollision(this.m_worldLayer);
						}
					}
				}
			}
		}
		
		private function m_cratePlaneCollision():void {
			if (this.m_crates != null) {
				for (var i:int = 0; i < this.m_planes.length; i++) {
					for (var j:int = 0; j < this.m_crates.length; j++) {
						if (this.m_planes[i].hitTestObject(this.m_crates[j])) {
							this.m_crateManager.removeCrate(this.m_crates[j]);
						}
					}
				}
			}
		}
		
		
		/**
		 * m_resolveRound
		 * Non-crashed player gets a point
		 */
		private function m_resolveRound():void {
			for (var i:int = 0; i < this.m_planes.length; i++) {
				if (this.m_planes[i].crashed == true) {
					for (var j:int = 0; j < this.m_planes.length; j++) {
						if (this.m_planes[j].crashed == false) {
							if (this.m_planes[j].m_newWins >= this.m_planes[j].m_wins) {
							this.m_hudManager.incrementWins(this.m_planes[j].m_activePlayer, this.m_planes[j].m_newWins);
							}
						}
					}
				}
			}
		}
		
		
		/**
		 * 
		 */
		private function m_durabilityChange():void {
			for(var i:int = 0; i < this.m_planes.length; i++) {
				if (this.m_planes[i].m_newDurability <= this.m_planes[i].m_durability) {
					this.m_hudManager.incrementDecrementHealth(this.m_planes[i].m_activePlayer, this.m_planes[i].m_newDurability);
				}
			}
		}
		
		
		/**
		 * 
		 */
		private function m_removeInactiveBullets():void {
//			this.m_bulletManagers
			this.m_bm1.removeInactiveBullets();
			this.m_bm2.removeInactiveBullets();
		}
		
		private function m_initCrateTimer():void {
			var timer:Timer = Session.timer.create(Math.round(Math.random()* 1000), this.m_generateCrates, 3);
		}
		
		private function m_generateCrates():void {
			this.m_crateSpawn = new Point(Math.floor(Math.random()* Session.application.size.x), 0);
			var randomizer:Number = Math.round(Math.random() * 2);
			var crateType:Vector.<int>;
				crateType = new Vector.<int>();
				crateType.push(1, 13, 25);
			var type:int;
			type = crateType[randomizer];
			this.m_crateManager.add(new Crate(this.m_crateSpawn, type));
			this.m_crates = m_crateManager.getCrates();
		}
	}
}