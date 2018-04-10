package se.lnu.stickossdk.debug {
	
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.system.Engine;
	import se.lnu.stickossdk.system.Session;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	...
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-24
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Version extends DebugText {
		
		//-------------------------------------------------------
		// private static constants
		//-------------------------------------------------------
		
		/**
		 *	Täxtfältets prefix.
		 * 
		 *	@default "Sound channel: "
		 */
		private static const PREFIX:String = "StickOS SDK: ";
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	...
		 */
		public function Version() {
			width = 110; //TODO: MAGICK NUMBER
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar ljudräknarens information. Metoden hämtar 
		 *	informationen från StickOS SDKs inbyggda 
		 *	ljudhanterare.
		 * 
		 *	@return void
		 */
		override internal function init():void {
			super.init();
			text = PREFIX+Engine.VERSION;
		}
	}
}