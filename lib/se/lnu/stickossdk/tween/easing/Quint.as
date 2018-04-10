package se.lnu.stickossdk.tween.easing {
	
	//-----------------------------------------------------------
	// Static class
	//-----------------------------------------------------------
	
	/**
	 *	TODO
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-24
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Quint {
		
		//-------------------------------------------------------
		// Public static methods
		//-------------------------------------------------------
		
		/**
		 *	...
		 *
		 *	@param	Number	... 
		 *	@param	Number	... 
		 *	@param	Number	... 
		 *	@param	Number	... 
		 * 
		 *	@return Number	...
		 */
		public static function easeIn (t:Number, b:Number, c:Number, d:Number):Number {
			return c*(t/=d)*t*t*t*t + b;
		}
		
		/**
		 *	...
		 *
		 *	@param	Number	... 
		 *	@param	Number	... 
		 *	@param	Number	... 
		 *	@param	Number	... 
		 * 
		 *	@return Number	...
		 */
		public static function easeOut (t:Number, b:Number, c:Number, d:Number):Number {
			return c*((t=t/d-1)*t*t*t*t + 1) + b;
		}
		
		/**
		 *	...
		 *
		 *	@param	Number	... 
		 *	@param	Number	... 
		 *	@param	Number	... 
		 *	@param	Number	... 
		 * 
		 *	@return Number	...
		 */
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number {
			if ((t/=d*0.5) < 1) return c*0.5*t*t*t*t*t + b;
			return c*0.5*((t-=2)*t*t*t*t + 2) + b;
		}
	}
}