package entity.fx {
	
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import entity.MotionEntity;
	
	//-----------------------------------------------------------
	// Effect
	//-----------------------------------------------------------
	
	public class Effect extends MotionEntity {
		
		//-----------------------------------------------------------
		// Protected properties
		//-----------------------------------------------------------
		
		protected var type:String;
		protected var _pos:Point;
		protected var _hasGravity:Boolean;
		protected var _canGrow:Boolean;
		protected var _canFade:Boolean;
		protected var _skin:Sprite;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Effect() {
			super();
		}
		
		//-----------------------------------------------------------
		// Public methods
		//-----------------------------------------------------------
		
		
		/**
		 * 
		 */
		override public function init():void {
			super.init();
		}
		
		
		/**
		 * 
		 */
		override public function update():void {
			super.update();
			this._effectGrowth();
			this._effectGravity();
		}
		
		
		/**
		 * 
		 */
		override public function dispose():void {
			
		}
		
		
		/**
		 * setSpawn
		 */
		public function setSpawn(pos:Point):void {
			
		}
		
		//-----------------------------------------------------------
		// Protected methods
		//-----------------------------------------------------------
		
		/**
		 * _createJitter
		 * @num : Number - The number to jitter
		 * @amount : Number - The max amount of jitter possible.
		 */
		protected function _createJitter(num:Number, amount:Number):Number {
			return num + (Math.random() * amount);
		}
		
		
		/**
		 * _effectGrowth
		 * @param amount : Number - amount to shrink (if negative value) or grow (positive value)
		 */
		protected function _effectGrowth(amount:Number = -0.03):void {
			if (this._canGrow) {
				this.width += amount;
				this.height += amount;
			}
		}
		
		
		/**
		 * _effectGravity
		 * direction false = up
		 * direction true = down
		 * direction default down
		 * @param direction : Boolean 
		 */
		protected function _effectGravity(direction:Boolean = true, amount:int = 1):void {
			if (this._hasGravity) {
				this.applyGravity(direction);
				this.setGravityFactor(amount);
			}
		}
		
		
		/**
		 * _effectFade
		 * amount positive = fade in
		 * amount negative = fade out
		 * amount default  = fade out
		 * @param amount : Number - Amount to fade in (positive value) or out (negative value)
		 */
		protected function _effectFade(amount:Number = -0.03):void {
			if (this._canFade) {
				this.alpha += amount;
			}
		}

		
		
		
		
	}
}