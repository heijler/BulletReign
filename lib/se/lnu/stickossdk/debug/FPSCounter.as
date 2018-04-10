package se.lnu.stickossdk.debug {
	
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.BlendMode;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import se.lnu.stickossdk.system.Session;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Klassen representerar en textbaserad FPS-mätare som vid 
	 *	bestämda tidsintervaller läser av den aktuella 
	 *	bildrutehastigheten.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-22
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class FPSCounter extends DebugText {
		
		//-------------------------------------------------------
		// Public properties
		//-------------------------------------------------------
		
		/**
		 *	Hur ofta FPS-mätaren ska läsa av den aktuella 
		 *	bildrutehastigheten. Standardvärdet är en gång per 
		 *	sekund. En låg uppdateringsintervall kan leda till 
		 *	försämrad prestanda.
		 * 
		 *	@default 1000
		 */
		public var interval:Number = 1000;
		
		//-------------------------------------------------------
		// private properties
		//-------------------------------------------------------
		
		/**
		 *	Innehåller den aktuella tidstämpeln i millisekunder.
		 * 
		 *	@default 0
		 */
		private var _currentUpdate:Number = 0;
		
		/**
		 *	Innehåller den föregående tidstämpeln i 
		 *	millisekunder.
		 * 
		 *	@default 0
		 */
		private var _previousUpdate:Number = 0;
		
		/**
		 *	Innehåller antalet bildrutor som visats sedan den 
		 *	föregående tidstämpeln. 
		 * 
		 *	@default 0
		 */
		private var _frameCount:Number = 0;
		
		//-------------------------------------------------------
		// private static constants
		//-------------------------------------------------------
		
		/**
		 *	Textfältets prefix.
		 * 
		 *	@default 0
		 */
		private static const PREFIX:String = "FPS: ";
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av FPSCounter.
		 */
		public function FPSCounter() {
			
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar objektet och beräknar antalet bildrutor 
		 *	som visats sedan den föregående tidstämpeln. 
		 *	Beräkningarna resulterar i applikationens aktuella 
		 *	FPS.
		 * 
		 *	@return void
		 */
		public function update():void {
			_frameCount++;
			_currentUpdate = Session.application.time.timeOfCurrentFrame;
			
			if (_currentUpdate >= _previousUpdate + interval) {
				text = String(PREFIX+_frameCount);
				_previousUpdate	= _currentUpdate;
				_frameCount = 0;
			}
		}
	}
}