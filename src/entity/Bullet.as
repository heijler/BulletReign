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
		private var m_shooting:Boolean;
		
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Bullet() {
			super();
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
			this.m_skin.graphics.beginFill(0xFFFFFF);
			this.m_skin.graphics.drawRect(this.x, this.y, this.m_size, this.m_size);
			this.m_skin.graphics.endFill();
			this.addChild(this.m_skin);
		}
		
		/**	
		 * update
		 * Override
		 */
		// Frågan är om Bullets rörelse ska hanteras här eller i plane, där lyssning efter spelarens tryck på skjutknappen sker?
		override public function update():void {
			if (this.m_shooting) {
				this.x += Math.cos(this._angle * (Math.PI/180)) * this._velocity;
				this.y += Math.sin(this._angle * (Math.PI/180)) * this._velocity;
			}
		}
		
		/**	
		 * fire
		 * Shots bullet 
		 */
		public function fire():void {
			this.m_shooting = true;
		}
	}
}