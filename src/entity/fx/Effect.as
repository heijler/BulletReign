package entity.fx {
	
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import entity.MotionEntity;
	
	//-----------------------------------------------------------
	// Effect
	// Represents the basics of one effect
	//-----------------------------------------------------------
	
	public class Effect extends MotionEntity {
		
		//-----------------------------------------------------------
		// Protected properties
		//-----------------------------------------------------------
		
		protected var type:String;
		protected var _pos:Point;
		protected var _hasGravity:Boolean = false;
		protected var _canGrow:Boolean    = false;
		protected var _canFade:Boolean    = false;
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
		 * Init
		 * Override
		 */
		override public function init():void {
			super.init();
		}
		
		
		/**
		 * Update
		 * Override
		 */
		override public function update():void {
			super.update();
			this._effectGrowth();
			this._effectGravity();
		}
		
		
		/**
		 * Dispose
		 * Override
		 */
		override public function dispose():void {
			trace("Effect dispose");
			this.type = "";
			this._pos = null;
			this._hasGravity = false;
			this._canGrow = false;
			this._canFade = false;
			this._skin = null;
		}
		
		
		//-----------------------------------------------------------
		// Protected methods
		//-----------------------------------------------------------
		
		/**
		 * Takes a number and returns it with some amount of Jitter
		 * @num : Number - The number to jitter
		 * @amount : Number - The max amount of jitter possible.
		 */
		protected function _createJitter(num:Number, amount:Number):Number {
			return num + (Math.random() * amount);
		}
		
		
		/**
		 * Grows or shrinks displayObject
		 * @param amount : Number - amount to shrink (if negative value) or grow (positive value)
		 */
		protected function _effectGrowth(amount:Number = -0.03):void {
			if (this._canGrow) {
				this.width += amount;
				this.height += amount;
			}
		}
		
		
		/**
		 * Applies gravity in either direction
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
		 * Fades in or out
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