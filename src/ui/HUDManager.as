package ui {
	
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.DisplayObjectContainer;
	
	//-----------------------------------------------------------
	// PlaneManager
	//-----------------------------------------------------------
	
	public class HUDManager {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const AMOUNT_LIMIT:int = 2;
		private var m_parent:DisplayObjectContainer;
		private  var m_huds:Vector.<HUD>;
		
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function HUDManager(parent:DisplayObjectContainer) {
			this.m_parent = parent;
			this.m_huds = new Vector.<HUD>;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		
		/**
		 * 
		 */
		public function add(hud:HUD):void {
			if (this.m_huds.length < AMOUNT_LIMIT) {
				this.m_huds.push(hud);
				this.m_parent.addChild(hud);
			}
		}
		
		
		/**
		 * 
		 */
		public function getPlanes():Vector.<HUD> {
			return this.m_huds;
		}
	}
}