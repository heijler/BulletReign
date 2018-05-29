package managers {
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	import flash.display.DisplayObjectContainer;
	
	import objects.Crate;
	
	//-----------------------------------------------------------
	// CrateManager
	// Handles and keeps track of crates added to the layer
	//-----------------------------------------------------------
	public class CrateManager {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_parent:DisplayObjectContainer; 	
		private var m_crates:Vector.<Crate>;			
		private var m_markedCrate:Vector.<Crate>;		
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function CrateManager(parent:DisplayObjectContainer) {
			this.m_parent = parent;
			this.m_crates = new Vector.<Crate>;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**
		 * Add 
		 * Adds a crate to vector and layer
		 */
		public function add(crate:Crate, type:int):void {
				this.m_crates.push(crate);
				this.m_parent.addChild(crate);
		}
		
		
		/**
		 * getCrates
		 * returns vector of crates
		 */
		public function getCrates():Vector.<Crate> {
			return this.m_crates;
		}
		
		
		/**
		 * removeCrate
		 * removes the markedCrate
		 */
		public function removeCrate(crate:Crate):void {
			this.m_markedCrate = this.m_crates.splice(this.m_crates.indexOf(crate), 1);
			if (this.m_parent.contains(this.m_markedCrate[0])) {
				this.m_parent.removeChild(this.m_markedCrate[0]);
				this.m_markedCrate[0] = null;
			}
		}
		
		
		/**
		 * crateManager dispose
		 */
		public function dispose():void {
			for(var i:int; i < this.m_crates.length; i++) {
				this.m_crates[i].dispose();
				if(this.m_parent.contains(this.m_crates[i])) {
					this.m_parent.removeChild(this.m_crates[i]);
				}
				this.m_crates[i] = null;
			}
			this.m_crates.length = 0;
			this.m_crates = null;
			this.m_parent = null;
			if (this.m_markedCrate != null) {
				this.m_markedCrate.length = 0;
			}
			this.m_markedCrate = null;
		}
	}
}