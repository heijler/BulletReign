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
	//-----------------------------------------------------------
	
	public class IconManager {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		public var m_player:int;
		public var m_icon:Icon;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const AMOUNT_LIMIT:int = 3;
		private var m_parent:DisplayObjectContainer;
		private var m_expireTimer:Timer;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function IconManager(player:int, parent:DisplayObjectContainer) {
			this.m_player = player;
			this.m_parent = parent;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**
		 * 
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
		 * 
		 */
		private function m_expire():void {
			this.m_expireTimer = Session.timer.create(5000, this.m_remove);
		}
		
		
		/**
		 * 
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
		 * 
		 */
		public function dispose():void {
			trace("iconmanager dispose");
			Session.timer.remove(this.m_expireTimer);
			this.m_expireTimer = null;
			this.m_player = 0;
			if (this.m_icon != null) {
				this.m_parent.removeChild(this.m_icon);
			}
			this.m_icon = null;
			this.m_parent = null;
		}
	}
}