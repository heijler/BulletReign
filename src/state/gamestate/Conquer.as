package state.gamestate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.Shape;
	import flash.geom.Point;
	
	import entity.Banner;
	import entity.Plane;
	import entity.Zeppelin;
	
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
		private var m_winFlag:Boolean = false;
		
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
			this.m_drawGHB();
			
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
		 * m_drawGHB
		 * 
		 */
		private function m_drawGHB():void {
			this.m_GHB = new Shape();
//			this.m_GHB.graphics.beginFill(0xFF0000, 0.5);
			this.m_GHB.graphics.drawRect(0, Session.application.size.y-30, 160, 30);
//			this.m_GHB.graphics.endFill();
			this.m_GHB.name = "GHB";
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
//			this.m_banner = new Banner(new Point(Session.application.size.x*0.5, 0));
//			this.bannerLayer.addChild(this.m_banner);
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
			this.m_banner = new Banner(new Point(Session.application.size.x * 0.5, 0));
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
			this.m_bannerPlaneCollision();
			this.m_bannerGroundCollision();
			this.m_bannerFollow();
			this.m_onBannerDrop();
			this.m_resolveRound();
//			this.m_wrapBanner();
		}
		
		
		/**
		 * m_bannerPlaneCollision
		 * 
		 */
		private function m_bannerPlaneCollision():void {
			for (var i:int = 0; i < this.m_planes.length; i++) {
				if(this.m_banner.hitBox.hitTestObject(this.m_planes[i]) && !this.m_banner.caught) {
					this.m_banner.caught = true;
					this.m_bannerHolder = this.m_planes[i];
					this.m_bannerHolder.holdingBanner = true;
					this.m_banner.lastHolder = this.m_planes[i];
					this.m_indicateHitbox();
					this.m_indicateBase(this.m_planes[i].m_activePlayer);
				}
			}
		}
		
		
		/**
		 * m_bannerGroundCollision
		 * 
		 */
		private function m_bannerGroundCollision():void {
			if (this.m_banner.hitTestObject(this.m_GHB) && this.m_banner.onGround == false && this.m_bannerHolder == null) {
				this.m_banner.onGround = true;
				this.m_indicateBase(this.m_banner.lastHolder.m_activePlayer);
				this.m_winSound.play();
				this.m_banner.lastHolder.wins++;
				this.m_incrementWins(this.m_banner.lastHolder.m_activePlayer, this.m_banner.lastHolder.wins);
				this.m_resolveGame();
				var timer:Timer = Session.timer.create(1000, this.m_respawn);
//				this.m_respawn();
			}
		}
		
		
		/**
		 * 
		 */
		private function m_bannerGroundColl():void {
			if (this.m_banner.hitTestObject(this.m_ground) && this.m_banner.onGround == false) {
				trace("onGround");
			}
		}
		
		
		/**
		 * m_respawn
		 * 
		 */
		private function m_respawn():void {
//			trace("matchfin", this.m_matchFin);
			if (this.m_matchFin == false) {
				this.m_respawnNow();
				this.m_respawnBanner();
			}
		}
		
		
		/**
		 * m_respawnBanner
		 * 
		 */
		private function m_respawnBanner():void {
			this.m_removeBanner();
			this.m_addBanner();
		}
		
		
		
		/**
		 * m_bannerFollow
		 * 
		 */
		private function m_bannerFollow():void {
			if (this.m_banner.caught) {
				this.m_banner.follow(this.m_bannerHolder.m_getPos(), this.m_bannerHolder.angle, this.m_bannerHolder.scaleFactor, this.m_bannerHolder.velocity);
			}
		}
		
		
		/**
		 * m_bannerDrop
		 * 
		 */
		private function m_onBannerDrop():void {
			if (this.m_bannerHolder && this.m_bannerHolder.holdingBanner == false) {
				this.m_dropBanner();
			}
		}
		
		
//		/**
//		 * 
//		 */
//		private function m_wrapBanner():void {
//			if (this.m_banner.y > Session.application.size.y) {
//				this.m_banner.y = 0;
//			}
//		}
		
		
		/**
		 * m_resolveGame
		 * 
		 */
		private function m_resolveGame():void {
			for(var i:int = 0; i < this.m_planes.length; i++) {
				if(this.m_planes[i].wins == this._winLimit) {
					this.m_matchFin = true;
					var timer:Timer = Session.timer.create(3000, this.m_matchOver);
				}
			}
		}
		
		
		/**
		 * 
		 */
		private function m_resolveRound():void {
			for(var i:int = 0; i < this.m_planes.length; i++) {
				if(this.m_planes[i].crashed) {
					for(var j:int = 0; j < this.m_planes.length; j++) {
						if(this.m_planes[j].crashed == false) {							
							if(this.m_winFlag == false) {
								this.m_respawn();
								this.m_winFlag = true;
							}
						}
					}
				}
				if(this.m_planes[0].crashed == true && this.m_planes[1].crashed == true && this.m_winFlag == false) {
					var dimer:Timer = Session.timer.create(3000, this.m_respawn);
					this.m_winFlag = true;
				}
			}
		}
		
		
		/**
		 * m_dropBanner
		 * 
		 */
		private function m_dropBanner():void {
			this.m_banner.caught = false;
			this.m_bannerHolder = null;
			this.m_indicateBase();
			this.m_banner.gravity = true;
			if (this.m_banner.onGround) {
				this.m_banner.gravity = false;
			}
		}
	}
}