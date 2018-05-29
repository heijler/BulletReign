package entity.fx {
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	//-----------------------------------------------------------
	// Trail
	// Represents one Trail Effect / smoke trail puff resulting
	// from the plane accelerating
	//-----------------------------------------------------------
	
	public class Trail extends Effect {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const TRAIL_SIZE:int = 4;
		private var m_alphaDecay:Number = 0.03;
		private var m_skin:Sprite;
		
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Trail(pos:Point, angle) {
			super();
			this.m_pos = pos;
			this._angle = angle;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**
		 * init
		 * override
		 */
		override public function init():void {
			super.init();
			this.m_initSkin();
			this.m_setSpawnPosition();
		}
		
		
		/**
		 * Update
		 * override
		 */
		override public function update():void {
			this.applyGravity();
			this.alpha -= this.m_alphaDecay;
			this.width -= 0.3;
			this.height -= 0.3;
			this.y -= 0.2;
		}
		
		
		/**
		 * Dispose
		 * override
		 */
		override public function dispose():void {
			trace("Trail dispose");
			this.m_alphaDecay = 0;
			if(this.m_skin.parent != null) {
				this.removeChild(this.m_skin);
			}
			this.m_skin = null;
			this.m_pos = null;
			this._angle = 0;
		}
		
		
		/**
		 * Initialize skin
		 */
		private function m_initSkin():void {
			this.m_skin = new Sprite();
			this.m_skin.graphics.beginFill(0xFFF392);
			this.m_skin.graphics.drawRect(-this.TRAIL_SIZE * 0.5, -this.TRAIL_SIZE * 0.5, this.TRAIL_SIZE, this.TRAIL_SIZE);
			this.m_skin.graphics.endFill();
			this.setScale(this.m_skin);
			this.addChild(this.m_skin);
			this.alpha = 0.7; // Starting alpha
		}
		
		
		/**
		 * Sets the Trail position with some jitter to give 
		 * life to the resulting animation of the effect.
		 */
		private function m_setSpawnPosition():void {
			this.x = this._createJitter(this.m_pos.x, 2);
			this.y = this._createJitter(this.m_pos.y, 2);
			this.rotation = this._angle;
		}
	}
}