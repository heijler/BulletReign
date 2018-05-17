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
		 * m_initSkin
		 * 
		 */
		private function m_initSkin():void {
			this.m_skin = new SmallCloudsGFX();
			this._setScale(this.m_skin, 4 * this.m_seed, 4 * this.m_seed);
			this.m_skin.gotoAndStop(Math.round(Math.random()) + 1);
			this.addChild(this.m_skin);
		}
		
		
		/**
		 * m_setSpawnPosition
		 * 
		 */
		private function m_setSpawnPosition():void {
			this.x = Math.random() * Session.application.size.x - this.width;
			this.y = Math.random() * 250;
		}
		
		
		/**
		 * m_initSeed
		 * 
		 */
		private function m_initSeed():void {
			this.m_seed = Math.random();
		}
		
		
		/**
		 * update
		 * override
		 */
		public override function update():void {
			this.m_updatePosition();
		}
		
		
		/**
		 * m_updatePosition
		 * 
		 */
		private function m_updatePosition():void {
			this.x += this.m_seed * 0.4;
			this.wrapAroundObjects();
		}
		
		
		/**
		 * dispose
		 * override
		 */
		public override function dispose():void {
			trace("Dispose Cloud! REMOVE ME WHEN ACTUALLY DISPOSING");
		}
	}
}