package entity.fx {
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	//-----------------------------------------------------------
	// Trail
	//-----------------------------------------------------------
	
	public class Trail extends entity.fx.Effect {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const TRAIL_SIZE:int = 4;
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
			this.m_initSkin();
			this.m_setSpawnPosition();
		}
		
		
		/**
		 * 
		 */
		private function m_initSkin():void {
//			var rand:Number = this.TRAIL_SIZE + (Math.random() * 2)
			this.m_skin = new Sprite();
			this.m_skin.graphics.beginFill(0xB2B2B2);
			this.m_skin.graphics.drawRect(-this.TRAIL_SIZE * 0.5, -this.TRAIL_SIZE * 0.5, this.TRAIL_SIZE, this.TRAIL_SIZE);
			this.m_skin.graphics.endFill();
			this._setScale(this.m_skin);
			this.addChild(this.m_skin);
			this.alpha = 0.5
		}
		
		
		/**
		 * 
		 */
		override public function update():void {
			this.applyGravity();
//			trace("Trail update");
			this.alpha -= 0.03;
			this.width -= 0.3;
			this.height -= 0.3;
//			this.y -= 0.2;
		}
		
		
		/**
		 * 
		 */
		private function m_setSpawnPosition():void {
			this.x = this.m_pos.x + (Math.random() * 2); //*4 jitter
			this.y = this.m_pos.y + (Math.random() * 2); //*4 jitter
			this.rotation = this._angle;
		}
		
		
		/**
		 * 
		 */
		override public function dispose():void {
			trace("Trail dispose")
		}
	}
}