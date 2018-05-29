package entity {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.fx.Flicker;
	import se.lnu.stickossdk.fx.Shake;
	import se.lnu.stickossdk.system.Session;
	
	
	//-----------------------------------------------------------
	// Entity
	// Represents an entity / game object
	//-----------------------------------------------------------
	
	public class Entity extends DisplayStateLayerSprite {
		
		//-----------------------------------------------------------
		// Protected properties
		//-----------------------------------------------------------
		
		protected var m_pos:Point;
		protected var _appWidth:int = 0;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const DEFAULT_SCALE:int = 2;
		private var m_shake:Shake;
		private var m_flicker:Flicker;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Entity() {
			super();
			this._appWidth = Session.application.size.x;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**
		 * update
		 * Override
		 */
		override public function update():void {
//			super.update();
		}
		
		
		/**
		 * init
		 * Override
		 */
		override public function init():void {
			super.init();
		}
		
		
		/**
		 * Dispose
		 * Override 
		 */
		override public function dispose():void {
			trace("Entity dispose")
			this.m_pos = null;
			this._appWidth = 0;
			this.m_shake = null;
			this.m_flicker = null;
		}
		
		/**
		 * Helper method to set DisplayObjectContainer scales
		 */
		public function setScale(obj:DisplayObjectContainer, scaleX:int = this.DEFAULT_SCALE, scaleY:int = this.DEFAULT_SCALE):void {
			if (obj != null) {
				obj.scaleX = scaleX;
				obj.scaleY = scaleY;
			}
		}
		
		
		
		/**
		 * Helper effect to shake DisplayObjectContainer
		 */
		public function shake(obj:DisplayObjectContainer, amountY:int):void {
			this.m_shake = new Shake(obj, 150, new Point(0,amountY), new Point(0,0));
			Session.effects.add(this.m_shake);
		}
		
		
		/**
		 * Helper effect to flicker / blink DisplayObjectContainer
		 */
		public function flicker(obj:DisplayObjectContainer, duration:int = 1000, interval:int = 30):void {
			this.m_flicker = new Flicker(obj, duration, interval, true);
			Session.effects.add(this.m_flicker);
		}
	}
}