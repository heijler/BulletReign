package state.gamestate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import asset.ExplosionGFX;
	import asset.GroundGFX;
	import asset.IndicatorP1GFX;
	import asset.IndicatorP2GFX;
	
	import entity.fx.FXManager;
	
	import managers.BulletManager;
	import managers.CrateManager;
	import managers.IconManager;
	import managers.PlaneManager;
	
	import objects.Cloud;
	import objects.Crate;
	import objects.plane.Plane;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	import se.lnu.stickossdk.tween.Tween;
	import se.lnu.stickossdk.util.MathUtils;
	
	import state.menustate.infoScreen.WinnerScreen;
	
	import ui.Countdown;
	import ui.HUD;
	import ui.HUDManager;
	import ui.Icon;

	//-----------------------------------------------------------
	// Gamestate
	// Represents the basic game mechanics
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
		public var explosionLayer:DisplayStateLayer;
		public var zeppelinLayer:DisplayStateLayer;
		public var HUDLayer:DisplayStateLayer;
		public var IconLayer:DisplayStateLayer;
		public var winLayer:DisplayStateLayer;
		
		public var ground:MovieClip;
		public var groundHitbox:Shape;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_crates:Vector.<Crate>;
		private var m_crate:Crate;
		private var m_crateSpawn:Point;
		private var m_icons:Vector.<Icon>;
		private var m_icon:Icon;
		private var m_iconSpawn:Point;
		private var m_bm1:BulletManager;
		private var m_bm2:BulletManager;
		private var m_im1:IconManager;
		private var m_im2:IconManager;
		private var m_sky:Shape;
		private var m_background:DisplayObject;
		private var m_hudManager:HUDManager;
		private var m_crateManager:CrateManager;
		private var m_fxMan1:FXManager;
		private var m_fxMan2:FXManager;
		private var m_ingameMusic:SoundObject;
		private var m_powerupSound:SoundObject;
		private var m_scoreText:TextField;
		private var m_planeManager:PlaneManager;
		private var m_countDown:Countdown = new Countdown();
		private var m_indicatorTimer:Timer;

		
		//-----------------------------------------------------------
		// Protected properties
		//-----------------------------------------------------------
		
		protected var _gamemode:int = 0; // 0 = Dogfight, 1 = Conquer

		protected var _planes:Vector.<Plane>;
		protected var _flashScreen:Boolean = false;
		protected var _winSound:SoundObject;
		protected var _winLimit:int = 2;
		protected var _bestOf:int = 3;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Gamestate() {
			super();
		}
		
		//-----------------------------------------------------------
		// Overrides
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
			this.m_initCountDown();
			this.m_initCrates();
			this.m_initIconManagers();
			this.m_initMusic();
			this.m_initSound();
			this._initGamemode();
			this.m_initFlash();
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
			this._updateGamemode();
			this.m_flashWorld();
		}
		
		
		/**
		 * Gamestate dispose
		 */
		override public function dispose():void {
			trace("Gamestate dispose");
			this._planes = null;
			this.m_crates = null;
			this.m_crate = null;
			this.m_crateSpawn = null;
			this.m_icons = null;
			this.m_icon = null;
			this.m_iconSpawn = null;
			this.m_bm1.dispose();
			this.m_bm1 = null;
			this.m_bm2.dispose();
			this.m_bm2 = null;
			this.m_im1.dispose();
			this.m_im1 = null;
			this.m_im2.dispose();
			this.m_im2 = null;
			this.m_sky = null;
			this.ground = null;
			this.groundHitbox = null;
			this.m_background = null;
			this.m_hudManager = null;
			this.m_crateManager.dispose();
			this.m_crateManager = null;
			this.m_fxMan1 = null;
			this.m_fxMan2 = null;
			this,m_ingameMusic = null;
			this.m_powerupSound = null;
			this._flashScreen = false;
			this.m_scoreText = null;
			this.m_planeManager.dispose();
			this.m_planeManager = null;
			this._winSound = null;
			this._winLimit = 0;
			this.m_countDown.dispose();
			this.m_countDown = null;
			Session.timer.remove(this.m_indicatorTimer);
			this.m_indicatorTimer = null;
		}
		
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		
		/**
		 * Initialize "flash in"
		 */
		private function m_initFlash():void {
			this.flash(500, 0xFFFFFF);
		}
		
		
		/**	
		 * Initialize the layers
		 */
		private function m_initLayers():void {
			this.backgroundLayer = this.layers.add("background");
			this.worldLayer = this.layers.add("world");
			this.crateLayer = this.layers.add("crate");
			this.hqLayer = this.layers.add("hq")
			this.bannerLayer = this.layers.add("banner");
			this.planeLayer = this.layers.add("plane");
			this.explosionLayer = this.layers.add("explosion");
			this.zeppelinLayer = this.layers.add("zeppelin");
			this.HUDLayer = this.layers.add("HUD");
			this.IconLayer = this.layers.add("ICON");
			this.winLayer = this.layers.add("win");
		}
		
		
		/**
		 * Initialize the music
		 */
		private function m_initMusic():void {
			if (BulletReign.rb) {
				Session.sound.musicChannel.sources.add("rbingamemusic", BulletReign.RB_INGAME_MUSIC);
				this.m_ingameMusic = Session.sound.musicChannel.get("rbingamemusic");
			} else {
				Session.sound.musicChannel.sources.add("ingamemusic", BulletReign.INGAME_MUSIC);
				this.m_ingameMusic = Session.sound.musicChannel.get("ingamemusic");
			}
			
			this.m_ingameMusic.play(int.MAX_VALUE);
			this.m_ingameMusic.volume = 0.7;
		}
		
		
		/**
		 * Initialize the planes
		 */
		private function m_initPlanes():void {
			this.m_bm1 = new BulletManager(this.planeLayer);
			this.m_bm2 = new BulletManager(this.planeLayer);
			
			this.m_planeManager = new PlaneManager(this.planeLayer);
			this.m_planeManager.add(new Plane(0, this.m_bm1, this.m_bm2, new Point(25, 250), 1, this.m_fxMan1));
			this.m_planeManager.add(new Plane(1, this.m_bm2, this.m_bm1, new Point(775, 250), -1, this.m_fxMan2));
				
			this._planes = this.m_planeManager.getPlanes();
			for(var i:int = 0; i < this._planes.length; i++) {
				this._planes[i].engineSound.play();
				this._planes[i].engineSound.volume = 0.9;
			}
			this.m_planeIndicators();
		}
		
		
		/**
		 * Crates indicator showing which player is which plane
		 * @TODO: Move Indicator to own class in ui.
		 */
		private function m_planeIndicators():void {
			for (var i:int = 0; i < this._planes.length; i++) {
				var indicator:MovieClip = this.m_createIndicator(this._planes[i].activePlayer);
					indicator.scaleX = 2;
					indicator.scaleY = 2;
					indicator.y = -20;
					indicator.name = "indicator";
				this._planes[i].addChild(indicator);
			}
			this.m_indicatorTimer = Session.timer.create(2000, this.m_fadeOutIndicators);
		}
		
		
		/**
		 * Creates the right indicator for the right plane
		 */
		private function m_createIndicator(plane:int):MovieClip {
			return new (plane ? IndicatorP2GFX : IndicatorP1GFX); 
		}
		
		
		/**
		 * Initializes tween to fade out indicators
		 */
		private function m_fadeOutIndicators():void {
			for (var i:int = 0; i < this._planes.length; i++) {
				var indicator:DisplayObject = this._planes[i].getChildByName("indicator");
				
				if (this._planes[i].contains(indicator)) {
					Session.tweener.add(indicator, {
						duration: 700,
						alpha: 0,
						onComplete: this.m_removeIndicator,
						requestParam: true
					});
				}
			}
		}
		
		
		/**
		 * Removes tween and disposes 
		 */
		private function m_removeIndicator(tween:Tween, target:DisplayObjectContainer):void {
			Session.tweener.remove(tween);
			tween = null;
			if (target.parent != null) {
				target.parent.removeChild(target);			
			}
			target = null;
		}
		
		
		/**
		 * Initializes the countdown and freezes the planes
		 */
		private function m_initCountDown():void {
			for (var i:int = 0; i < this._planes.length; i++) {
				this._planes[i].movePlane(false);
			}
			this.m_countDown.bestOf = this._bestOf;
			this.m_countDown.start(this.m_onCountdownFinish);
			this.m_countDown.x = (Session.application.size.x * 0.5) - (this.m_countDown.width * 0.5);
			this.m_countDown.y = (Session.application.size.y * 0.5) - (this.m_countDown.height * 0.5) - 20;
			this.HUDLayer.addChild(this.m_countDown);
		}
		
		
		/**
		 * When countdown is finished the planes are unfrozen
		 */
		private function m_onCountdownFinish():void {
			this.HUDLayer.removeChild(this.m_countDown);
			for(var i:int = 0; i < this._planes.length; i++) {
				this._planes[i].movePlane(true);
			}
		}
		
		
		/**
		 * Initializes FXManagers
		 */
		private function m_initFX():void {
			this.m_fxMan1 = new FXManager(this.planeLayer);
			this.m_fxMan2 = new FXManager(this.planeLayer);
		}
		
		
		/**
		 * Initializes the skyline / world upper bound
		 */
		private function m_initSky():void {
			this.m_sky = new Shape();
			this.m_sky.graphics.lineStyle(2, 0xFFFFFF);
			this.m_sky.graphics.moveTo(-50, -40);
			this.m_sky.graphics.lineTo(850, -40);
			this.worldLayer.addChild(this.m_sky);
		}
		
		
		/**
		 * Initializes the ground / world lower bound and hitbox
		 */
		private function m_initGround():void {
			this.ground = new GroundGFX();
			this.ground.scaleX = 2.5;
			this.ground.scaleY = 2.5;
			this.ground.y = Session.application.size.y - this.ground.height;
			this.ground.gotoAndStop(1);
			
			this.groundHitbox = new Shape();
			
			if (BulletReign.debug) this.groundHitbox.graphics.beginFill(0x00FF00);
			
			this.groundHitbox.graphics.drawRect(-50, Session.application.size.y - 30, Session.application.size.x + 100, 12);
			
			if (BulletReign.debug) this.groundHitbox.graphics.endFill();
			
			this.worldLayer.addChild(this.ground);
			this.worldLayer.addChild(this.groundHitbox);
		}

		
		/**
		 * Initializes sounds
		 */
		private function m_initSound():void {
			Session.sound.soundChannel.sources.add("winsound", BulletReign.WIN_SOUND);
			Session.sound.soundChannel.sources.add("powerup", BulletReign.POWERUP_SOUND);
			this._winSound = Session.sound.soundChannel.get("winsound");
			this.m_powerupSound = Session.sound.soundChannel.get("powerup");
		}
		
		
		/**
		 * Initializes background
		 */
		private function m_initBackground():void {
			this.m_background = new BG();
			this.m_background.scaleX = 2.5;
			this.m_background.scaleY = 2.5; 
			this.backgroundLayer.addChild(this.m_background);
		}
		
		
		/**
		 * Initializes clouds
		 * @TODO: Push into vector to keep disposable reference
		 */
		private function m_initClouds():void {
			for (var i:int = 0; i < 6; i++) {
				var cloud:Cloud = new Cloud();
				this.backgroundLayer.addChild(cloud);
			}
		}
		
		
		/**
		 * Initialize HUD
		 */
		private function m_initHUD():void {
			this.m_hudManager = new HUDManager(this.HUDLayer);
			this.m_hudManager.add(new HUD(0, new Point(10, 10)));
			this.m_hudManager.add(new HUD(1, new Point(690, 10)));
		}
		
		
		/**
		 * Initializes CrateManager
		 */
		private function m_initCrates():void {
			this.m_crateManager = new CrateManager(this.crateLayer);
			this.m_generateCrate();
		}
		
		
		/**
		 * Initializes iconManagers
		 */
		private function m_initIconManagers():void {
			this.m_im1 = new IconManager(this.IconLayer);
			this.m_im2 = new IconManager(this.IconLayer);
		}

		
		/**
		 * m_skyCollision
		 * When plane collides with skyline, bounce back in reflected angle from where it came in
		 */
		private function m_skyCollision():void {
			for (var i:int = 0; i < this._planes.length; i++) {
				if (this._planes[i].tailHitbox.hitTestObject(this.m_sky) || this._planes[i].bodyHitbox.hitTestObject(this.m_sky)) {
					this._planes[i].reflectAngle();
					this._planes[i].updateRotation();
				}
			}
		}
		
		
		/**
		 * m_groundCollision
		 * When plane collides with ground, cause crash
		 */
		private function m_groundCollision():void {
			for (var i:int = 0; i < this._planes.length; i++) {
				if (this._planes[i].tailHitbox.hitTestObject(this.groundHitbox) || this._planes[i].bodyHitbox.hitTestObject(this.groundHitbox)) {
					if (this._planes[i].crashed == false) {
						this._planes[i].crashed = true;
						this._planes[i].holdingBanner = false;
						this._planes[i].health = 0;
						this._planes[i].onCrash(this.backgroundLayer);
						this.m_createExplosion(this._planes[i].pos);
					}
				}
			}
		}
		
		
		/**
		 * When crate collide with ground
		 */
		private function m_crateGroundCollision():void {
			if (this.m_crates != null) {
				for (var i:int = 0; i < this.m_crates.length; i++) {
					if (this.m_crates[i].hitTestObject(this.groundHitbox)) {
						if (this.m_crates[i].hitGround == false) {
							this.m_crates[i].hitGround = true;
							this.m_crates[i].m_onGroundCollision(this.worldLayer);
						}
					}
				}
			}
		}
		
		
		/**
		 * When plane collide with Crates
		 * @TODO: Make timers disposable
		 */
		private function m_cratePlaneCollision():void {
			if (this.m_crates != null) {
				for (var i:int = 0; i < this._planes.length; i++) {
					for (var j:int = 0; j < this.m_crates.length; j++) {
						
						if ((this._planes[i].tailHitbox.hitTestObject(this.m_crates[j]) || this._planes[i].bodyHitbox.hitTestObject(this.m_crates[j])) && this._planes[i].powerUpActive == false) {
							this.m_powerupSound.play();
							this.m_powerupSound.volume = 0.7;
							this._planes[i].powerUpActive = true;
							if(this.m_crates[j].m_type == 0) {
								this._planes[i].noDamage = true;
								this.m_generateIcons(this._planes[i].activePlayer);
							}
							if(this.m_crates[j].m_type == 1) {
								this._planes[i].noFireCounter = true;
								this.m_generateIcons(this._planes[i].activePlayer);
							}
							if(this.m_crates[j].m_type == 2) {
								this._planes[i].noAccelDuration = true;
								this.m_generateIcons(this._planes[i].activePlayer);
							}
							this.m_crateManager.removeCrate(this.m_crates[j]);
							var spawnTime:int = MathUtils.randomRange(5000, 30000);
							var timer:Timer = Session.timer.create(spawnTime, this.m_generateCrate);
						}
					}
				}
			}
		}
		
		
		/**
		 * Display win message
		 * @TODO: Put this into own class in ui.
		 * @TODO: Make TextField and format disposable
		 */
		private function m_winScreen(player):void {
			var winMessage:TextField = new TextField();
			var textFormat:TextFormat = new TextFormat();
			
			for(var i:int = 0; i < this._planes.length; i++) {
					winMessage.text = "PLAYER " + (player + 1) + " IS VICTORIOUS!";
					textFormat.color = 0x000000;
			}
			
				textFormat.size = 12; 
				textFormat.font = "bulletreign";
				
				winMessage.embedFonts = true;
				winMessage.setTextFormat(textFormat);
				winMessage.defaultTextFormat = textFormat;
				winMessage.autoSize = "center";
				
				winMessage.x = (Session.application.size.x / 2) - (winMessage.width / 2);
				winMessage.y = (Session.application.size.y / 2) - (winMessage.height / 2) - 40;
			
			this.winLayer.addChild(winMessage);
		}
		
		
		/**
		 * If game is won, change displayState to WinnerScreen
		 * @TODO: Rename this method to more clearly state its purpose
		 */
		private function m_wrapItUp():void {
			for(var i:int = 0; i < this._planes.length; i++) {
				if(this._planes[i].winner == true) {
					Session.application.displayState = new WinnerScreen(this._gamemode, this._planes[i].activePlayer);
				}
			}
		}
		
		
		/**
		 * When the planes durability / health changes
		 */
		private function m_durabilityChange():void {
			for(var i:int = 0; i < this._planes.length; i++) {
				if (this._planes[i].health <= this._planes[i].PLANE_DURABILITY) {
					this.m_hudManager.incrementDecrementHealth(this._planes[i].activePlayer, this._planes[i].health);
				}
			}
		}

		
		/**
		 * Generate Crates
		 */
		private function m_generateCrate():void {
			this.m_crateSpawn = new Point(Math.floor(Math.random()* Session.application.size.x), -40);
			this.m_crate = new Crate(this.m_crateSpawn);
			this.m_crateManager.add(this.m_crate, this.m_crate.m_type);
			this.m_crates = m_crateManager.getCrates();
		}
		
		
		/**
		 * Generate power up icon HUD indicators
		 * @TODO: Make this more DRY
		 */
		private function m_generateIcons(player):void {
			var catcher:int = player;
			if(catcher == 0) {
				this.m_iconSpawn = new Point(Session.application.size.x / 35, Session.application.size.y / 10);
				this.m_icon = new Icon(this.m_iconSpawn, this.m_crates[0].m_type);
				this.m_im1.add(this.m_icon);	
			}
			if(catcher == 1) {
				this.m_iconSpawn = new Point(Session.application.size.x - 30, Session.application.size.y / 10);
				this.m_icon = new Icon(this.m_iconSpawn, this.m_crates[0].m_type);
				this.m_im2.add(this.m_icon);		
			}
		}
		
		
		/**
		 * Flash the world / screen on plane shotdown
		 * Uses flag since this is called in update
		 */
		private function m_flashWorld():void {
			for (var i:int = 0; i < this._planes.length; i++) {
				if (this._planes[i].shotDown && !this._flashScreen) {
					this.flash(200, 0xFFFFFF); //0xFFF392
					this._flashScreen = true;
				}
			}
		}
		
		
		/**
		 * Creates an explosion graphic at a position
		 * Uses the undocumentet addFrameScript to only play the movieClip once. 
		 * This is used instead of adding the code to the last frame of the movieClip
		 * to keep all code in one place. Placing it in the MovieClip might be cleaner, 
		 * but this is more clear and not hidden.
		 * @TODO: Make explosion disposable
		 */
		private function m_createExplosion(pos:Point):void {
			var explosion:ExplosionGFX = new ExplosionGFX;
				explosion.gotoAndPlay(1);
				explosion.addFrameScript(explosion.totalFrames - 1, function():void {
					explosion.stop();
				});
				explosion.scaleX = explosion.scaleY = 2.5;
				explosion.x = pos.x;
				explosion.y = pos.y;
			this.explosionLayer.addChild(explosion);
		}
		
		
		//-----------------------------------------------------------
		// Protected methods
		//-----------------------------------------------------------
		
		
		/**
		 * Overridden by child classes
		 */
		protected function _initGamemode():void {
			// To be overridden by children
		}
		
		
		/**
		 * Overridden by child classes
		 */
		protected function _updateGamemode():void {
			// To be overridden by children
		}
		
		
		/**
		 * Increment score for a plane/player
		 */
		protected function _incrementWins(activePlayer:int, wins:int):void {
			this.m_hudManager.incrementWins(activePlayer, wins);
		}
		
		
		/**
		 * Remove score message
		 */
		protected function _scoreMessageRemove():void {
			if(this.winLayer.contains(this.m_scoreText)) {
				this.winLayer.removeChild(this.m_scoreText);
			}
		}
		
		
		/**
		 * Display Score message
		 * @TODO: Put this into own class in ui.
		 * @TODO: Make timer disposable
		 * @TODO: Make textFormat disposable
		 */
		protected function m_scoreMessage(player:int):void {
			this.m_scoreText = new TextField();
			var textFormat:TextFormat = new TextFormat();
			this.m_scoreText.text = "PLAYER " + (player + 1) + " SCORES!";
			textFormat.color = 0x000000;
			
			textFormat.size = 12; 
			textFormat.font = "bulletreign";
			
			this.m_scoreText.embedFonts = true;
			this.m_scoreText.setTextFormat(textFormat);
			this.m_scoreText.defaultTextFormat = textFormat;
			this.m_scoreText.autoSize = "center";
			
			this.m_scoreText.x = (Session.application.size.x / 2) - (this.m_scoreText.width / 2);
			this.m_scoreText.y = (Session.application.size.y / 2) - (this.m_scoreText.height / 2) - 40;
			
			this.winLayer.addChild(this.m_scoreText);
			
			var timer:Timer = Session.timer.create(2000, this._scoreMessageRemove);
		}
		
		
		/**
		 * When match is over
		 * @TODO: Make timer disposable
		 */
		protected function _matchOver(player):void {
			var timer:Timer = Session.timer.create(2000, this.m_wrapItUp);
			this.m_winScreen(player);
		}
		
		
		/**
		 * Respawn planes
		 */
		protected function m_respawnNow():void {
			for (var i:int = 0; i < this._planes.length; i++) {
				this._planes[i].onRespawn(false);
			}
			this._flashScreen = false;
			this.m_im1.m_remove();
			this.m_im2.m_remove();
		}
		
		
		/**
		 * Respawns one plane (used if one plane crashes and gamemode rules dictate crash is allowed)
		 */
		protected function _respawnPlane(player:int):void {
			for (var i:int = 0; i < this._planes.length; i++) {
				if (this._planes[i].activePlayer == player) {
					this._planes[i].onRespawn(false);
				}
			}
		}
	}
}