package se.lnu.stickossdk.input {
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Representerar en inmatningstangent, exempelvis en tangent 
	 *	på ett tangentbord.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-22
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class InputKey {
		
		//-------------------------------------------------------
		// Public constants
		//-------------------------------------------------------
		
		/**
		 *	Standardnamnet för alla input-tangenter.
		 * 
		 *	@default "undefined"
		 */
		public static const UNDEFINED:String = "undefined";
		
		//------------------------------------------------------
		
		/**
		 *	Definierar värdet av en tangents inaktiva tillstånd.
		 * 
		 *	@default 0
		 */
		public static const INACTIVE:int = 0;
		
		/**
		 *	Definierar värdet av en tangents aktiva tillstånd.
		 * 
		 *	@default 1
		 */
		public static const PRESSED:int = 1;
		
		/**
		 *	Definierar värdet av en tangents nyligen aktiva 
		 *	tillstånd. Detta innebär att tangenten var aktiv vid 
		 *	en föregående bildruta (frame).
		 * 
		 *	@default 2
		 */
		public static const JUST_PRESSED:int = 2;
		
		/**
		 *	Definierar värdet av en tangents nyligen inaktiva 
		 *	tillstånd. Detta innebär att tangenten var aktiv vid 
		 *	en föregående bildruta (frame).
		 * 
		 *	@default -1
		 */
		public static const RELEASED:int = -1;
		
		//-------------------------------------------------------
		// Public properties
		//-------------------------------------------------------
		
		/**
		 *	Tangentinstansens namn.
		 * 
		 *	@default null
		 */
		public var name:String;
		
		/**
		 *	Tangentens aktuella tillstånd.
		 * 
		 *	@default null
		 */
		public var current:int;
		
		/**
		 *	Tangentens föregående tillstånd.
		 * 
		 *	@default null
		 */
		public var last:int;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av InputKey.
		 * 
		 *	@param	name	Tangentens namn.
		 *	@param	current	Tangentens aktuella tillstånd.
		 *	@param	last	Tangentens föregående tillstånd.
		 */
		public function InputKey(name:String = UNDEFINED, current:int = 0, last:int = 0) {
			this.name	 = name;
			this.current = current;
			this.last	 = last;
		}
		
		/**
		 *	Uppdaterar tangentens tillstånd.
		 * 
		 *	@return void
		 */
		public function update():void {
			if (last == RELEASED && current == RELEASED) {
				current = INACTIVE;
			} else if (last == JUST_PRESSED && current == JUST_PRESSED) {
				current = PRESSED;
			}
			
			last = current;
		}
		
		/**
		 *	Nollställer tangentens tillstånd.
		 * 
		 *	@return void
		 */
		public function reset():void {
			last	= INACTIVE;
			current	= INACTIVE;
		}
	}
}