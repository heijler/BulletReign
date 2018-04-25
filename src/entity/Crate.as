package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import asset.CrateGFX;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	
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
		public var hitGround:Boolean = false;
		private var m_type:Number;
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_skin:MovieClip;
		
		public function Crate(pos:Point, type:Number) {
			super();
			this.m_pos = pos;
			this.m_type = type;
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
			this.m_skin.gotoAndStop(this.m_type);
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
			this.checkFrames();
		}
		
		
		private function m_planeCollision():void {
			
		}
		
		public function m_groundCollision(layer:DisplayStateLayer):void {
				this.removeGravity();
				this._shake(layer, 5);
				this._flicker(this, 500);
				this.m_skin.gotoAndPlay(this.m_type);
		}
		
		private function checkFrames():void {
			if (hitGround == true) {
				switch (this.m_skin.currentFrame) {
					
					case 12:
						this.m_skin.stop();
						break;
					case 24:
						this.m_skin.stop();
						break;
					case 36:
						this.m_skin.stop();
						break;
					
				}
			}
		}
	}
}