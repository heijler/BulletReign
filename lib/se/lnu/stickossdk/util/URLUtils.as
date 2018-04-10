package se.lnu.stickossdk.util {
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	En samling statiska metoder för att underlätta 
	 *	URL-hantering med ActionScript 3.0.
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-29
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class URLUtils {
		
		//-------------------------------------------------------
		// Public static methods
		//-------------------------------------------------------
		
		/**
		 *	Kodar en sträng till en URL-kompatibel sträng.
		 * 
		 *	@param	input				Sträng att koda.
		 *	@param	usePlusForSpace		Plustecken eller %20.
		 * 
		 *	@return	Den kodade URL-strängen.
		 */
		public static function encode(input:String, usePlusForSpace:Boolean=false):String {
			var output:String = "";
			var i:Number = 0;
			var exclude:RegExp = /(^[a-zA-Z0-9_\.~-]*)/;
			
			var match:Object;
			var charCode:Number;
			var hexVal:String;
			
			while (i < input.length) {
				match = exclude.exec(input.substr(i));
				
				if (match != null && match.length > 1 && match[1] != '') {
					output += match[1];
					i += match[1].length;
				} else {
					if (input.substr(i,1) == " ") {
						if (usePlusForSpace) {
							output += "+";
						} else {
							output += "%20";
						}
					} else {
						charCode = input.charCodeAt(i);
						hexVal = charCode.toString(16);
						output += "%" + ( hexVal.length < 2 ? "0" : "" ) + hexVal.toUpperCase();
					}
					i++;
				}
			}
			
			return output;
		}
		
		/**
		 *	Avkodar en URL-sträng till en sträng.
		 * 
		 *	@param	encodedString	Sträng att avkoda.
		 * 
		 *	@return	Den avkodade URL-strängen
		 */
		public static function decode(encodedString:String):String {
			var output:String = encodedString;
			var myregexp:RegExp = /(%[^%]{2})/;
			
			var binVal:Number;
			var thisString:String;
			
			var match:Object;
			
			var plusPattern:RegExp = /\+/gm;
			output = output.replace(plusPattern," ");
			
			while ((match = myregexp.exec(output)) != null && match.length > 1 && match[1] != '') {
				binVal = parseInt(match[1].substr(1),16);
				thisString = String.fromCharCode(binVal);
				output = output.replace(match[1], thisString);
			}
			
			return output;
		}
	}
}