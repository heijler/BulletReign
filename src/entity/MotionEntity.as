package entity {
	//-----------------------------------------------------------
	// MotionEntity
	// Represents an entity that can move or be moved
	//-----------------------------------------------------------
	
	public class MotionEntity extends Entity {
		
		//-----------------------------------------------------------
		// Protected properties
		//-----------------------------------------------------------
		
		protected const GRAVITY:Number = 0.55;
		public var _velocity:Number; //@TODO rename
		public var _angle:Number;    //@TODO rename
		
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
		 * Update
		 * Override
		 */
		override public function update():void {
			super.update();
		}
		
		
		/**
		 * Init
		 * Override
		 */
		override public function init():void {
			super.init();
		}
		
		
		/**
		 * Dispose
		 * Override
		 */
		override public function dispose():void {
			trace("MotionEntity dispose");
			this._velocity = 0;
			this._angle = 0;
			this.m_gravityFactor = 0;
		}
		
		
		/**
		 * Makes object fall down or up
		 */
		public function applyGravity(down:Boolean = true):void {
			if (down) {
				this.y = this.y + this.GRAVITY * this.m_gravityFactor;
			} else {
				this.y = this.y - this.GRAVITY * this.m_gravityFactor;
			}
 		}
		
		
		/**
		 * Makes objekt stop falling
		 */
		public function removeGravity():void {
			this.y = this.y;
			this.m_gravityFactor = 0;
		}
		
		
		/**
		 * Interface to set the gravityFactor / the speed of falling
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