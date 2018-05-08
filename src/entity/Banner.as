package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import asset.BannerGFX;
	
	import se.lnu.stickossdk.system.Session;
	
	
	//-----------------------------------------------------------
	// Banner
	//-----------------------------------------------------------
	
	public class Banner extends MotionEntity {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		public var hitBox:Sprite;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_skin:MovieClip;
		private var m_caught:Boolean = false;
		private var m_scaleFactor:int;
		
		
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
		// Set / Get
		//-----------------------------------------------------------
		
		/**
		 * set caught
		 * 
		 */
		public function set caught(value:Boolean):void {
			this.m_caught = value;
		}
		
		
		/**
		 * get caught
		 * 
		 */
		public function get caught():Boolean {
			return this.m_caught;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**
		 * onPlaneCollision
		 * 
		 */
		public function onPlaneCollision():void {
			
		}
		
		
		/**
		 * showBanner
		 * 
		 */
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
			this.m_skin.x = -20;
			this.m_initHitBox();
			this.addChild(this.m_skin);
		}
		
		
		/**
		 * m_initHitBox
		 * 
		 */
		private function m_initHitBox():void {
			hitBox = new Sprite();
			hitBox.graphics.beginFill(0xFF0000);
			hitBox.graphics.drawRect(-2, -3, 2, 6);
			hitBox.graphics.endFill();
			this.m_skin.addChild(hitBox);
		}
		
		
		/**
		 * 
		 */
		private function m_setSpawnPosition():void {
			this.x = this.m_pos.x + 20;
			this.y = this.m_pos.y - this.m_skin.height;
		}
		
		
		/**
		 * update
		 * 
		 */
		override public function update():void {
//			trace("Banner update");
			this.wrapAroundObjects();
		}
		
		
		/**
		 * 
		 */
		public function follow(pos:Point, angle:Number, scaleFactor:int):void {
			this.m_pos = pos;
			this._angle = angle;
			this.m_scaleFactor = scaleFactor;
			this.m_updatePos();
			this.m_updateAngle();
			this.m_updateDirection();
		}
		
		
		/**
		 * m_updatePos
		 */
		private function m_updatePos():void {
			this.x = this.m_pos.x;
			this.y = this.m_pos.y;
		}
		
		
		/**
		 * m_updateAngle
		 * 
		 */
		private function m_updateAngle():void {
			this.rotation = this._angle;
		}
		
		/**
		 * m_updateDirection
		 * 
		 */
		private function m_updateDirection():void{
			this._setScale(this, 1 * this.m_scaleFactor, 1 * this.m_scaleFactor);
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