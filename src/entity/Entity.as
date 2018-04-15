package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.geom.Point;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.system.Session;
	
	
	//-----------------------------------------------------------
	// Game
	//-----------------------------------------------------------
	
	public class Entity extends DisplayStateLayerSprite {
		
		//-----------------------------------------------------------
		// Protected properties
		//-----------------------------------------------------------
		
		protected var m_pos:Point;
		protected var _appWidth:int = 0;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Entity() {
			super();
			this._appWidth = Session.application.width;
		}
	}
}