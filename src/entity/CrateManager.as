package entity {
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	import flash.display.DisplayObjectContainer;
	
	//-----------------------------------------------------------
	// CrateManager
	//-----------------------------------------------------------
	public class CrateManager {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const AMOUNT_LIMIT:int = 3;
		
		private var m_parent:DisplayObjectContainer;
		private var m_crates:Vector.<Crate>;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function CrateManager(parent:DisplayObjectContainer) {
			this.m_parent = parent;
			this.m_crates = new Vector.<Crate>;
		}
		
		public function add(crate:Crate):void {
			if (this.m_crates.length < AMOUNT_LIMIT) {
				this.m_crates.push(crate);
				this.m_parent.addChild(crate);
			}
		}
		
		public function getCrates():Vector.<Crate> {
			return this.m_crates;
		}
	}
}