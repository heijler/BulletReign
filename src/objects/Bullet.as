package objects {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import entity.MotionEntity;
	
	//-----------------------------------------------------------
	// Bullet
	//-----------------------------------------------------------
	
	public class Bullet extends MotionEntity {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		public const BULLET_DAMAGE:Number = 0.5; // 0.5
		public var color:uint = 0x000000;
		public var active:Boolean = true;
		public var requestParam:Boolean = false;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const BULLET_SPEED:Number = 1.7;
		private const BULLET_SIZE:Number = 2;
		private var m_skin:Sprite;
		private var m_scaleFactor:int;
		private var m_xVel:Number;
		private var m_yVel:Number;
		
		
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Bullet(angle:Number, velocity:Number, pos:Point, scaleFactor:int) {
			super();
			this.m_pos = pos;
			this._angle = angle;
			this._velocity = velocity;
			this.m_scaleFactor = scaleFactor;
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
		 * update
		 * Override
		 */
		override public function update():void {
			this.updatePosition();
			this.wrapAroundObjects();
		}
		
		
		/**
		 * 
		 */
		override public function dispose():void {
			this.color = 0;
			this.active = false;
			this.m_skin = null;
			this.m_scaleFactor = 0;
			this.m_xVel = 0;
			this.m_yVel = 0;
		}
		
		
		/**	
		 * m_initSkin
		 * Create the the skin for the bullet.
		 */
		private function m_initSkin():void {
			this.m_skin = new Sprite();
			this.m_skin.graphics.beginFill(this.color);
			this.m_skin.graphics.drawRect(-this.BULLET_SIZE * 0.5 + (5 * this.m_scaleFactor), -this.BULLET_SIZE * 0.5, this.BULLET_SIZE, this.BULLET_SIZE);
			this.m_skin.graphics.endFill();
			this.setScale(this.m_skin);
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
		 * fire
		 * Shots bullet 
		 */
		private function updatePosition():void {
			this.m_xVel = Math.cos(this._angle * (Math.PI / 180)) * (this._velocity << this.BULLET_SPEED);
			this.m_yVel = Math.sin(this._angle * (Math.PI / 180)) * (this._velocity << this.BULLET_SPEED);
			this.rotation = this._angle;
			this.x += this.m_xVel * this.m_scaleFactor;
			this.y += this.m_yVel * this.m_scaleFactor;
			
			this.applyGravity();
		}
	}
}