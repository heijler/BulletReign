package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.geom.Point;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	
	//-----------------------------------------------------------
	// Game
	//-----------------------------------------------------------
	
	public class Entity extends DisplayStateLayerSprite {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var pos:Point;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Entity() {
			super();
		}
	}
}