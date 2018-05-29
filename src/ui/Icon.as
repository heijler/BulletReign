package ui {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import asset.armoriconGFX;
	import asset.powericonGFX;
	import asset.speediconGFX;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	//-----------------------------------------------------------
	// Crate
	//-----------------------------------------------------------
	
	public class Icon extends DisplayStateLayerSprite {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_skin:MovieClip;
		private var m_type:int
		private var m_iconClips:Vector.<MovieClip>;
		private var m_pos:Point;
		
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
		
		/**	
		 * dispose
		 * override
		 */
		override public function dispose():void {
			if(this.m_skin.parent != null) {
				this.m_skin.parent.removeChild(this.m_skin);
			}
			this.m_skin = null;
			this.m_type = 0;
			for (var i:int = 0; i < this.m_iconClips.length; i++) {
				if(this.m_iconClips[i].parent.contains(this.m_iconClips[i])) {
					this.removeChild(this.m_iconClips[i]);
				}
				this.m_iconClips[i] = null;
			}
			this.m_pos = null;
		}
		
		/**	
		 * Initialize icon skin
		 */
		private function m_initSkin():void {
			this.m_iconClips = new Vector.<MovieClip>;
			this.m_iconClips.push(new armoriconGFX, new powericonGFX, new speediconGFX);
			for(var i:int = 0; i < this.m_iconClips.length; i++) {
				//this._setScale(this.m_iconClips[i], 2, 2);	DETTA ÄR MER OPTIMALT ÄN NEDANSTÅENDE ALTERNATIV
				this.m_iconClips[i].scaleX = 2;
				this.m_iconClips[i].scaleY = 2;
				this.m_iconClips[i].cacheAsBitmap = true;
			}
			this.addChild(this.m_iconClips[this.m_type]);
		}
		
		/**	
		 * Set icon spawnposition
		 */
		private function m_setSpawnPosition():void {
			this.x = this.m_pos.x;
			this.y = this.m_pos.y;
		}

	}
}