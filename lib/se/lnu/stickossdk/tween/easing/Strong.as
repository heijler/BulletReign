package se.lnu.stickossdk.tween.easing {
	
	//-----------------------------------------------------------
	// Static class
	//-----------------------------------------------------------
	
	/**
	 *	Klassen Strong definierar tre övergångsfunktioner som 
	 *	implementerar rörelse med ActionScript-animeringar. Den 
	 *	accelererande rörelsen för en Strong-övergångsfunktion är 
	 *	större än för en Regular-övergångsfunktion. Klassen 
	 *	Strong är identisk med klassen 
	 *	se.lnu.stickossdk.tween.easing.Quint vad gäller 
	 *	funktioner.
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Strong {
		
		//-------------------------------------------------------
		// Public static methods
		//-------------------------------------------------------
		
		/**
		 *	Metoden easeIn() startar rörelsen från noll och 
		 *	accelererar sedan rörelsen när den utförs.
		 *
		 *	@param	a	Anger aktuell tid, mellan 0 till och med varaktighet.
		 *	@param	b	Anger det ursprungliga värdet för animeringsegenskapen.
		 *	@param	c	Anger den sammanlagda förändringen i animeringsegenskapen.
		 *	@param	d	Anger rörelsens varaktighet.
		 * 
		 *	@return Värdet av en interpolerad egenskap vid en angiven tidpunkt.
		 */
		public static function easeIn(t:Number, b:Number, c:Number, d:Number):Number {
			return c*(t/=d)*t*t*t*t + b;
		}
		
		/**
		 *	Metoden easeOut() startar rörelsen snabbt och bromsar 
		 *	sedan rörelsen till noll när den utförs.
		 *
		 *	@param	a	Anger aktuell tid, mellan 0 till och med varaktighet.
		 *	@param	b	Anger det ursprungliga värdet för animeringsegenskapen.
		 *	@param	c	Anger den sammanlagda förändringen i animeringsegenskapen.
		 *	@param	d	Anger rörelsens varaktighet.
		 * 
		 *	@return Värdet av en interpolerad egenskap vid en angiven tidpunkt.
		 */
		public static function easeOut(t:Number, b:Number, c:Number, d:Number):Number {
			return c*((t=t/d-1)*t*t*t*t + 1) + b;
		}
		
		/**
		 *	Metoden easeInOut() kombinerar rörelserna för 
		 *	metoderna easeIn() och easeOut() så att rörelsen 
		 *	startas från noll, sedan ökas hastigheten och sedan 
		 *	bromsas den till noll.
		 *
		 *	@param	a	Anger aktuell tid, mellan 0 till och med varaktighet.
		 *	@param	b	Anger det ursprungliga värdet för animeringsegenskapen.
		 *	@param	c	Anger den sammanlagda förändringen i animeringsegenskapen.
		 *	@param	d	Anger rörelsens varaktighet.
		 * 
		 *	@return Värdet av en interpolerad egenskap vid en angiven tidpunkt.
		 */
		public static function easeInOut(t:Number, b:Number, c:Number, d:Number):Number {
			if ((t/=d*0.5) < 1) return c*0.5*t*t*t*t*t + b;
			return c*0.5*((t-=2)*t*t*t*t + 2) + b;
		}
	}
}