package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.fx.Shake;
	import se.lnu.stickossdk.system.Session;
	
	
	//-----------------------------------------------------------
	// Game
	//-----------------------------------------------------------
	
	public class Entity extends DisplayStateLayerSprite {
		
		//-----------------------------------------------------------
		// Protected properties
		//-----------------------------------------------------------
		
		protected var m_pos:Point;
		protected var _appWidth:int = 0;
		private const DEFAULT_SCALE:int = 2;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Entity() {
			super();
			this._appWidth = Session.application.width;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**
		 * 
		 */
		protected function _setScale(obj:MovieClip, scaleX:int = this.DEFAULT_SCALE, scaleY:int = this.DEFAULT_SCALE):void {
			obj.scaleX = scaleX;
			obj.scaleY = scaleY;
		}
		
		
		
		/**
		 * 
		 */
		protected function _shake(obj:DisplayObjectContainer, amountY:int):void {
			var shake:Shake = new Shake(obj, 150, new Point(0,amountY), new Point(0,0));
			Session.effects.add(shake);
		}
	}
}