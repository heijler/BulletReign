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
	 *	för musik.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-22
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class MusicCounter extends DebugText {
		
		//-------------------------------------------------------
		// Public properties
		//-------------------------------------------------------
		
		/**
		 *	Hur ofta musikräknaren ska uppdatera sin information. 
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
		 *	@default "Music channel: "
		 */
		private static const PREFIX:String = "Music channel: ";
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av MusicCounter.
		 */
		public function MusicCounter() {
			width = 129; //@TODO: MAGIC
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar musikräknarens information. Metoden hämtar 
		 *	informationen från StickOS SDKs inbyggda 
		 *	ljudhanterare.
		 * 
		 *	@return void
		 */
		public function update():void {
			var soundObjects:int = Session.sound.musicChannel.numSoundObjects;
			var soundSources:int = Session.sound.musicChannel.numSoundSources;
			text = String(PREFIX+soundObjects+" : "+soundSources);
		}
	}
}