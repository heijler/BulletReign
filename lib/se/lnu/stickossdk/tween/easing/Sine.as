package se.lnu.stickossdk.tween.easing
{
	//-----------------------------------------------------------
	// Static class
	//-----------------------------------------------------------
	
	/**
	 *	The Regular class defines three easing functions to 
	 *	implement accelerated motion with ActionScript 
	 *	animations. The acceleration of motion for a Sine easing 
	 *	equation is the same as for a timeline tween at 100% 
	 *	easing and is less dramatic than for the Strong easing 
	 * 	equation.
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Sine {
		
		//-------------------------------------------------------
		// Private static properties
		//-------------------------------------------------------
		
		/**
		 *	The sum of pi divided in two.
		 * 
		 *	@default PI/2
		 */
		private static const _HALF_PI:Number = Math.PI * 0.5;
		
		//-------------------------------------------------------
		// Public static methods
		//-------------------------------------------------------
		
		/**
		 *	The easeIn method starts motion from a zero velocity 
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
			return -c * Math.cos(t/d * _HALF_PI) + c + b;
		}
		
		/**
		 *	The easeOut() method starts motion fast and then 
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
			return c * Math.sin(t/d * _HALF_PI) + b;
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
			return -c*0.5 * (Math.cos(Math.PI*t/d) - 1) + b;
		}
	}
}