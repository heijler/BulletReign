package entity.fx {
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.DisplayObjectContainer;
	
	//-----------------------------------------------------------
	// FXManager
	// Represents a simple effects manager
	//-----------------------------------------------------------
	
	public class FXManager {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		private const AMOUNT_LIMIT:int = 300;
		
		private var m_parent:DisplayObjectContainer;
		private  var m_effects:Vector.<Effect> = new Vector.<Effect>;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function FXManager(parent:DisplayObjectContainer) {
			this.m_parent = parent;
		}
		
		
		/**
		 * Add effect to effects vector, if vector is full, remove the oldest effect
		 */
		public function add(effect:Effect):void {
			if (this.m_effects.length < AMOUNT_LIMIT) {
				this.m_effects.push(effect);
				this.m_parent.addChild(effect);
			} else {
				var firstEffect:Effect = this.m_effects.shift()
				this.m_removeEffect(firstEffect);
				firstEffect = null;
			}
		}
		
		
		/**
		 * Remove and null effect
		 */
		private function m_removeEffect(effect:Effect):void {
			if (this.m_parent.contains(effect)) {
				this.m_parent.removeChild(effect);
				effect = null;
			}
		}
		
		
		/**
		 * Dispose FXManager
		 */
		public function dispose():void {
			trace("FXmanager dispose");
			for (var i:int = 0; i < this.m_effects.length; i++) {
				this.m_effects[i].dispose;
				if (this.m_effects[i].parent != null) {
					this.m_parent.removeChild(this.m_effects[i]);
				}
			}
			this.m_parent = null;
			this.m_effects.length = 0;
			this.m_effects = null;
		}
	}
}