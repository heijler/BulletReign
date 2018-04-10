package se.lnu.stickossdk.tween.easing
{
	//-------------------------------------------------------------------------
	// Imports
	//-------------------------------------------------------------------------
	
	import flash.geom.Point;
	
	//-------------------------------------------------------------------------
	// Static class
	//-------------------------------------------------------------------------
	
	/**
	 *	...
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-15
	 *	@author		Jesper Hansson <jesper.hansson.86@gmail.com>
	 */
	public class BezierQuadratic {
		
		//---------------------------------------------------------------------
		// Public static methods
		//---------------------------------------------------------------------
		
		/**
		 *	The easeOut() method starts motion fast and then decelerates motion
		 *  to a zero velocity as it executes. 
		 *
		 *	@param	Number	Specifies the current time, between 0 and duration inclusive.
		 *	@param	Point	Specifies the point you want to tween from.
		 *	@param	Point	Specifies the point you want to tween to.
		 *	@param	Point	Specifies the point to ease towards before heading to endPoint:Point.
		 *	@param	Point	Specifies the point to ease from when heading to endPoint:Point.
		 * 
		 *	@return Number	The value of the interpolated property at the specified time.
		 */
		public static function easeX (u:Number, anchor1:Point, anchor2:Point, control1:Point):Number {
			return Math.pow(1-u, 2) * anchor1.x + 2 * u * (1-u) * control1.x + Math.pow(u, 2) * anchor2.x;
		}
		
		/**
		 *	The easeInOut method combines the motion of the easeIn and easeOut 
		 *  methods to start the motion from a zero velocity, accelerate 
		 *  motion, then decelerate to a zero velocity. 
		 *
		 *	@param	Number	Specifies the current time, between 0 and duration inclusive.
		 * 
		 *	@return Number	The value of the interpolated property at the specified time.
		 */
		public static function easeY (u:Number, anchor1:Point, anchor2:Point, control1:Point):Number {
			return Math.pow(1-u, 2) * anchor1.y + 2 * u * (1-u) * control1.y + Math.pow(u, 2) * anchor2.y;
		}
	}
}