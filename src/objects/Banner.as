package objects {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.Point;
	
	import asset.BannerGFX;
	
	import entity.MotionEntity;
	
	import se.lnu.stickossdk.system.Session;
	import objects.plane.Plane;
	
	//-----------------------------------------------------------
	// Banner
	//-----------------------------------------------------------
	
	public class Banner extends MotionEntity {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		public var hitBox:Shape;
		public var active:Boolean = false;
		public var onGround:Boolean = false;
		public var onBase:Boolean = false;
		public var outOfBounds:Boolean = false;
		public var lastHolder:Plane;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_skin:MovieClip;
		private var m_caught:Boolean = false;
		private var m_scaleFactor:int;
		private var m_gravity:Boolean;
		private var m_angleVals:Vector.<Number> = new Vector.<Number>();
		
		
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
		 */
		public function set caught(value:Boolean):void {
			this.m_caught = value;
		}
		
		
		/**
		 * get caught
		 */
		public function get caught():Boolean {
			return this.m_caught;
		}
		
		
		/**
		 * set gravity
		 */
		public  function set gravity(value:Boolean):void {
			this.m_gravity = value;
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
		 * blink
		 * 
		 */
		public function blink():void {
			this.flicker(this, 2000, 100);
		}
		
		
		/**
		 * showBanner
		 * 
		 */
		public function showBanner():void {
			Session.tweener.add(this, {
				duration: 150,
				y: 50
			});
			this.active = true;
		}
		
		/**
		 * init
		 * 
		 */
		override public function init():void {
			this.m_initSkin();
		}
		
		
		/**
		 * m_initSkin
		 * 
		 */
		private function m_initSkin():void {
			this.m_skin = new BannerGFX;
			this.setScale(this.m_skin, 2, 2);
			this.m_skin.x = -24;
			this.m_initHitBox();
			this.addChild(this.m_skin);
		}
		
		
		/**
		 * m_initHitBox
		 * 
		 */
		private function m_initHitBox():void {
			this.hitBox = new Shape();
			
			// Debug
			if (BulletReign.debug) hitBox.graphics.beginFill(0xFF0000);
			
			this.hitBox.graphics.drawRect(-12, -2, 12, 4);
			
			// Debug
			if (BulletReign.debug) hitBox.graphics.endFill();
			
			this.m_skin.addChild(this.hitBox);
		}
		
		
		/**
		 * m_setSpawnPosition
		 * 
		 */
		private function m_setSpawnPosition():void {
			this.x = this.m_pos.x + 20;
			this.y = this.m_pos.y - this.m_skin.height;
		}
		
		
		/**
		 * update
		 * @TODO: Divide into several methods
		 */
		override public function update():void {
			this.wrapAroundObjects();
			
			if ((this.y > Session.application.size.y || this.y < -100 || this.x > Session.application.size.x + 40 || this.x < -40) && this.active) {
				this.outOfBounds = true;
			}
			
			if (this.m_gravity && !this.onGround && !this.onBase) {
				if (this.rotation < 0 && this.rotation > -90 || this.rotation > 0 && this.rotation < 90) {
					this.rotation += 0.5 * this.m_scaleFactor;	
				} else {
					this.rotation -= 0.5 * this.m_scaleFactor;
				}
				this.setGravityFactor(3 + (0.0085 * this.y));
				this.applyGravity();
				this.x += (Math.cos(this._angle * (Math.PI / 180)) * this._velocity >> 1.5) * this.m_scaleFactor;
				this.y += (Math.sin(this._angle * (Math.PI / 180)) * this._velocity >> 1.5) * this.m_scaleFactor;
			}
		}
		
		
		/**
		 * follow
		 * 
		 */
		public function follow(pos:Point, angle:Number, scaleFactor:int, vel:Number):void {
			this.m_pos = pos;
			this._angle = angle;
			this._velocity = vel;
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
			
			if (this.m_angleVals.length < 8) {
				this.m_angleVals.push(this._angle);
			} else {
				this.m_angleVals.shift();
				this.m_angleVals.push(this._angle);
			}
			this.rotation = this.m_angleVals[0];
		}
		
		
		/**
		 * m_updateDirection
		 * 
		 */
		private function m_updateDirection():void{
			this.setScale(this, 1 * this.m_scaleFactor, 1 * this.m_scaleFactor);
		}
		
		
		/**
		 * dispose
		 * 
		 */
		override public function dispose():void {
			if (this.m_skin.contains(this.hitBox)) {
				this.m_skin.removeChild(this.hitBox);
			}
			this.hitBox = null;
			if (this.m_skin.parent != null) {
				this.removeChild(this.m_skin);
			}
			this.m_skin = null;
			this.m_angleVals.length = 0;
			this.active = false;
			this.onGround = false;
			this.onBase = false;
			this.outOfBounds = false;
			this.lastHolder = null;
			this.m_caught = false;
			this.m_scaleFactor = 0;
			this.m_gravity = false;
		}
	}
}