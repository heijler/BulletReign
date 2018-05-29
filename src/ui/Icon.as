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
	// Icon
	//
	//   _____ _____  _____ _____   ____   _____         _ 
	//  |  __ \_   _|/ ____|  __ \ / __ \ / ____|  /\   | |
	//  | |  | || | | (___ | |__) | |  | | (___   /  \  | |
	// 	| |  | || |  \___ \|  ___/| |  | |\___ \ / /\ \ | |
	// 	| |__| || |_ ____) | |    | |__| |____) / ____ \|_|
	// |_____/_____|_____/|_|     \____/|_____/_/    \_(_)
	//
	//-----------------------------------------------------------
	
	public class Icon extends DisplayStateLayerSprite {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_skin:MovieClip;
		private var m_type:int
		private var m_player:int;
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
		
		override public function dispose():void {
			trace("Dispose ICON! REMOVE ME WHEN ACTUALLY DISPOSING.");
		}
		
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
		
		private function m_setSpawnPosition():void {
			this.x = this.m_pos.x;
			this.y = this.m_pos.y;
		}

	}
}