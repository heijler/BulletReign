package se.lnu.stickossdk.tween.easing {
	
	//-----------------------------------------------------------
	// Static class
	//-----------------------------------------------------------
	
	/**
	 *	Denna klass erbjuder tre dämpningsfunktioner för 
	 *	interpoleringsbaserade animationer med ActionScript 3.0.
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-24
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Back  {
		
		//-------------------------------------------------------
		// Public static methods
		//-------------------------------------------------------
		
		/**
		 *	Metoden easeIn() startar rörelsen genom att gå bakåt 
		 *	och sedan byta riktning och flytta mot målet.
		 *
		 *	@param	t	Anger aktuell tid, mellan 0 till och med varaktighet.
		 *	@param	b	Anger det ursprungliga värdet för animeringsegenskapen.
		 *	@param	c	Anger den sammanlagda förändringen i animeringsegenskapen.
		 *	@param	d	Anger rörelsens varaktighet.
		 *	@param	a	Anger mängden som skjuter över, ju högre värde, desto mer skjuts över.
		 * 
		 *	@return Värdet av en interpolerad egenskap vid en angiven tidpunkt.
		 */
		public static function easeIn (t:Number, b:Number, c:Number, d:Number, s:Number = 1.70158):Number {
			return c*(t/=d)*t*((s+1)*t - s) + b;
		}

		/**
		 *	Metoden easeInOut() kombinerar rörelserna för 
		 *	metoderna easeIn() och easeOut() så att rörelsen 
		 *	startas bakåt, sedan ändras riktningen och går mot 
		 *	målet, skjuter över målet något, byter riktning igen 
		 *	och går tillbaka mot målet igen.
		 *
		 *	@param	t	Anger aktuell tid, mellan 0 till och med varaktighet.
		 *	@param	b	Anger det ursprungliga värdet för animeringsegenskapen.
		 *	@param	c	Anger den sammanlagda förändringen i animeringsegenskapen.
		 *	@param	d	Anger rörelsens varaktighet.
		 *	@param	s	Anger mängden som skjuter över, ju högre värde, desto mer skjuts över.
		 * 
		 *	@return Värdet av en interpolerad egenskap vid en angiven tidpunkt.
		 */
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number, s:Number = 1.70158):Number {
			if ((t/=d*0.5) < 1) return c*0.5*(t*t*(((s*=(1.525))+1)*t - s)) + b;
			return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
		}

		/**
		 *	Metoden easeOut() startar rörelsen genom flytta mot 
		 *	målet, skjuta över det något och sedan byta riktning 
		 *	tillbaka mot målet.
		 *
		 *	@param	t	Anger aktuell tid, mellan 0 till och med varaktighet.
		 *	@param	b	Anger det ursprungliga värdet för animeringsegenskapen.
		 *	@param	c	Anger den sammanlagda förändringen i animeringsegenskapen.
		 *	@param	d	Anger rörelsens varaktighet.
		 *	@param	s	Anger mängden som skjuter över, ju högre värde, desto mer skjuts över.
		 * 
		 *	@return Värdet av en interpolerad egenskap vid en angiven tidpunkt.
		 */
		public static function easeOut (t:Number, b:Number, c:Number, d:Number, s:Number = 1.70158):Number {
			return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
		}
	}
}
