package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	import flash.display.Sprite;
	
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
		
		public function Bullet(angle:Number, velocity:Number, x:int, y:int) {
			super();
			this.x = x;
			this.y = y;
			this._angle = angle;
			this._velocity = velocity
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
			this.x += Math.cos(this._angle * (Math.PI/180)) * (this._velocity << 2);
			this.y += Math.sin(this._angle * (Math.PI/180)) * (this._velocity << 2);
		}
	}
}