package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	//-----------------------------------------------------------
	// Projectile
	//-----------------------------------------------------------
	
	public class Projectile extends DisplayStateLayerSprite {
		
		//-----------------------------------------------------------
		// Protected properties
		//-----------------------------------------------------------
		
		protected var velocity:Number;
		protected var angle:Number;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Projectile() {
			super();
		}
	}
}