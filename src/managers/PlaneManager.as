package managers {
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	import flash.display.DisplayObjectContainer;
	
	import objects.plane.Plane;
	
	//-----------------------------------------------------------
	// PlaneManager
	// Handles and provides access to instanciated planes
	//-----------------------------------------------------------
	
	public class PlaneManager {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const AMOUNT_LIMIT:int = 2; 			
		private var m_parent:DisplayObjectContainer;  	
		private var m_planes:Vector.<Plane>;			
		
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function PlaneManager(parent:DisplayObjectContainer) {
			this.m_parent = parent;
			this.m_planes = new Vector.<Plane>;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		
		/**
		 * add
		 * adds planes to layer if not more than amount limit
		 */
		public function add(plane:Plane):void {
			if (this.m_planes.length < AMOUNT_LIMIT) {
				this.m_planes.push(plane);
				this.m_parent.addChild(plane);
			}
		}
		
		
		/**
		 * getPlanes
		 * returns a vector of planes
		 */
		public function getPlanes():Vector.<Plane> {
			return this.m_planes;
		}
		
		
		/**
		 * disposes
		 */
		public function dispose():void {
			for(var i:int; i < this.m_planes.length; i++) {
				this.m_planes[i].dispose();
				if(this.m_parent.contains(this.m_planes[i])) {
					this.m_parent.removeChild(this.m_planes[i]);
				}
				this.m_planes[i] = null;
			}
			this.m_planes.length = 0;
			this.m_planes = null;
			this.m_parent = null;
		}
	}
}