package entity.fx {
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.DisplayObjectContainer;
	
	//-----------------------------------------------------------
	// FXManager
	//-----------------------------------------------------------
	
	public class FXManager {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_parent:DisplayObjectContainer;
		private  var m_effects:Vector.<Effect> = new Vector.<Effect>;
		private const AMOUNT_LIMIT:int = 300;
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		
		/**
		 * FXManager
		 * 
		 */
		public function FXManager(parent:DisplayObjectContainer) {
			this.m_parent = parent;
		}
		
		
		/**
		 * add
		 * 
		 */
		public function add(effect:Effect):void {
			if (this.m_effects.length < AMOUNT_LIMIT) {
				this.m_effects.push(effect);
				this.m_parent.addChild(effect);
			} else {
				var firstEffect:Effect = this.m_effects.shift()
				this.m_removeEffect(firstEffect);
			}
			
//			trace("Effect vector length", this.m_effects.length);
		}
		
		
		/**
		 * m_removeEffect
		 * 
		 */
		private function m_removeEffect(effect:Effect):void {
			if (this.m_parent.contains(effect)) {
				this.m_parent.removeChild(effect);
				effect = null;
			}
		}
	}
}