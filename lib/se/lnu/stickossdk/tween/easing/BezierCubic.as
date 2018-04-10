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
	public class BezierCubic {
		
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
		public static function easeX (u:Number, anchor1:Point, anchor2:Point, control1:Point, control2:Point):Number {
			return Math.pow(u, 3) * (anchor2.x + 3 * (control1.x - control2.x) - anchor1.x) + 3 * Math.pow(u, 2) * (anchor1.x - 2 * control1.x + control2.x) + 3 * u * (control1.x - anchor1.x) + anchor1.x;
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
		public static function easeY (u:Number, anchor1:Point, anchor2:Point, control1:Point, control2:Point):Number {
			return Math.pow(u, 3) * (anchor2.y + 3 * (control1.y - control2.y) - anchor1.y) + 3 * Math.pow(u, 2) * (anchor1.y - 2 * control1.y + control2.y) + 3 * u * (control1.y - anchor1.y) + anchor1.y;
		}
	}
}