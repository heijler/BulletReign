package entity {
	//-----------------------------------------------------------
	// MotionEntity
	//-----------------------------------------------------------
	
	public class MotionEntity extends Entity {
		
		//-----------------------------------------------------------
		// Protected properties
		//-----------------------------------------------------------
		
		protected const GRAVITY:Number = 0.55;
		public var _velocity:Number;
		public var _angle:Number;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_gravityFactor:int = 1;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function MotionEntity() {
			super();
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		
		/**
		 * update
		 * Override
		 */
		override public function update():void {
			super.update();
		}
		
		
		/**
		 * init
		 * Override
		 */
		override public function init():void {
			super.init();
		}
		
		
		/**
		 * 
		 */
		override public function dispose():void {
			this._velocity = 0;
			this._angle = 0;
			this.m_gravityFactor = 0;
		}
		
		
		/**
		 * applyGravity
		 * 
		 */
		public function applyGravity(down:Boolean = true):void {
			if (down) {
				this.y = this.y + this.GRAVITY * this.m_gravityFactor;
			} else {
				this.y = this.y - this.GRAVITY * this.m_gravityFactor;
			}
 		}
		
		
		/**
		 * removeGravity
		 * 
		 */
		public function removeGravity():void {
			this.y = this.y;
			this.m_gravityFactor = 0;
		}
		
		
		/**
		 * setGravityFactor
		 */
		public function setGravityFactor(factor:int):void {
			this.m_gravityFactor = factor;
		}
		
		
		/**
		 * wrapAroundObjects
		 * Wrap objects from one side of screen to the other.
		 */
		public function wrapAroundObjects():void {
			if(this.x < -this.width) {
				this.x = _appWidth + (this.width * 0.5);
			} else if (this.x - (this.width * 0.5) > _appWidth) {
				this.x = -this.width;
			}
		}
	}
}