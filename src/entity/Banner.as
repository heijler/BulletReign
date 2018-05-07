package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.geom.Point; 
	
	import asset.BannerGFX;
	
	import se.lnu.stickossdk.system.Session;
	
	
	//-----------------------------------------------------------
	// Banner
	//-----------------------------------------------------------
	
	public class Banner extends MotionEntity {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_skin:MovieClip;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Banner(pos:Point) {
			super();
			this.m_pos = pos;
			this.m_initSkin();
			this.m_setSpawnPosition();
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		
		public function showBanner():void {
			Session.tweener.add(this, {
				duration: 200,
				y: 50
			});
		}
		
		/**
		 * init
		 * 
		 */
		override public function init():void {
			trace("initBanner");
			this.m_initSkin();
		}
		
		
		/**
		 * 
		 */
		private function m_initSkin():void {
			trace("m_initSkin");
			this.m_skin = new BannerGFX;
			this._setScale(this.m_skin, 2, 2);
			this.addChild(this.m_skin);
		}
		
		
		/**
		 * 
		 */
		private function m_setSpawnPosition():void {
			this.x = this.m_pos.x;
			this.y = this.m_pos.y - this.m_skin.height;
		}
		
		
		/**
		 * update
		 * 
		 */
		override public function update():void {
//			trace("Banner update");
		}
		
		
		/**
		 * dispose
		 * 
		 */
		override public function dispose():void {
			trace("Dispose Banner! REMOVE ME WHEN ACTUALLY DISPOSING.");
		}
	}
}