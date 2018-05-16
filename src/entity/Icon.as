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
	import se.lnu.stickossdk.timer.Timer;
	
	//-----------------------------------------------------------
	// Crate
	//-----------------------------------------------------------
	
	public class Icon extends Entity {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_skin:MovieClip;
		private var m_type:int
		private var m_player:int;
		private var m_iconClips:Vector.<MovieClip>;
		
		public function Icon(pos:Point, type:int) {
			super();
			this.m_pos = pos;
			this.m_type = type;
		}
		
		/**	
		 * init
		 * override
		 */
		override public function init():void {
			this.m_initSkin();
			this.m_setSpawnPosition();
		}
		
		override public function dispose():void {
			trace("Dispose ICON! REMOVE ME WHEN ACTUALLY DISPOSING.");
		}
		
		private function m_initSkin():void {
			this.m_iconClips = new Vector.<MovieClip>;
			this.m_iconClips.push(new armoriconGFX, new powericonGFX, new speediconGFX);
			for(var i:int = 0; i < this.m_iconClips.length; i++) {
				this._setScale(this.m_iconClips[i], 2, 2);
				this.m_iconClips[i].cacheAsBitmap = true;
			}
			this.addChild(this.m_iconClips[this.m_type]);
		}
		
		private function m_setSpawnPosition():void {
			this.x = this.m_pos.x;
			this.y = this.m_pos.y;
		}
		
		public function m_moveLeft():void {
			this.x = this.x -25
		}
		
		public function m_moveRight():void {
			this.x = this.x +25
		}

	}
}