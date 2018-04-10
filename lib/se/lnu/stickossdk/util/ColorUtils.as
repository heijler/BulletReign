package se.lnu.stickossdk.util {
	
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
	 *	@since		2014-01-27
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class ColorUtils {
		
		//-------------------------------------------------------
		// Public static methods
		//-------------------------------------------------------
		
		/**
		 *	Skapar en färg baserat på RGB-värden.
		 * 
		 *	@param	R	Värdet för röd, från 0 till 255.
		 *	@param	G	Värdet för grön, från 0 till 255.
		 *	@param	B	Värdet för blå, från 0 till 255.
		 * 
		 *	@return uint
		 */
		public static function getColorRGB(R:uint = 0, G:uint = 0, B:uint = 0):uint {
			return R << 16 | G << 8 | B;
		}
		
		/**
		 *	Skapar en färg baserat på HSV-värden.
		 * 
		 *	@param	h		Färgens nyans, från 0 till 1.
		 *	@param	s		Färgens mättnad, från 0 till 1.
		 *	@param	v		Färgens värde, från 0 till 1.
		 * 
		 *	@return uint
		 */
		public static function getColorHSV(h:Number, s:Number, v:Number):uint {
			h = h < 0 ? 0 : (h > 1 ? 1 : h);
			s = s < 0 ? 0 : (s > 1 ? 1 : s);
			v = v < 0 ? 0 : (v > 1 ? 1 : v);
			h = int(h * 360);
			
			var hi:int = int(h / 60) % 6,
				f:Number = h / 60 - int(h / 60),
				p:Number = (v * (1 - s)),
				q:Number = (v * (1 - f * s)),
				t:Number = (v * (1 - (1 - f) * s));
			
			switch (hi) {
				case 0: return int(v * 255) << 16 | int(t * 255) << 8 | int(p * 255);
				case 1: return int(q * 255) << 16 | int(v * 255) << 8 | int(p * 255);
				case 2: return int(p * 255) << 16 | int(v * 255) << 8 | int(t * 255);
				case 3: return int(p * 255) << 16 | int(q * 255) << 8 | int(v * 255);
				case 4: return int(t * 255) << 16 | int(p * 255) << 8 | int(v * 255);
				case 5: return int(v * 255) << 16 | int(p * 255) << 8 | int(q * 255);
				default: return 0;
			}
		}
		
		/**
		 *	Beräknar färgens röda färgskala.
		 * 
		 *	@param	color	Färgen som ska behandlas.
		 * 
		 *	@return	Ett värde mellan 0 och 255.
		 */
		public static function getRed(color:uint):uint {
			return color >> 16 & 0xFF;
		}
		
		/**
		 *	Beräknar färgens gröna färgskala.
		 * 
		 *	@param	color	Färgen som ska behandlas.
		 * 
		 *	@return	Ett värde mellan 0 och 255.
		 */
		public static function getGreen(color:uint):uint {
			return color >> 8 & 0xFF;
		}
		
		/**
		 *	Beräknar färgens blåa färgskala.
		 * 
		 *	@param	color	Färgen som ska behandlas.
		 * 
		 *	@return	Ett värde mellan 0 och 255.
		 */
		public static function getBlue(color:uint):uint {
			return color & 0xFF;
		}
		
		/**
		 *	Skapar en linjär interpolering (tween) mellan en färg 
		 *	till en annan.
		 * 
		 *	@param	fromColor		Startfärgen.
		 *	@param	toColor			Slutfärgen.
		 *	@param	t				Interpoleringsvärde, från 0 till 1.
		 * 
		 *	return	RGB-värde för ett enskilt steg i interpoleringen.
		 */
		public static function colorLerp(fromColor:uint, toColor:uint, t:Number = 1):uint {
			if (t <= 0) { return fromColor; }
			if (t >= 1) { return toColor; }
			
			var a:uint = fromColor >> 24 & 0xFF,
				r:uint = fromColor >> 16 & 0xFF,
				g:uint = fromColor >> 8 & 0xFF,
				b:uint = fromColor & 0xFF,
				dA: int = (toColor >> 24 & 0xFF) - a,
				dR: int = (toColor >> 16 & 0xFF) - r,
				dG: int = (toColor >> 8 & 0xFF) - g,
				dB: int = (toColor & 0xFF) - b;
			
			a += dA * t;
			r += dR * t;
			g += dG * t;
			b += dB * t;
			
			return a << 24 | r << 16 | g << 8 | b;
		}
	}
}