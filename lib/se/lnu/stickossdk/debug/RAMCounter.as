package se.lnu.stickossdk.debug {
	
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.system.System;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Debugg-verktyg för att beräkna aktuell minnesförbrukning.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class RAMCounter extends DebugText {
		
		//-------------------------------------------------------
		// Public properties
		//-------------------------------------------------------
		
		/**
		 *	Intervall för hur ofta RAM-räknaren ska uppdatera sin 
		 *	information. Standardinställningen är en gång per 
		 *	sekund. Att använda ett lågt intervall kommer att 
		 *	resultera i försämrad applikationsprestanda.
		 * 
		 *	@default 1000
		 */
		public var interval:Number = 1000;
		
		//-------------------------------------------------------
		// private properties
		//-------------------------------------------------------
		
		/**
		 *	Innehåller den aktuella minnesförbrukningen.
		 * 
		 *	@default ""
		 */
		private var _currentMemory:String = "";
		
		//-------------------------------------------------------
		// private static constants
		//-------------------------------------------------------
		
		/**
		 *	Täxtfältets prefix.
		 * 
		 *	@default "RAM: "
		 */
		private static const PREFIX:String = "RAM: ";
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av RAMCounter.
		 */
		public function RAMCounter() {
			width = 92; //@TODO: MAGIC NUMBER
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar och beräknar den aktuella 
		 *	minnesförbrukningen. Informationen presenteras i 
		 *	antal Mb.
		 * 
		 *	@return void
		 */
		public function update():void {
			_currentMemory = Number(System.totalMemory / 1024 / 1024).toFixed(2);
			text = String(PREFIX+_currentMemory+" Mb");
		}
	}
}