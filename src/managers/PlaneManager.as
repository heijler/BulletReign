package managers {
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	import flash.display.DisplayObjectContainer;
	
	import objects.plane.Plane;
	
	//-----------------------------------------------------------
	// PlaneManager
	//-----------------------------------------------------------
	
	public class PlaneManager {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const AMOUNT_LIMIT:int = 2;
		private var m_parent:DisplayObjectContainer;
		private var m_planes:Vector.<Plane>;
		private var m_val:Boolean = false;
		
		
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
		
		
		/**
		 * 
		 */
		public function checkCollision(plane:Plane):Boolean {
			this.m_val = false;
			for(var i:int = 0; i < this.m_planes.length; i++) {
				if(plane.hitTestObject(this.m_planes[i])) {
					this.m_val = true;
				}
			}
			return this.m_val;
		}
		
		
		/**
		 * 
		 */
		public function dispose():void {
			trace("Planemanager dispose");
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
			this.m_val = false;
		}
	}
}