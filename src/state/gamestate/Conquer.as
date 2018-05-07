package state.gamestate {
	import flash.geom.Point;
	
	import entity.Banner;
	import entity.Zeppelin;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.system.Session;
	

	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
//	import se.lnu.stickossdk.display.DisplayState;
	
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
			this.m_initBases();
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
		 * m_initBases
		 * 
		 */
		private function m_initBases():void {
			
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
			if (this.m_zeppelin.atDefaultPos) {
				this.m_banner.showBanner();
			}
		}
		
		
	}
}