package state.gamestate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.Shape;
	import flash.geom.Point;
	
	import objects.Banner;
	import objects.Plane;
	import objects.Zeppelin;
	
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	
	//-----------------------------------------------------------
	// Conquer
	//-----------------------------------------------------------
	
	public class Conquer extends Gamestate {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_zeppelin:Zeppelin;
		private var m_banner:Banner;
		private var m_bannerHolder:Plane;
		private var m_angleCounter:int = 30;
		private var m_matchFin:Boolean = false;
		private var m_GHB:Shape;
		private var m_b1HB:Shape;
		private var m_b2HB:Shape;
		private var m_winFlag:Boolean = false;
		private var m_crashedPlane:int;
		private var m_blinktimer:Timer;
		private var m_respawnBlinkTimer:Timer;
		private var m_callWinner:Boolean = false;
		private var m_bannerPickupSound:SoundObject;
		private var m_bannerDropSound:SoundObject;
		private var m_bannerLandSound:SoundObject;
		private var m_bannerRespawnSound:SoundObject;
		private var m_recentlyStolen:Boolean = false;
		private var m_respawnPlaneTimer:Timer;
		private var m_respawnTimer:Timer;
		private var m_stealTimer:Timer;
		private var m_respawnDelay:Timer;
		private var m_respawnBannerDelay:Timer;
		private var m_oOBRespawnTimer:Timer;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Conquer() {
			super();
			this._gamemode = 1;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**
		 * _initGamemode
		 * Initializes the gamemode, this method overrides the method in the parentclass
		 */
		override protected function _initGamemode():void {
			this.m_initZeppelin();
			this.m_initBanner();
			this.m_initHitboxes();
			this.m_initSounds();
			this.m_planes[0].m_newDurability = 3;
			this.m_planes[1].m_newDurability = 3;
		}
		
		
		/**
		 * m_indicateBase
		 */
		private function m_indicateBase(player:int = -1):void {
			if (player !== -1) {
				this.m_ground.gotoAndStop(player + 2);
			}else {
				this.m_ground.gotoAndStop(1);
			}
		}
		
		
		/**
		 * 
		 */
		private function m_initHitboxes():void {
			this.m_drawGHB();
			this.m_drawBaseHB();
		}
		
		
		/**
		 * 
		 */
		private function m_drawBaseHB():void {
			this.m_b1HB = new Shape();
			this.m_b2HB = new Shape();

			
			if (BulletReign.debug) {
				this.m_b1HB.graphics.beginFill(0x00FF00, 0.5);
				this.m_b2HB.graphics.beginFill(0x0000FF, 0.5);
			}
			this.m_b1HB.graphics.drawRect(0, Session.application.size.y - 30, 160, 30);
			this.m_b2HB.graphics.drawRect(Session.application.size.x - this.m_GHB.width, Session.application.size.y - 30, 160, 30);
			
			if (BulletReign.debug) {
				this.m_b1HB.graphics.endFill();
				this.m_b2HB.graphics.endFill();
			}
				
			this.hqLayer.addChild(this.m_b1HB);
			this.hqLayer.addChild(this.m_b2HB);
		}
		
		/**
		 * m_drawGHB
		 * 
		 */
		private function m_drawGHB():void {
			this.m_GHB = new Shape();
			
			// Debug
			if (BulletReign.debug) this.m_GHB.graphics.beginFill(0xFF0000);	
			
			this.m_GHB.graphics.drawRect(0, Session.application.size.y-30, 160, 30);
			
			// Debug
			if (BulletReign.debug) this.m_GHB.graphics.endFill();
			
			this.hqLayer.addChild(this.m_GHB);
		}
		
		
		/**
		 * m_disposeGHB
		 * 
		 */
		private function m_disposeGHB():void {
			if (this.hqLayer.contains(this.m_GHB)) {
				this.hqLayer.removeChild(this.m_GHB);
				this.m_GHB = null;
			}
		}
			
		
		
		/**
		 * m_indicateHitBox
		 * 
		 */
		private function m_indicateHitbox():void {
			this.m_GHB.x = (this.m_bannerHolder.m_activePlayer) ? Session.application.size.x - this.m_GHB.width : 0;
		}
		
		
		/**
		 * m_initSounds
		 * 
		 */
		private function m_initSounds():void {
			Session.sound.soundChannel.sources.add("bannerpickup", BulletReign.BANNER_PICKUP);
			Session.sound.soundChannel.sources.add("bannerdrop", BulletReign.BANNER_DROP);
			Session.sound.soundChannel.sources.add("bannerland", BulletReign.BANNER_LAND);
			Session.sound.soundChannel.sources.add("bannerrespawn", BulletReign.BANNER_RESPAWN);
			this.m_bannerPickupSound = Session.sound.soundChannel.get("bannerpickup");
			this.m_bannerDropSound = Session.sound.soundChannel.get("bannerdrop");
			this.m_bannerLandSound = Session.sound.soundChannel.get("bannerland");
			this.m_bannerRespawnSound = Session.sound.soundChannel.get("bannerrespawn");
		}
		
		
		/**
		 * m_initZeppelin
		 * 
		 */
		private function m_initZeppelin():void {
			this.m_zeppelin = new Zeppelin(new Point(-200, 200));
			this.zeppelinLayer.addChild(this.m_zeppelin);
			
		}
		
		
		/**
		 * m_initBanner
		 * 
		 */
		private function m_initBanner():void {
			this.m_addBanner();
		}
		
		
		/**
		 * m_removeBanner
		 */
		private function m_removeBanner():void {
			if (this.bannerLayer.contains(this.m_banner)) {
				this.bannerLayer.removeChild(this.m_banner);
			}
			this.m_banner = null;
		}
		
		
		/**
		 * m_addBanner
		 * 
		 */
		private function m_addBanner():void {
			this.m_banner = new Banner(new Point(Session.application.size.x * 0.5, -50));
			this.m_bannerHolder = null;
			this.bannerLayer.addChild(this.m_banner);
		}
		
		
		/**
		 * _updateGamemode
		 * Method that is run on gameloop, overrides the method in the parentclass
		 */
		override protected function _updateGamemode():void {
			if (this.m_zeppelin.atDefaultPos && !this.m_banner.active) {
				this.m_banner.showBanner();
			}
			
			if (this.m_bannerHolder != null) {
				this.m_planesBannerSwitch();
			}
			
			this.m_bannerPlaneCollision();
			this.m_bannerBaseCollision();
			this.m_bannerInactiveBaseCollision();
			this.m_bannerGroundCollision();
			this.m_bannerFollow();
			this.m_onBannerDrop();
			this.m_resolveRound();
			this.m_bannerOutOfBounds();
		}
		
		
		/**
		 * m_bannerPlaneCollision
		 * 
		 */
		private function m_bannerPlaneCollision():void {
			for (var i:int = 0; i < this.m_planes.length; i++) {
				if((this.m_banner.hitBox.hitTestObject(this.m_planes[i].tailHitbox) || this.m_banner.hitBox.hitTestObject(this.m_planes[i].bodyHitbox) ) && !this.m_banner.caught && !this.m_planes[i].crashed && this.m_banner.active) {
					Session.timer.remove(this.m_blinktimer);
					Session.timer.remove(this.m_respawnBlinkTimer);
					this.m_banner.caught = true;
					this.m_banner.gravity = true;
					this.m_banner.onGround = false;
					this.m_banner.onBase = false;
					this.m_bannerHolder = this.m_planes[i];
					this.m_bannerHolder.holdingBanner = true;
					this.m_banner.lastHolder = this.m_planes[i];
					this.m_indicateHitbox();
					this.m_indicateBase(this.m_planes[i].m_activePlayer);
					this.m_bannerPickupSound.play();
					this.m_bannerPickupSound.volume = 0.5;
				}
				
			}
		}
		
		private function m_planesBannerSwitch():void {
				if(this.m_planes[1].bodyHitbox.hitTestObject(this.m_planes[0].tailHitbox) && this.m_recentlyStolen == false && this.m_planes[1].holdingBanner == false) {
					this.m_bannerHolder = this.m_planes[1];
					this.m_banner.lastHolder = this.m_planes[1];
					this.m_indicateBase(this.m_planes[1].m_activePlayer);
					this.m_indicateHitbox();
					this.m_recentlyStolen = true;
					this.m_planes[1].holdingBanner = true;
					this.m_planes[0].holdingBanner = false;
					this.m_bannerDropSound.play();
					this.m_bannerDropSound.volume = 0.5;
					this.m_stealTimer = Session.timer.create(1000, this.m_resetSteal);
					this.m_stealTimer = null;
				}
				if(this.m_planes[0].bodyHitbox.hitTestObject(this.m_planes[1].tailHitbox) && this.m_recentlyStolen == false && this.m_planes[0].holdingBanner == false) {
					this.m_bannerHolder = this.m_planes[0];
					this.m_banner.lastHolder = this.m_planes[0];
					this.m_indicateBase(this.m_planes[0].m_activePlayer);
					this.m_indicateHitbox();
					this.m_recentlyStolen = true;
					this.m_planes[0].holdingBanner = true;
					this.m_planes[1].holdingBanner = false;
					this.m_bannerDropSound.play();
					this.m_bannerDropSound.volume = 0.5;
					this.m_stealTimer = Session.timer.create(1000, this.m_resetSteal);
					this.m_stealTimer = null;
				}
			
		}
		
		private function m_resetSteal():void {
			this.m_recentlyStolen = false;
		}
		/**
		 * m_bannerBaseCollision
		 * 
		 */
		private function m_bannerBaseCollision():void {
			if (this.m_banner.hitBox.hitTestObject(this.m_GHB) && this.m_banner.onBase == false && this.m_bannerHolder == null && !this.m_banner.lastHolder.crashed) {
				this.m_banner.onBase = true;
				this.m_indicateBase(this.m_banner.lastHolder.m_activePlayer);
				this.m_winSound.play();
				this.m_banner.lastHolder.wins++;
				this.m_scoreMessage(this.m_banner.lastHolder.m_activePlayer);
				this.m_incrementWins(this.m_banner.lastHolder.m_activePlayer, this.m_banner.lastHolder.wins);
				this.m_resolveGame();
				this.m_respawnDelay = Session.timer.create(3000, this.m_respawn);
			}
		}
		
		
		/**
		 * m_bannerGroundCollision
		 * @TODO: 
		 */
		private function m_bannerGroundCollision():void {
			if (this.m_banner.hitBox.hitTestObject(this.groundHitbox) && this.m_banner.onGround == false && this.m_bannerHolder == null) {
				this.m_banner.onGround = true;
				this.m_bannerLandSound.play();
				this.m_bannerLandSound.volume = 1;
				if (!this.m_banner.onBase) {
					this.m_blinktimer = Session.timer.create(1500, this.m_onGroundCount);
				}
			}
		}
		
		
		/**
		 * 
		 */
		private function m_bannerInactiveBaseCollision():void {
			if ((this.m_banner.hitBox.hitTestObject(this.m_b1HB) || this.m_banner.hitBox.hitTestObject(this.m_b2HB)) && !this.m_banner.onBase) {
				this.m_respawnBannerDelay = Session.timer.create(500, this.m_respawnBanner);
			}
		}
		
		
		/**
		 * 
		 */
		private function m_onGroundCount():void {
			if (!this.m_banner.onBase) {
				this.m_banner.blink();
				this.m_respawnBlinkTimer = Session.timer.create(2000, this.m_respawnBanner);
			}
			
		}
		
		
		/**
		 * m_respawn
		 * 
		 */
		private function m_respawn():void {
			if (this.m_matchFin == false) {
				this.m_respawnNow();
				this.m_planes[0].m_newDurability = 3;
				this.m_planes[1].m_newDurability = 3;
				this.m_respawnBanner();
				this.m_winFlag = false;
			}
		}
		
		
		/**
		 * m_respawnPlane
		 * 
		 */
		private function m_respawnPlane():void {
			if (this.m_matchFin == false) {
				this._respawnPlane(this.m_crashedPlane);
				this.m_planes[this.m_crashedPlane].m_newDurability = 3;
				this.m_winFlag = false;
			}
		}
		
		
		/**
		 * m_respawnBanner
		 * 
		 */
		private function m_respawnBanner():void {
			this.m_bannerRespawnSound.play();
			this.m_bannerRespawnSound.volume = 0.5;
			this.m_removeBanner();
			this.m_addBanner();
			this.m_indicateBase(-1);
		}
		
		
		/**
		 * m_bannerFollow
		 * 
		 */
		private function m_bannerFollow():void {
			if (this.m_banner.caught && this.m_bannerHolder && !this.m_banner.onBase) {
				this.m_banner.follow(this.m_bannerHolder.pos, this.m_bannerHolder.angle, this.m_bannerHolder.scaleFactor, this.m_bannerHolder.velocity);
			}
		}
		
		
		/**
		 * m_bannerDrop
		 * 
		 */
		private function m_onBannerDrop():void {
			if (this.m_bannerHolder && this.m_bannerHolder.holdingBanner == false && this.m_banner.active) {
				this.m_dropBanner();
				this.m_bannerDropSound.play();
				this.m_bannerDropSound.volume = 0.5;
			}
		}
		
		
		/**
		 * 
		 */
		private function m_bannerOutOfBounds():void {
			if (this.m_banner.outOfBounds) {
				this.m_oOBRespawnTimer = Session.timer.create(1000, this.m_respawnBanner);
			}
		}
		
		
		/**
		 * m_resolveGame
		 * 
		 */
		private function m_resolveGame():void {
			for(var i:int = 0; i < this.m_planes.length; i++) {
				if(this.m_planes[i].wins == this._winLimit) {
					this.m_matchFin = true;
					this.m_planes[i].m_winner = true;
					if(this.m_callWinner == false) {
						this.m_scoreMessageRemove();
						this.m_matchOver(this.m_planes[i].m_activePlayer);
					}
					this.m_callWinner = true;
				}
			}
		}
		
		
		/**
		 * m_resolveRound
		 * 
		 */
		private function m_resolveRound():void {
			for(var i:int = 0; i < this.m_planes.length; i++) {
				if(this.m_planes[i].crashed) {
					for(var j:int = 0; j < this.m_planes.length; j++) {
						if(this.m_planes[j].crashed == false) {
							if(this.m_winFlag == false) {
								this.m_crashedPlane = this.m_planes[i].m_activePlayer;
								this.m_winFlag = true;
								this.m_respawnPlaneTimer = Session.timer.create(1000, this.m_respawnPlane);
							}
						}
					}
				}
				if(this.m_planes[0].crashed == true && this.m_planes[1].crashed == true && this.m_winFlag == false && !this.m_banner.onBase) {
					this.m_respawnTimer = Session.timer.create(1000, this.m_respawn);
					this.m_winFlag = true;
				}
			}
		}
		
		
		/**
		 * m_dropBanner
		 * 
		 */
		private function m_dropBanner():void {
			Session.timer.create(100, this.m_toggleBanner);
			this.m_bannerHolder = null;
			
			this.m_indicateBase();
			this.m_banner.gravity = true;
			
			if (this.m_banner.onBase) {
				this.m_banner.gravity = false;
			}
			
			if (this.m_banner.onGround) {
				this.m_banner.gravity = false;
			}
		}
		
		
		/**
		 * 
		 */
		private function m_toggleBanner():void {
			this.m_banner.caught = !this.m_banner.caught;
		}
		
		override public function dispose():void {
			this.m_zeppelin = null;
			this.m_banner = null;
			this.m_bannerHolder = null;
			this.m_angleCounter = 0;
			this.m_matchFin = false;
			this.m_GHB = null;
			this.m_b1HB = null;
			this.m_b2HB = null;
			this.m_winFlag = false;
			this.m_crashedPlane = 0;
			Session.timer.remove(m_blinktimer);
			this.m_respawnBlinkTimer = null;
			this.m_callWinner = false;
			this.m_bannerPickupSound = null;
			this.m_bannerDropSound = null;
			this.m_bannerLandSound = null;
			this.m_bannerRespawnSound = null;
			this.m_recentlyStolen = false;
			Session.timer.remove(this.m_respawnPlaneTimer);
			this.m_respawnPlaneTimer = null;
			Session.timer.remove(this.m_respawnTimer);
			this.m_respawnTimer = null;
			Session.timer.remove(this.m_stealTimer);
			this.m_stealTimer = null;
			Session.timer.remove(this.m_respawnDelay);
			this.m_respawnDelay = null;
			Session.timer.remove(this.m_respawnBannerDelay);
			this.m_respawnBannerDelay = null;
			Session.timer.remove(this.m_oOBRespawnTimer);
			this.m_oOBRespawnTimer = null;
		}
	}
}