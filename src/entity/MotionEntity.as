package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	//-----------------------------------------------------------
	// MotionEntity
	//-----------------------------------------------------------
	
	public class MotionEntity extends DisplayStateLayerSprite {
		
		//-----------------------------------------------------------
		// Protected properties
		//-----------------------------------------------------------
		
		protected var _velocity:Number;
		protected var _angle:Number;
		protected var _gravity:Number;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function MotionEntity() {
			super();
		}
	}
}