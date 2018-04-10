package se.lnu.stickossdk.tween.easing
{
	//-----------------------------------------------------------
	// Static class
	//-----------------------------------------------------------
	
	/**
	 *	TODO
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Quad {
		//-------------------------------------------------------
		// Public static methods
		//-------------------------------------------------------
		
		/**
		 *	The easeIn method starts motion from a zero velocity, 
		 *	and then accelerates motion as it executes.
		 *
		 *	@param	Number	Specifies the current time, between 0 and duration inclusive. 
		 *	@param	Number	Specifies the initial value of the animation property. 
		 *	@param	Number	Specifies the total change in the animation property. 
		 *	@param	Number	Specifies the duration of the motion. 
		 * 
		 *	@return Number	The value of the interpolated property at the specified time.
		 */
		public static function easeIn (t:Number, b:Number, c:Number, d:Number):Number {
			return c*(t/=d)*t + b;
		}
		
		/**
		 *	The easeOut method starts motion fast, and then 
		 *	decelerates motion to a zero velocity as it executes.
		 *
		 *	@param	Number	Specifies the current time, between 0 and duration inclusive. 
		 *	@param	Number	Specifies the initial value of the animation property. 
		 *	@param	Number	Specifies the total change in the animation property. 
		 *	@param	Number	Specifies the duration of the motion. 
		 * 
		 *	@return Number	The value of the interpolated property at the specified time.
		 */
		public static function easeOut (t:Number, b:Number, c:Number, d:Number):Number {
			return -c *(t/=d)*(t-2) + b;
		}
		
		/**
		 *	The easeInOut method combines the motion of the easeIn 
		 *	and easeOut methods to start the motion from a zero 
		 *	velocity, accelerate motion, then decelerate to a zero 
		 *	velocity.
		 *
		 *	@param	Number	Specifies the current time, between 0 and duration inclusive. 
		 *	@param	Number	Specifies the initial value of the animation property. 
		 *	@param	Number	Specifies the total change in the animation property. 
		 *	@param	Number	Specifies the duration of the motion. 
		 * 
		 *	@return Number	The value of the interpolated property at the specified time.
		 */
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number {
			if ((t/=d*0.5) < 1) return c*0.5*t*t + b;
			return -c*0.5 * ((--t)*(t-2) - 1) + b;
		}
	}
}