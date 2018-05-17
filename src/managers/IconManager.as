package managers {
	
	import flash.display.DisplayObjectContainer;
		
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	import ui.Icon;
	
	
	public class IconManager {
		
		private const AMOUNT_LIMIT:int = 3;
		private var m_parent:DisplayObjectContainer;
		private var m_expireTimer:Timer;
		
		public var m_player:int;
		public var m_icon:Icon;
		
		public function IconManager(player:int, parent:DisplayObjectContainer) {
			this.m_player = player;
			this.m_parent = parent;
		}
		
		public function add(icon:Icon):void {
			if(this.m_icon) {
				//this.m_remove();
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
		
		private function m_expire():void {
			this.m_expireTimer = Session.timer.create(5000, this.m_remove);
		}
		
		private function m_remove():void {
			if(this.m_parent.contains(this.m_icon)) {			
				this.m_parent.removeChild(this.m_icon);
				this.m_icon = null;
			}
			
		}
	}
}