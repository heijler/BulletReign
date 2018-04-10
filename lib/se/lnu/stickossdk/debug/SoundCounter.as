package se.lnu.stickossdk.debug
{
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.system.Session;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Debugg-verktyg för att räkna antalet registrerade och 
	 *	aktiva ljudobjekt i StickOS SDKs fördefinierade ljudkanal 
	 *	för effekter.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class SoundCounter extends DebugText {
		
		//-------------------------------------------------------
		// Public properties
		//-------------------------------------------------------
		
		/**
		 *	Hur ofta ljudräknaren ska uppdatera sin information. 
		 *	Standardinställningen är en uppdatering per sekund.
		 * 
		 *	@default 1000
		 */
		public var interval:Number = 1000;
		
		//-------------------------------------------------------
		// private static constants
		//-------------------------------------------------------
		
		/**
		 *	Täxtfältets prefix.
		 * 
		 *	@default "Sound channel: "
		 */
		private static const PREFIX:String = "Sound channel: ";
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	...
		 */
		public function SoundCounter() {
			width = 139; //@TODO: MAGICK NUMBER
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
		public function update():void {
			var soundObjects:int = Session.sound.soundChannel.numSoundObjects;
			var soundSources:int = Session.sound.soundChannel.numSoundSources;
			text = String(PREFIX+soundObjects+" : "+soundSources);
		}
	}
}