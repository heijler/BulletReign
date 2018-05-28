package objects {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import asset.ZeppelinGFX;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.tween.easing.Quint;
	import entity.MotionEntity;
	
	//-----------------------------------------------------------
	// Banner
	//-----------------------------------------------------------
	
	public class Zeppelin extends MotionEntity {
		
		
		public var atDefaultPos:Boolean = false;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_skin:MovieClip;
		private var m_defaultX:int = Session.application.size.x * 0.5;
		private var m_defaultY:int = -50; // -50
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Zeppelin(pos:Point) {
			super();
			this.m_pos = pos;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		/**
		 * init
		 * 
		 */
		override public function init():void {
//			trace("initZeppelin");
			this.m_initSkin();
			this.m_setSpawnPosition();
		}
		
		
		/**
		 * m_initSkin
		 * 
		 */
		private function m_initSkin():void {
			this.m_skin = new ZeppelinGFX;
			this.setScale(this.m_skin, 2, 2);
			this.addChild(this.m_skin);
			this.m_moveToDefault();
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
		 * 
		 */
		override public function update():void {
//			trace("Zeppelin update");
			
		}
		
		
		/**
		 * m_moveToDefault
		 * 
		 */
		private function m_moveToDefault():void {
			Session.tweener.add(this, {
				transition: Quint.easeOut,
				duration: 5000,
				x: this.m_defaultX - this.width * 0.5,
				y: this.m_defaultY,
				onComplete: this.m_zeppelinAtDefault
			});
		}
		
		
		/**
		 * m_zeppelinAtDefault
		 * 
		 */
		private function m_zeppelinAtDefault():void {
//			trace("Zeppelin at default");
			this.atDefaultPos = true;
			
		}
		
		
		/**
		 * dispose
		 * 
		 */
		override public function dispose():void {
			this.atDefaultPos = false;
			this.m_skin = null;
			this.m_defaultX = 0;
			this.m_defaultY = 0;
		}
	}
}