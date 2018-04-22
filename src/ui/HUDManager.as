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
		private var m_huds:Vector.<HUD>;
		
		
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
				hud.name = "Player ".toUpperCase() + this.m_huds.length;
			}
		}
		
		public function incrementWins(planeIndex:int):void {
			this.m_huds[planeIndex].win = 1;
			this.m_huds[planeIndex].updateWins();
		}
		
		public function incrementDecrementHealth(planeIndex:int, durability):void {
			this.m_huds[planeIndex].visualDurability = durability;
			this.m_huds[planeIndex].updateHealth();
		}
		
		/**
		 * 
		 */
		public function getPlanes():Vector.<HUD> {
			return this.m_huds;
		}
	}
}