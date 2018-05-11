package state.gamestate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.Shape;
	import flash.geom.Point;
	
	import entity.Banner;
	import entity.Plane;
	import entity.Zeppelin;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	
	//-----------------------------------------------------------
	// Conquer
	//-----------------------------------------------------------
	
	public class Conquer extends Gamestate {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		public var hqLayer:DisplayStateLayer;
		public var zeppelinLayer:DisplayStateLayer;
		public var bannerLayer:DisplayStateLayer;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_zeppelin:Zeppelin;
		private var m_banner:Banner;
		private var m_bannerHolder:Plane;
		private var m_angleCounter:int = 30;
		
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
			trace("init conquer");
			this.m_initLayers();
			this.m_initZeppelin();
			this.m_initBanner();
			
		}
		
		
		/**
		 * m_initLayers
		 * 
		 */
		private function m_initLayers():void {
			this.hqLayer = this.layers.add("hq")
			this.bannerLayer = this.layers.add("banner");
			this.zeppelinLayer = this.layers.add("zeppelin");
		}
		
		
		/**
		 * m_indicateBase
		 * @param base = "left" | "right"
		 */
		private function m_indicateBase():void {
//			var frame:int = this.m_bannerHolder.m_activePlayer;
//			if (frame == 0) {
//				frame = 2;
//			} else if (frame == 1) {
//				frame = 3;
//			}
			if (this.m_bannerHolder) {
				this.m_ground.gotoAndStop(this.m_bannerHolder.m_activePlayer + 2);
			} else {
				this.m_ground.gotoAndStop(1);
			}
			
		}
		
		
		/**
		 * 
		 */
		private function m_indicateHitbox():void {
			var leftGroundHitbox:Shape = new Shape();
				leftGroundHitbox.graphics.beginFill(0xFF0000);
				leftGroundHitbox.graphics.drawRect(0, 8, 60, 12);
				leftGroundHitbox.graphics.endFill();
			this.m_ground.addChild(leftGroundHitbox);
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
			this.m_banner = new Banner(new Point(Session.application.size.x*0.5, 0));
			this.bannerLayer.addChild(this.m_banner);
		}
		
		
		/**
		 * _updateGamemode
		 * Method that is run on gameloop, overrides the method in the parentclass
		 */
		override protected function _updateGamemode():void {
//			trace("update conquer");
			
			// in it's own method
			if (this.m_zeppelin.atDefaultPos) {
				this.m_banner.showBanner();
			}
			
			this.m_bannerPlaneCollision();
			this.m_bannerFollow();
			
		}
		
		
		/**
		 * m_bannerPlaneCollision
		 * 
		 */
		private function m_bannerPlaneCollision():void {
			for (var i:int = 0; i < this.m_planes.length; i++) {
				if(this.m_banner.hitBox.hitTestObject(this.m_planes[i]) && !this.m_banner.caught) {
					trace("collide");
					this.m_banner.caught = true;
					this.m_bannerHolder = this.m_planes[i];
					this.m_indicateBase();
					//this._drawGroundHitbox(); @TODO:!
					this.m_indicateHitbox();
				}
			}
		}
		
		/**
		 * m_bannerFollow
		 * 
		 */
		private function m_bannerFollow():void {
			if (this.m_banner.caught) {
				this.m_banner.follow(this.m_bannerHolder.m_getPos(), this.m_bannerHolder.angle, this.m_bannerHolder.scaleFactor);
			}
		}		
	}
}