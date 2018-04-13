package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	//-----------------------------------------------------------
	// MotionEntity
	//-----------------------------------------------------------
	
	public class MotionEntity extends Entity {
		
		//-----------------------------------------------------------
		// Protected properties
		//-----------------------------------------------------------
		
		protected var _velocity:Number;
		protected var _angle:Number;
		protected const GRAVITY:Number = 0.55;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function MotionEntity() {
			super();
		}
		
		public function applyGravity():void {
			this.y = this.y + this.GRAVITY;
 		}
	
	}
}