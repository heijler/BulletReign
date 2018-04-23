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
		private  var m_effects:Vector.<Effect> = new Vector.<Effect>;
		private const AMOUNT_LIMIT:int = 20;
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
			if (this.m_effects.length < AMOUNT_LIMIT) {
				this.m_effects.push(effect);
			} else {
				var firstEffect:Effect = this.m_effects.shift()
				firstEffect = null;
			}
			
			trace("Effect vector length", this.m_effects.length);
		}
		
		
		/**
		 * 
		 */
		public function remove():void {
			
		}
	}
}