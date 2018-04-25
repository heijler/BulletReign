package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import asset.CrateGFX;
	
	//-----------------------------------------------------------
	// Crate
	//-----------------------------------------------------------
	public class Crate extends MotionEntity {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		public const SPEED_BOOST:Number = 1; // SpeedCrates
		public const ARMOR_BOOST:Number = 1; // ArmorCrates
		public const FIREPOWER:Number = 1; // FirepowerCrates
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_skin:MovieClip;
		
		public function Crate(pos:Point) {
			super();
			this.m_pos = pos;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**	
		 * init
		 * Override.
		 */
		override public function init():void {
			this.m_initSkin();
			this.m_setSpawnPosition();
		}
		
		/**	
		 * m_initSkin
		 * Initialize skin
		 */
		private function m_initSkin():void {
			
			this.m_skin = new CrateGFX;
			this.m_skin.gotoAndStop(1);
			this._setScale(this.m_skin, 2, 2);
			
			this.m_skin.cacheAsBitmap = true;
			this.addChild(this.m_skin);
		}
		
		/**
		 * m_setSpawnPosition
		 * 
		 */
		private function m_setSpawnPosition():void {
			this.x = this.m_pos.x;
			this.y = this.m_pos.y;
		}
		
		/**	
		 * update
		 * override, gameloop
		 */
		override public function update():void {
			this.applyGravity();
			this.m_collisionControl();
		}
		
		
		/**
		 * 
		 */
		override public function dispose():void {
			trace("Dispose Crate! REMOVE ME WHEN ACTUALLY DISPOSING.");
		}
		
		private function m_collisionControl():void {
			this.m_planeCollision();
			this.m_groundCollision();
		}
		
		private function m_planeCollision():void {
			
		}
		
		private function m_groundCollision():void {
			
		}
	}
}