package se.lnu.stickossdk.util
{
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	En samling statiska metoder för att underlätta 
	 *	matematiska beräkningar i ActionScript 3.0.
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-17
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class MathUtils {
		
		//-------------------------------------------------------
		// Public static methods
		//-------------------------------------------------------
		
		/**
		 *	Genererar ett decimaltal som existerar inom ett 
		 *	intervall där -a är min-värde och +a är max-värde. 
		 *	Summan av funktionen är aldrig större än abs(a).
		 * 
		 *	@return Number
		 */
		public static function absltx(a:Number):Number {
			return ((Math.random() - .5) * 2) * a;
		}
		
		/**
		 *	Begränsar ett tal till ett min- och max-värde.
		 * 
		 *	@param	value		Värde att behandla.
		 *	@param	min			min-värde.
		 *	@param	max			max-värde.
		 * 
		 *	@return	Det behandlade värdet.
		 */
		public static function clamp(value:Number, min:Number, max:Number):Number {
			if (max > min) {
				if (value < min) return min;
				else if (value > max) return max;
				else return value;
			} else {
				if (value < max) return max;
				else if (value > min) return min;
				else return value;
			}
		}
		
		/**
		 *	Begränsar en tvådimensionell position till en 
		 *	rektangels area.
		 * 
		 *	@param	object		Objektet som är begränsat.
		 *	@param	rect		Begränsningsarean.
		 *	@param	padding		Eventuell padding.
		 * 
		 *	@return	void
		 */
		public static function clampInRect(obj:Object, rect:Rectangle, padding:Number = 0):void {
			obj.x = clamp(obj.x, rect.x + padding, rect.x + rect.width  - padding);
			obj.y = clamp(obj.y, rect.y + padding, rect.y + rect.height - padding);
		}
		
		/**
		 *	Beräknar avståendet mellan två punkter.
		 * 
		 *	@param	p1	Den första punkten.
		 *	@param	p2	Den andra punkten.
		 * 
		 *	@return Avståndet mellan p1 och p2.
		 */
		public static function distanceBetweenPoints(p1:Point, p2:Point):Number {
			var dx:Number = p1.x-p2.x;
			var dy:Number = p1.y-p2.y;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		/**
		 *	Slumpar tal mellan intervall
		 * 
		 *	@param	min	start
		 *	@param	max	end
		 * 
		 *	@return Avståndet mellan p1 och p2.
		 */
		public static function randomRange(min:Number, max:Number):Number {
			return Math.random() * (max - min + 1) + min;
		}
		
		/**
		 *	...
		 * 
		 * 	@param a Trolighetsfaktor, 100 är alltid, 0 är aldrig.
		 */
		public static function chance(a:int):Boolean {
			return Boolean(Math.random() > (100 - a) / 100);
		}
	}
}