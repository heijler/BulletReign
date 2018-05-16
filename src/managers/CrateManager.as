package managers {
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	import flash.display.DisplayObjectContainer;
	import Objects.Crate;
	
	//-----------------------------------------------------------
	// CrateManager
	//-----------------------------------------------------------
	public class CrateManager {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const AMOUNT_LIMIT:int = 20;
		
		private var m_parent:DisplayObjectContainer;
		private var m_crates:Vector.<Crate>;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function CrateManager(parent:DisplayObjectContainer) {
			this.m_parent = parent;
			this.m_crates = new Vector.<Crate>;
		}
		
		public function add(crate:Crate, type:int):void {
			if (this.m_crates.length < AMOUNT_LIMIT) {
				this.m_crates.push(crate);
				this.m_parent.addChild(crate);
			}
		}
		
		public function getCrates():Vector.<Crate> {
			return this.m_crates;
		}
		
		public function removeCrate(crate:Crate):void {
			var markedCrate:Vector.<Crate> = this.m_crates.splice(this.m_crates.indexOf(crate), 1);
			if (this.m_parent.contains(markedCrate[0])) {
				this.m_parent.removeChild(markedCrate[0]);
				markedCrate[0] = null;
				markedCrate = null;
			}
		}
	}
}