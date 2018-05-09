package entity.fx {
	import flash.display.Sprite;

	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	//-----------------------------------------------------------
	// SmokeCloud
	//-----------------------------------------------------------
	public class SmokeCloud extends Effect {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const TRAIL_SIZE:int = 4;
		private var m_alphaDecay:Number = 0.03;
		private var m_skin:Sprite;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		public function SmokeCloud(pos:Point) {
			super();
			this.m_pos = pos;
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
			this.m_skin = new Sprite();
			this.m_skin.graphics.beginFill(0xEBEBEB);
			this.m_skin.graphics.drawRect(-this.TRAIL_SIZE * 0.5, -this.TRAIL_SIZE * 0.5, this.TRAIL_SIZE, this.TRAIL_SIZE);
			this.m_skin.graphics.endFill();
			this._setScale(this.m_skin);
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
		private function m_setSpawnPosition():void {
			this.x = this.m_createJitter(this.m_pos.x, 2);
			this.y = this.m_createJitter(this.m_pos.y, 2);
			this.rotation = this._angle;
		}
		
		
		/**
		 * 
		 */
		private function m_createJitter(num:Number, amount:Number):Number {
			return num + (Math.random() * amount);
		}
		
		
		
		/**
		 * 
		 */
		override public function dispose():void {
			trace("Dispose Trail! REMOVE ME WHEN ACTUALLY DISPOSING.");
		}
	}
}