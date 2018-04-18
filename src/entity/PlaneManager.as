package entity {

	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.DisplayObjectContainer;
	
	//-----------------------------------------------------------
	// PlaneManager
	//-----------------------------------------------------------
	
	public class PlaneManager {
		
		//-----------------------------------------------------------
		// Properties
		//-----------------------------------------------------------
		
		private const AMOUNT_LIMIT:int = 2;
		private var m_parent:DisplayObjectContainer;
		private  var m_planes:Vector.<Plane>;
		
		
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
		 * 
		 */
		public function add(plane:Plane):void {
			if (this.m_planes.length < AMOUNT_LIMIT) {
				this.m_planes.push(plane);
				this.m_parent.addChild(plane);
			}
		}
		
		
		/**
		 * 
		 */
		public function getPlanes():Vector.<Plane> {
			return this.m_planes;
		}
	}
}