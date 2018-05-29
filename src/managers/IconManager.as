package managers {
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.DisplayObjectContainer;
		
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	import ui.Icon;
	
	//-----------------------------------------------------------
	// IconManager
	// Handles representation of icons for active powerups
	//-----------------------------------------------------------
	
	public class IconManager {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		public var m_icon:Icon;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_parent:DisplayObjectContainer;	
		private var m_expireTimer:Timer; 				
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function IconManager(parent:DisplayObjectContainer) {
			this.m_parent = parent;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**
		 * add
		 * adds or replaces icon depending on set or not
		 */
		public function add(icon:Icon):void {
			if(this.m_icon) {
				Session.timer.remove(this.m_expireTimer);
				this.m_remove();
				this.m_icon = icon;
				this.m_parent.addChild(icon);
				this.m_expire();
			} else {
				this.m_icon = icon;
				this.m_parent.addChild(icon);
				this.m_expire();
			}
		}
		
		
		/**
		 * Icon lifetime, calls icon removal after 5000 milliseconds
		 */
		private function m_expire():void {
			this.m_expireTimer = Session.timer.create(5000, this.m_remove);
		}
		
		
		/**
		 * checks for icon and removes it if set
		 */
		public function m_remove():void {
			if(this.m_icon != null) {
				if(this.m_parent.contains(this.m_icon)) {			
					this.m_parent.removeChild(this.m_icon);
					this.m_icon = null;
				}
			
			}
		}
		
		
		/**
		 * disposes
		 */
		public function dispose():void {
			Session.timer.remove(this.m_expireTimer);
			this.m_expireTimer = null;
			if (this.m_icon != null) {
				this.m_parent.removeChild(this.m_icon);
			}
			this.m_icon = null;
			this.m_parent = null;
		}
	}
}