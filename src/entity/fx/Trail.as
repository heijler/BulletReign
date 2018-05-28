package entity.fx {
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	//-----------------------------------------------------------
	// Trail
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
		 * 
		 */
		override public function init():void {
			super.init();
			this.m_initSkin();
			this.m_setSpawnPosition();
		}
		
		
		/**
		 * 
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
		 * 
		 */
		override public function update():void {
			this.applyGravity();
			this.alpha -= this.m_alphaDecay;
			this.width -= 0.3;
			this.height -= 0.3;
			this.y -= 0.2;
		}
		
		
		/**
		 * 
		 */
		override public function dispose():void {
			trace("disposing Trail");
			this.m_alphaDecay = 0;
			this.m_skin = null;
			this.m_pos = null;
			this._angle = 0;
		}
		
		
		/**
		 * 
		 */
		private function m_setSpawnPosition():void {
			this.x = this._createJitter(this.m_pos.x, 2);
			this.y = this._createJitter(this.m_pos.y, 2);
			this.rotation = this._angle;
		}
	}
}