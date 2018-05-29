package objects {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	import flash.display.MovieClip;
	
	import asset.SmallCloudsGFX;
	
	import se.lnu.stickossdk.system.Session;
	import entity.MotionEntity;
	
	
	//-----------------------------------------------------------
	// Cloud
	// Handles an instance of a cloud
	//-----------------------------------------------------------
	
	public class Cloud extends MotionEntity {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		private var m_skin:MovieClip;
		private var m_seed:Number;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		public function Cloud() {
			super();
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		
		/**
		 * init
		 * override
		 */
		public override function init():void {
			this.m_initSeed();
			this.m_initSkin();
			this.m_setSpawnPosition();
			
		}
		
		/**
		 * dispose
		 * override
		 */
		public override function dispose():void {
			trace("Cloud dispose");
			if (this.m_skin.parent != null) {
				this.removeChild(this.m_skin);
			}
			this.m_skin = null;
			this.m_seed = 0;
		}
		
		/**
		 * update
		 * override
		 */
		public override function update():void {
			this.m_updatePosition();
		}
		
		/**
		 * Initialize cloud skin
		 * 
		 */
		private function m_initSkin():void {
			this.m_skin = new SmallCloudsGFX();
			this.setScale(this.m_skin, 4 * this.m_seed, 4 * this.m_seed);
			this.m_skin.gotoAndStop(Math.round(Math.random()) + 1);
			this.addChild(this.m_skin);
		}
		
		
		/**
		 * Set cloud spawnposition
		 * 
		 */
		private function m_setSpawnPosition():void {
			this.x = Math.random() * Session.application.size.x - this.width;
			this.y = Math.random() * 250;
		}
		
		
		/**
		 * Initialize seed
		 * 
		 */
		private function m_initSeed():void {
			this.m_seed = Math.random();
		}
		
		/**
		 * Updates cloud position
		 * 
		 */
		private function m_updatePosition():void {
			this.x += this.m_seed * 0.4;
			this.wrapAroundObjects();
		}
		
	}
}