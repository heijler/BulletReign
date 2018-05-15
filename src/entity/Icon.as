package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import asset.armoriconGFX;
	import asset.powericonGFX;
	import asset.speediconGFX;
	
	import se.lnu.stickossdk.system.Session;
	
	//-----------------------------------------------------------
	// Crate
	//-----------------------------------------------------------
	
	public class Icon extends Entity {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_skin:MovieClip;
		private var m_type:int
		private var m_parent:DisplayObjectContainer;
		private var m_player:int;
		
		public function Icon(player:int, parent:DisplayObjectContainer, pos:Point, type:int) {
			super();
			this.m_parent = parent;
			this.m_pos = pos;
			this.m_type = type;
			this.m_player = player;
			this.init();
		}
		
		/**	
		 * init
		 * override
		 */
		override public function init():void {
			this.m_initSkin();
			
		}
		
		private function m_initSkin():void {
			if (this.m_type == 0) {
				this.m_skin = new armoriconGFX;
				if(this.m_player == 0 ) {
					this.m_skin.x = Session.application.size.x / 5;
					this.m_skin.y = Session.application.size.y / 5;
				} else {
					this.m_skin.x = Session.application.size.x;
					this.m_skin.y = Session.application.size.y;
				}
				this._setScale(this.m_skin, 2, 2);
			}
			if (this.m_type == 1) {
				this.m_skin = new powericonGFX;
				if(this.m_player == 0 ) {
					this.m_skin.x = Session.application.size.x / 5;
					this.m_skin.y = Session.application.size.y / 5;
				} else {
					this.m_skin.x = Session.application.size.x;
					this.m_skin.y = Session.application.size.y;
				}
				this._setScale(this.m_skin, 2, 2);
			}
			if (this.m_type == 2) {
				this.m_skin = new speediconGFX;
				if(this.m_player == 0 ) {
					this.m_skin.x = Session.application.size.x / 5;
					this.m_skin.y = Session.application.size.y / 5;
				} else {
					this.m_skin.x = Session.application.size.x;
					this.m_skin.y = Session.application.size.y;
				}
				this._setScale(this.m_skin, 2, 2);
			}
			this.m_setSpawnPosition();
			this.m_parent.addChild(this.m_skin);
			this.m_skin.cacheAsBitmap = true;
		}
		
		private function m_setSpawnPosition():void {
			this.x = this.m_pos.x;
			this.y = this.m_pos.y;
		}
	}
}