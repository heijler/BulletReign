package se.lnu.stickossdk.tween.easing
{
	//-----------------------------------------------------------
	// Static class
	//-----------------------------------------------------------
	
	/**
	 *	The Quintic class defines three easing functions to 
	 *	implement motion with ActionScript. The acceleration of 
	 *	motion for a Quintic easing equation is greater than for 
	 *	a Quadratic, Cubic, or Quartic easing equation.
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Quart {
		
		//-------------------------------------------------------
		// Public static methods
		//-------------------------------------------------------
		
		/**
		 *	The easeIn method starts motion from zero velocity, 
		 *	and then accelerates motion as it executes.
		 *
		 *	@param	Number	Specifies the current time, between 0 and duration inclusive.
		 *	@param	Number	Specifies the initial value of the animation property.
		 *	@param	Number	Specifies the total change in the animation property.
		 *	@param	Number	Specifies the duration of the motion.
		 *	@param	Number	Specifies the amount of overshoot, where the higher the value, the greater the overshoot.
		 * 
		 *	@return Number	The value of the interpolated property at the specified time.
		 */
		public static function easeIn (t:Number, b:Number, c:Number, d:Number):Number {
			return c*(t/=d)*t*t*t + b;
		}
		
		/**
		 *	The easeOut method starts motion fast, and then 
		 *	decelerates motion to a zero velocity as it executes.
		 *
		 *	@param	Number	Specifies the current time, between 0 and duration inclusive.
		 *	@param	Number	Specifies the initial value of the animation property.
		 *	@param	Number	Specifies the total change in the animation property.
		 *	@param	Number	Specifies the duration of the motion.
		 *	@param	Number	Specifies the amount of overshoot, where the higher the value, the greater the overshoot.
		 * 
		 *	@return Number	The value of the interpolated property at the specified time.
		 */
		public static function easeOut (t:Number, b:Number, c:Number, d:Number):Number {
			return -c * ((t=t/d-1)*t*t*t - 1) + b;
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
		 *	@param	Number	Specifies the amount of overshoot, where the higher the value, the greater the overshoot.
		 * 
		 *	@return Number	The value of the interpolated property at the specified time.
		 */
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number {
			if ((t/=d*0.5) < 1) return c*0.5*t*t*t*t + b;
			return -c*0.5 * ((t-=2)*t*t*t - 2) + b;
		}
	}
}