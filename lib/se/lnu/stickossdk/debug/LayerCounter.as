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
	 *	Debugg-verktyg för att räkna antalet registrerade lager i 
	 *	det aktuella tillståndet (DisplayState).
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-23
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class LayerCounter extends DebugText {
		
		//-------------------------------------------------------
		// Public properties
		//-------------------------------------------------------
		
		/**
		 *	Hur ofta lagerräknaren ska uppdatera sin information. 
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
		 *	@default "Layers: "
		 */
		private static const PREFIX:String = "Layers: ";
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av MusicCounter.
		 */
		public function LayerCounter() {
			width = 80; //@TODO: MAGIC
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar lagerräknarens information.
		 * 
		 *	@return void
		 */
		public function update():void {
			var layers:int = Session.application.displayState.layers.numLayers;
			text = String(PREFIX+layers);
		}
	}
}