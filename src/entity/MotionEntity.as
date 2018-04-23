package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	
	//-----------------------------------------------------------
	// MotionEntity
	//-----------------------------------------------------------
	
	public class MotionEntity extends Entity {
		
		//-----------------------------------------------------------
		// Protected properties
		//-----------------------------------------------------------
		
		protected const GRAVITY:Number = 0.55;
		protected var _velocity:Number;
		protected var _angle:Number;
		
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
		}
		
		
		/**
		 * init
		 * Override
		 */
		override public function init():void {
		}
		
		
		/**
		 * applyGravity
		 * 
		 */
		protected function applyGravity():void {
			this.y = this.y + this.GRAVITY * this.m_gravityFactor;
 		}
		
		
		/**
		 * removeGravity
		 * 
		 */
		protected function removeGravity():void {
			this.y = this.y;
			this.m_gravityFactor = 0;
		}
		
		
		/**
		 * setGravityFactor
		 */
		protected function setGravityFactor(factor:int):void {
			this.m_gravityFactor = factor;
		}
		
		
		/**
		 * wrapAroundObjects
		 * Wrap objects from one side of screen to the other.
		 */
		protected function wrapAroundObjects():void {
			if(this.x < -this.width) {
				this.x = _appWidth;
			} else if (this.x > _appWidth) {
				this.x = -this.width;
			}
		}
		
		
		/**
		 * 
		 */
		protected function collision(obj1:Entity, obj2:Entity):void {
			
		}
	
	}
}