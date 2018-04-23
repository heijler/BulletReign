package entity.fx {
	import flash.display.DisplayObjectContainer;
	
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	//-----------------------------------------------------------
	// FXManager
	//-----------------------------------------------------------
	
	public class FXManager {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_parent:DisplayObjectContainer;
		private  var m_effects:Vector.<Effect>;
		private const AMOUNT_LIMIT:int = 2;
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		
		/**
		 * 
		 */
		public function FXManager() {
			
		}
		
		
		/**
		 * 
		 */
		public function add(effect:Effect):void {
			this.m_effects.push(effect);
		}
		
		
		/**
		 * 
		 */
		public function remove():void {
			
		}
	}
}