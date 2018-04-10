package se.lnu.stickossdk.tween.easing
{
	//-----------------------------------------------------------
	// Static class
	//-----------------------------------------------------------
	
	/**
	 *	The Circular class defines three easing functions to 
	 *	implement circular motion with the engine.
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Circular {
		//-------------------------------------------------------
		// Public static methods
		//-------------------------------------------------------
		
		/**
		 *	The easeIn method starts motion slowly, and then 
		 *	accelerates motion as it executes.
		 *
		 *	@param	Number	Specifies the current time, between 0 and duration inclusive. 
		 *	@param	Number	Specifies the initial value of the animation property. 
		 *	@param	Number	Specifies the total change in the animation property. 
		 *	@param	Number	Specifies the duration of the motion. 
		 * 
		 *	@return Number	The value of the interpolated property at the specified time.
		 */
		public static function easeIn (t:Number, b:Number, c:Number, d:Number):Number {
			return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;
		}
		
		/**
		 *	The easeOut method starts motion fast, and then 
		 *	decelerates motion as it executes.
		 *
		 *	@param	Number	Specifies the current time, between 0 and duration inclusive. 
		 *	@param	Number	Specifies the initial value of the animation property. 
		 *	@param	Number	Specifies the total change in the animation property. 
		 *	@param	Number	Specifies the duration of the motion. 
		 * 
		 *	@return Number	The value of the interpolated property at the specified time.
		 */
		public static function easeOut (t:Number, b:Number, c:Number, d:Number):Number 
		{
			return c * Math.sqrt(1 - (t=t/d-1)*t) + b;
		}
		
		/**
		 *	The easeInOut method combines the motion of the easeIn 
		 *	and easeOut methods to start the motion slowly, accelerate 
		 *	motion, then decelerate.
		 *
		 *	@param	Number	Specifies the current time, between 0 and duration inclusive. 
		 *	@param	Number	Specifies the initial value of the animation property. 
		 *	@param	Number	Specifies the total change in the animation property. 
		 *	@param	Number	Specifies the duration of the motion. 
		 * 
		 *	@return Number	The value of the interpolated property at the specified time.
		 */
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number {
			if ((t/=d*0.5) < 1) return -c*0.5 * (Math.sqrt(1 - t*t) - 1) + b;
			return c*0.5 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
		}
	}
}