package se.lnu.stickossdk.tween.easing
{
	//-----------------------------------------------------------
	// Static class
	//-----------------------------------------------------------
	
	/**
	 *	Klassen Bounce definierar tre övergångsfunktioner som 
	 *	implementerar studsande rörelse med en 
	 *	ActionScript-animering, liknande den när en boll studsar 
	 *	lägre och lägre över ett golv.
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-24
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Bounce {
		
		//-------------------------------------------------------
		// Public static methods
		//-------------------------------------------------------
		
		/**
		 *	Metoden easeIn() startar studsrörelsen långsamt och 
		 *	accelererar sedan rörelsen när den utförs.
		 *
		 *	@param	t	Anger aktuell tid, mellan 0 till och med varaktighet.
		 *	@param	b	Anger det ursprungliga värdet för animeringsegenskapen.
		 *	@param	c	Anger den sammanlagda förändringen i animeringsegenskapen.
		 *	@param	d	Anger rörelsens varaktighet.
		 * 
		 *	@return Värdet av en interpolerad egenskap vid en angiven tidpunkt.
		 */
		public static function easeIn (t:Number, b:Number, c:Number, d:Number):Number {
			return c - easeOut(d-t, 0, c, d) + b;
		}
		
		/**
		 *	Metoden easeInOut() kombinerar rörelserna för 
		 *	metoderna easeIn() och easeOut() så att studsrörelsen 
		 *	startas långsamt, sedan ökas hastigheten och sedan 
		 *	bromsas den.
		 *
		 *	@param	t	Anger aktuell tid, mellan 0 till och med varaktighet.
		 *	@param	d	Anger det ursprungliga värdet för animeringsegenskapen.
		 *	@param	c	Anger den sammanlagda förändringen i animeringsegenskapen.
		 *	@param	d	Anger rörelsens varaktighet.
		 * 
		 *	@return Värdet av en interpolerad egenskap vid en angiven tidpunkt.
		 */
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number {
			if (t < d*0.5) return easeIn (t*2, 0, c, d) * .5 + b;
			else return easeOut (t*2-d, 0, c, d) * .5 + c*.5 + b;
		}
		
		/**
		 *	Metoden easeOut() startar den studsande rörelsen 
		 *	snabbt och bromsar sedan rörelsen när den utförs.
		 *
		 *	@param	t	Anger aktuell tid, mellan 0 till och med varaktighet.
		 *	@param	d	Anger det ursprungliga värdet för animeringsegenskapen.
		 *	@param	c	Anger den sammanlagda förändringen i animeringsegenskapen.
		 *	@param	d	Anger rörelsens varaktighet.
		 * 
		 *	@return Värdet av en interpolerad egenskap vid en angiven tidpunkt.
		 */
		public static function easeOut (t:Number, b:Number, c:Number, d:Number):Number {
			if ((t=t/d) < (1/2.75)) {
				return c*(7.5625*t*t) + b;
			} else if (t < (2/2.75)) {
				return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
			} else if (t < (2.5/2.75)) {
				return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
			} else {
				return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
			}
		}
	}
}