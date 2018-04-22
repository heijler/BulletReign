package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	import flash.display.Sprite;
	import flash.geom.Point;
	
	//-----------------------------------------------------------
	// Bullet
	//-----------------------------------------------------------
	
	public class Bullet extends MotionEntity {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		public const BULLET_DAMAGE:Number = 20; // 10
		public  var color:uint = 0xFFFFFF;
		public var active:Boolean = true;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const BULLET_SIZE:Number = 1.5;
		private var m_skin:Sprite;
		private var m_owner:int;
		
		
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Bullet(angle:Number, velocity:Number, pos:Point, owner:int) {
			super();
			this.m_pos = pos;
			this._angle = angle;
			this._velocity = velocity;
			this.m_owner = owner;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**	
		 * init
		 * Override.
		 */
		override public function init():void {
			this.m_initBullet();
			this.m_initSkin();
			this.m_setSpawnPosition();
		}
		
		
		/**
		 * m_initBullet
		 * 
		 */
		private function m_initBullet():void {
			// Make the colors not as hard coded.
			this.color = (this.m_owner ? 0xC37100 : 0x8A8A00);
		}
		
		
		/**	
		 * m_initSkin
		 * Create the the skin for the bullet.
		 */
		private function m_initSkin():void {
			this.m_skin = new Sprite();
			this.m_skin.graphics.beginFill(this.color);
			this.m_skin.graphics.drawRect(this.x, this.y, this.BULLET_SIZE, this.BULLET_SIZE);
			this.m_skin.graphics.endFill();
			this._setScale(this.m_skin);
			this.addChild(this.m_skin);
			this.updatePosition();
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
		 * Override
		 */
		override public function update():void {
			this.deactivate();
			this.updatePosition();
		}
		
		
		/**
		 * fire
		 * Shots bullet 
		 */
		private function updatePosition():void {
			var xVel:Number = Math.cos(this._angle * (Math.PI / 180)) * this._velocity << 1;
			var yVel:Number = Math.sin(this._angle * (Math.PI / 180)) * this._velocity << 1;
			this.rotation = this._angle;
			
			//@TODO: Use scale factor to get rid of ifs
			if (this.m_owner == 0) {
				this.x += xVel;
				this.y += yVel;
			} else if (this.m_owner == 1) {
				this.x -= xVel;
				this.y -= yVel;
			}
		}
		
		
		/**
		 * trackDistance
		 * 
		 */
		private function deactivate():void {
			if (this.x < -this.width || this.x > _appWidth) {
				this.active = false;
			}
		}
	}
}