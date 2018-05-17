package objects {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.Point;
	
	import asset.BannerGFX;
	
	import se.lnu.stickossdk.system.Session;
	import entity.MotionEntity;
	
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
		public var lastHolder:Plane;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_skin:MovieClip;
		private var m_caught:Boolean = false;
		private var m_scaleFactor:int;
		private var m_counter:int = 3;
		private var m_oldAngle:Number;
		public var m_gravity:Boolean; // @TODO: CHANGE TO PRIVATE !!!!!!!!!!!!!
		
		
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
			this._setScale(this.m_skin, 2, 2);
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
			hitBox.graphics.beginFill(0xFF0000);
			this.hitBox.graphics.drawRect(-12, -2, 12, 4);
			hitBox.graphics.endFill();
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
		 * 
		 */
		override public function update():void {
			this.wrapAroundObjects();
			if (this.m_gravity && !this.onGround && !this.onBase) {
				this.applyGravity();
				this.setGravityFactor(3);
				if (this.rotation < 0 && this.rotation > -90 || this.rotation > 0 && this.rotation < 90) {
					this.rotation += 0.5 * this.m_scaleFactor;	
				} else {
					this.rotation -= 0.5 * this.m_scaleFactor;
				}
				
				this.setGravityFactor(3 + (0.004* this.y));
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
			this._angle %= 360; // resets angle at 360
			if (this._angle < 0) this._angle = this._angle + 360; // Prevents minus angles
			
			this.m_counter--;
			if (this.m_counter < 1) {
				// @TODO: Use old angle and compare with new angle, if positive, do something in some direction, if negative opposite
				if (this._angle > 180 && this._angle < 360) {
					Session.tweener.add(this, {
						duration: 80,
						rotation: this._angle - 360
					});
				} else {
					Session.tweener.add(this, {
						duration: 80,
						rotation: this._angle
					});
				}
				this.m_counter = 2;
			}
			
			
//			this.rotation = this._angle; // standard stel
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