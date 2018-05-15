package state.gamestate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import asset.GroundGFX;
	
	import entity.BulletManager;
	import entity.Cloud;
	import entity.Crate;
	import entity.CrateManager;
	import entity.Icon;
	import entity.Plane;
	import entity.PlaneManager;
	import entity.fx.FXManager;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	
	import state.menustate.RematchMenu;
	
	import ui.HUD;
	import ui.HUDManager;
	
	
	
	//-----------------------------------------------------------
	// Gamestate
	//-----------------------------------------------------------
	
	public class Gamestate extends DisplayState {
		
		//-----------------------------------------------------------
		// Embeds
		//-----------------------------------------------------------
		
		[Embed(source="../../../asset/png/backgrounds/background.png")]
		private const BG:Class;
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		public var backgroundLayer:DisplayStateLayer;
		public var worldLayer:DisplayStateLayer;
		public var crateLayer:DisplayStateLayer;
		public var hqLayer:DisplayStateLayer;
		public var bannerLayer:DisplayStateLayer;
		public var planeLayer:DisplayStateLayer;
		public var zeppelinLayer:DisplayStateLayer;
		public var HUDLayer:DisplayStateLayer;
		public var IconLayer:DisplayStateLayer;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		protected var m_planes:Vector.<Plane>; //@TODO: rename
		private var m_crates:Vector.<Crate>;
		private var m_crate:Crate;
		private var m_crateSpawn:Point;
//		private var m_bulletManagers:Vector.<BulletManager>;
		private var m_bm1:BulletManager; // @FIX, put into Vector?
		private var m_bm2:BulletManager; // @FIX, put into Vector?
		public var m_roundFlag:Boolean = false;
		
		private var m_sky:Sprite;
		public var m_ground:MovieClip; // @TODO: rename & move
		public var groundHitbox:Shape;
		private var m_background:DisplayObject;
		
		
		private var m_hudManager:HUDManager;
		private var m_crateManager:CrateManager;
		private var m_fxMan1:FXManager;
		private var m_fxMan2:FXManager;
		private var m_ingameMusic:SoundObject;
		private var m_powerupSound:SoundObject;
		protected var m_winSound:SoundObject;
		protected var _winLimit:int = 2;
		protected var _icons:Icon;
		//private var m_round:Round;
		
		//-----------------------------------------------------------
		// Protected properties
		//-----------------------------------------------------------
		
		//0 = Dogfight
		//1 = Conquer
		protected var _gamemode:int = 0;

		
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
			this.m_initClouds();
			this.m_initFX();
			this.m_initPlanes();
			this.m_initHUD();
			this.m_initCrates();
			this.m_initMusic();
			this.m_initSound();
			//this.m_initRound();
			this._initGamemode();
			
			this.flash(500, 0xFFFFFF);
		}
		
		
		/**	
		 * m_initLayers
		 */
		private function m_initLayers():void {
			this.backgroundLayer = this.layers.add("background");
			this.worldLayer = this.layers.add("world");
			this.crateLayer = this.layers.add("crate");
			this.hqLayer = this.layers.add("hq")
			this.bannerLayer = this.layers.add("banner");
			this.planeLayer = this.layers.add("plane");
			this.zeppelinLayer = this.layers.add("zeppelin");
			this.HUDLayer = this.layers.add("HUD");
			this.IconLayer = this.layers.add("ICON");
			
			
//			public var backgroundLayer:DisplayStateLayer;
//			public var worldLayer:DisplayStateLayer;
//			public var crateLayer:DisplayStateLayer;
//			public var hqLayer:DisplayStateLayer;
//			public var bannerLayer:DisplayStateLayer;
//			public var planeLayer:DisplayStateLayer;
//			public var zeppelinLayer:DisplayStateLayer;
//			public var HUDLayer:DisplayStateLayer;
		}
		
		
		/**
		 * m_initMusic
		 * 
		 */
		private function m_initMusic():void {
			Session.sound.musicChannel.sources.add("ingamemusic", BulletReign.INGAME_MUSIC);
			this.m_ingameMusic = Session.sound.musicChannel.get("ingamemusic");
			this.m_ingameMusic.play();
			this.m_ingameMusic.volume = 0.4;
		}
		
		/**
		 * m_initPlanes
		 * 
		 */
		private function m_initPlanes():void {
			this.m_bm1 = new BulletManager(this.planeLayer);
			this.m_bm2 = new BulletManager(this.planeLayer);
			
			var planeManager:PlaneManager = new PlaneManager(this.planeLayer);
			var move:Boolean = true
				planeManager.add(new Plane(0, this.m_bm1, this.m_bm2, new Point(0, 150), 1, this.m_fxMan1, move));
				planeManager.add(new Plane(1, this.m_bm2, this.m_bm1, new Point(800, 150), -1, this.m_fxMan2, move));
				
			this.m_planes = planeManager.getPlanes();
			for(var i:int = 0; i < this.m_planes.length; i++) {
				this.m_planes[i].m_engineSound.play();
				this.m_planes[i].m_engineSound.volume = 0.4;
			}
		}
		
		
		/**
		 * m_initFX
		 * 
		 */
		private function m_initFX():void {
			this.m_fxMan1 = new FXManager(this.planeLayer);
			this.m_fxMan2 = new FXManager(this.planeLayer);
		}
		
		
		/**
		 * m_initSky
		 * 
		 */
		private function m_initSky():void {
			this.m_sky = new Sprite();
			this.m_sky.graphics.lineStyle(2, 0xFFFFFF);
			this.m_sky.graphics.moveTo(0, -40);
			this.m_sky.graphics.lineTo(800, -40);
			this.worldLayer.addChild(this.m_sky);
		}
		
		
		/**
		 * m_initGround
		 * 
		 */
		private function m_initGround():void {
			this.m_ground = new GroundGFX();
			this.m_ground.scaleX = 2.5;
			this.m_ground.scaleY = 2.5;
			this.m_ground.y = Session.application.size.y - this.m_ground.height;
			this.m_ground.gotoAndStop(1);
			
			// General hitbox
			this.groundHitbox = new Shape();
//			this.groundHitbox.graphics.beginFill(0x00FF00);
			this.groundHitbox.graphics.drawRect(0, Session.application.size.y - 30, Session.application.size.x, 12);
//			this.groundHitbox.graphics.endFill();
//			this.m_ground.addChild(this.groundHitbox);
			this.worldLayer.addChild(this.m_ground);
			this.worldLayer.addChild(this.groundHitbox);
		}

		
		private function m_initSound():void {
			Session.sound.soundChannel.sources.add("winsound", BulletReign.WIN_SOUND);
			Session.sound.soundChannel.sources.add("powerup", BulletReign.POWERUP_SOUND);
			this.m_winSound = Session.sound.soundChannel.get("winsound");
			this.m_powerupSound = Session.sound.soundChannel.get("powerup");
		}
		
		
		/**
		 * m_initBackground
		 * 
		 */
		private function m_initBackground():void {
			this.m_background = new BG();
			this.m_background.scaleX = 2.5;
			this.m_background.scaleY = 2.5; 
			this.backgroundLayer.addChild(this.m_background);
		}
		
		
		/**
		 * m_initClouds
		 * 
		 */
		private function m_initClouds():void {
			for (var i:int = 0; i < 6; i++) {
				var cloud:Cloud = new Cloud();
				this.backgroundLayer.addChild(cloud);
			}
		}
		
		
		/**
		 * m_initHUDLayer
		 * 
		 */
		private function m_initHUD():void {
			this.m_hudManager = new HUDManager(this.HUDLayer);
			this.m_hudManager.add(new HUD(0, new Point(10, 10)));
			this.m_hudManager.add(new HUD(1, new Point(690, 10)));
		
		}
		
		
		/**
		 * m_initCrates
		 * 
		 */
		private function m_initCrates():void {
			this.m_crateManager = new CrateManager(this.crateLayer);
			this.m_initCrateTimer();
			//this.m_generateCrates();
			//new Point(100,0
			
		}

		
		/**
		 * update
		 * Override
		 */
		override public function update():void {
			this.m_skyCollision();
			this.m_groundCollision();
			this.m_crateGroundCollision();
			this.m_cratePlaneCollision();
			this.m_durabilityChange();
			this.m_removeInactiveBullets();
			this._updateGamemode();
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
				var timer:Timer;
				if (this.m_planes[i].hitTestObject(this.groundHitbox)) {
					if (this.m_planes[i].crashed == false) {
						this.m_planes[i].crashed = true;
						this.m_planes[i].crash(this.backgroundLayer);
						this.m_planes[i].m_newDurability = 0;
					}
				}
			}
		}
		
		//@TODO: rename
		protected function m_respawnNow():void {
			trace("NU")
			for (var i:int = 0; i < this.m_planes.length; i++) {
				this.m_planes[i].m_respawn(false);
			}
		}
		
		/*protected function m_gameOver():void {
			
		}*/
		
		/**
		 * m_crateGroundCollision
		 * 
		 */
		private function m_crateGroundCollision():void {
			if (this.m_crates != null) {
				for (var i:int = 0; i < this.m_crates.length; i++) {
					if (this.m_crates[i].hitTestObject(this.groundHitbox)) {
						if (this.m_crates[i].hitGround == false) {
							this.m_crates[i].hitGround = true;
							this.m_crates[i].m_groundCollision(this.worldLayer);
						}
					}
				}
			}
		}
		
		
		/**
		 * m_cratePlaneCllision
		 * 
		 */
		private function m_cratePlaneCollision():void {
			if (this.m_crates != null) {
				for (var i:int = 0; i < this.m_planes.length; i++) {
					for (var j:int = 0; j < this.m_crates.length; j++) {
						if (this.m_planes[i].hitTestObject(this.m_crates[j])) {
							this.m_powerupSound.play();
							if(this.m_crates[j].m_type == 0) {
								this.m_planes[i].m_noDamage = true;
								this._icons = new Icon(this.m_planes[i].m_activePlayer, this.IconLayer, new Point(30, 30), this.m_crates[j].m_type);
							}
							if(this.m_crates[j].m_type == 1) {
								this.m_planes[i].m_noFireCounter = true;
								this._icons = new Icon(this.m_planes[i].m_activePlayer, this.IconLayer, new Point(30, 30), this.m_crates[j].m_type);
							}
							if(this.m_crates[j].m_type == 2) {
								this.m_planes[i].m_noAccelDuration = true;
								this._icons = new Icon(this.m_planes[i].m_activePlayer, this.IconLayer, new Point(30, 30), this.m_crates[j].m_type);
							}
							this.m_crateManager.removeCrate(this.m_crates[j]);
							
						}
					}
				}
			}
		}
		
		
		
		
		/**
		 * m_roundOver
		 * 
		 */
		protected function m_matchOver():void {
			Session.application.displayState = new RematchMenu(this._gamemode);
		}
		
		
		/**
		 * m_durabilityChange
		 * 
		 */
		private function m_durabilityChange():void {
			for(var i:int = 0; i < this.m_planes.length; i++) {
				if (this.m_planes[i].m_newDurability <= this.m_planes[i].PLANE_DURABILITY) {
					this.m_hudManager.incrementDecrementHealth(this.m_planes[i].m_activePlayer, this.m_planes[i].m_newDurability);
				}
			}
		}
		
		protected function m_incrementWins(activePlayer:int, wins:int):void {
			this.m_hudManager.incrementWins(activePlayer, wins);
		}
		
		/**
		 * m_removeInactiveBullets
		 * 
		 */
		private function m_removeInactiveBullets():void {
//			this.m_bulletManagers
			this.m_bm1.removeInactiveBullets();
			this.m_bm2.removeInactiveBullets();
		}
		
		
		/**
		 * m_initCrateTimer
		 * 
		 */
		private function m_initCrateTimer():void {
			var timer:Timer = Session.timer.create(Math.round(Math.random()* 10000), this.m_generateCrates, 3);
		}
		
		
		/**
		 * m_generateCrates
		 * 
		 */
		private function m_generateCrates():void {
			this.m_crateSpawn = new Point(Math.floor(Math.random()* Session.application.size.x), -40); // -40 magic number, get height of crate somehow?
			this.m_crate = new Crate(this.m_crateSpawn);
			this.m_crateManager.add(this.m_crate, m_crate.m_type);
			this.m_crates = m_crateManager.getCrates();
		}
		

		//-----------------------------------------------------------
		// Protected methods
		//-----------------------------------------------------------
		
		/**
		 * _initGameMode
		 * 
		 */
		protected function _initGamemode():void {
			// To be overridden by children
		}
		
		
		/**
		 * _updateGamemode
		 * 
		 */
		protected function _updateGamemode():void {
			// To be overridden by children
		}
	}
}