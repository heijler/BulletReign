package se.lnu.stickossdk.tween.easing
{
	//-----------------------------------------------------------
	// Static class
	//-----------------------------------------------------------
	
	/**
	 *	The Linear class defines easing functions to implement 
	 *	nonaccelerated motion with ActionScript animations. Its 
	 *	methods all produce the same effect, a constant motion. 
	 *	The various names, easeIn, easeOut and so on are provided 
	 *	in the interest of polymorphism. The None class is 
	 *	identical to the fl.motion.easing.Linear class in 
	 *	functionality.
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Linear {
		//-------------------------------------------------------
		// Public static methods
		//-------------------------------------------------------
		
		/**
		 *	The easeNone method defines a constant motion, with 
		 *	no acceleration.
		 *
		 *	@param	Number	Specifies the current time, between 0 and duration inclusive.
		 *	@param	Number	Specifies the initial value of the animation property.
		 *	@param	Number	Specifies the total change in the animation property.
		 *	@param	Number	Specifies the duration of the motion.
		 * 
		 *	@return Number	 The value of the interpolated property at the specified time.
		 */
		public static function easeNone (t:Number, b:Number, c:Number, d:Number):Number {
			return c*t/d + b;
		}

		/**
		 *	The easeIn method defines a constant motion, with 
		 *	no acceleration.
		 *
		 *	@param	Number	Specifies the current time, between 0 and duration inclusive.
		 *	@param	Number	Specifies the initial value of the animation property.
		 *	@param	Number	Specifies the total change in the animation property.
		 *	@param	Number	Specifies the duration of the motion.
		 * 
		 *	@return Number	 The value of the interpolated property at the specified time.
		 */
		public static function easeIn (t:Number, b:Number, c:Number, d:Number):Number {
			return c*t/d + b;
		}

		/**
		 *	The easeInOut() method defines a constant motion, with 
		 *	no acceleration.
		 *
		 *	@param	Number	Specifies the current time, between 0 and duration inclusive.
		 *	@param	Number	Specifies the initial value of the animation property.
		 *	@param	Number	Specifies the total change in the animation property.
		 *	@param	Number	Specifies the duration of the motion.
		 * 
		 *	@return Number	 The value of the interpolated property at the specified time.
		 */
		public static function easeOut (t:Number, b:Number, c:Number, d:Number):Number {
			return c*t/d + b;
		}

		/**
		 *	The easeInOut() method defines a constant motion, with 
		 *	no acceleration.
		 *
		 *	@param	Number	Specifies the current time, between 0 and duration inclusive.
		 *	@param	Number	Specifies the initial value of the animation property.
		 *	@param	Number	Specifies the total change in the animation property.
		 *	@param	Number	Specifies the duration of the motion.
		 * 
		 *	@return Number	 The value of the interpolated property at the specified time.
		 */
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number {
			return c*t/d + b;
		}
	}
}