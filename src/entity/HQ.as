package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	//-----------------------------------------------------------
	// Banner
	//-----------------------------------------------------------
	
	public class HQ extends Entity {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function HQ() {
			super();
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**
		 * init
		 * 
		 */
		override public function init():void {
			trace("initHQ");
			this.m_initSkin();
		}
		
		
		/**
		 * 
		 */
		private function m_initSkin():void {
			trace("m_initSkin");
		}
		
		
		/**
		 * update
		 * 
		 */
		override public function update():void {
			trace("HQ update");
		}
		
		
		/**
		 * dispose
		 * 
		 */
		override public function dispose():void {
			trace("Dispose HQ! REMOVE ME WHEN ACTUALLY DISPOSING.");
		}
	}
}