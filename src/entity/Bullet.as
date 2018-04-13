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
		// Private properties
		//-----------------------------------------------------------
		private var m_skin:Sprite;
		private var m_damage:Number;
		private var m_size:int = 3;
		private var m_owner:int;
		public  var color:uint = 0xFFFFFF;
		
		
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
		 * 
		 */
		private function m_initBullet():void {
			this.color = (this.m_owner ? 0xFF0000 : 0x0000FF);
		}
		
		
		/**	
		 * m_initSkin
		 * Create the the skin for the bullet.
		 */
		private function m_initSkin():void {
			this.m_skin = new Sprite();
			this.m_skin.graphics.beginFill(this.color);
			this.m_skin.graphics.drawRect(this.x, this.y, this.m_size, this.m_size);
			this.m_skin.graphics.endFill();
			this.addChild(this.m_skin);
			this.updatePosition();
		}
		
		private function m_setSpawnPosition():void {
			this.x = this.m_pos.x;
			this.y = this.m_pos.y;
		}
		
		/**	
		 * update
		 * Override
		 */
		// Frågan är om Bullets rörelse ska hanteras här eller i plane, där lyssning efter spelarens tryck på skjutknappen sker?
		override public function update():void {
			updatePosition();
		}
		
		
		/**
		 * fire
		 * Shots bullet 
		 */
		 // @TODO: Figure out which plane is shooting, += for p1, -= for p2.
		private function updatePosition():void {
			var xVel:Number = Math.cos(this._angle * (Math.PI / 180)) * this._velocity << 2;
			var yVel:Number = Math.sin(this._angle * (Math.PI / 180)) * this._velocity << 2;
			
			if (this.m_owner == 0) {
				this.x += xVel;
				this.y += yVel;
			} else if (this.m_owner == 1) {
				this.x -= xVel;
				this.y -= yVel;
			}
			

			
		}
	}
}