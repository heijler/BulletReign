package se.lnu.stickossdk.system
{
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.utils.getTimer;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Time-klassen används för att konvertera 
	 *	bildruteuppdateringar till tid i millisekunder. Denna 
	 *	klass gör det därför möjligt för andra objekt att 
	 *	synkronisera sin tideräkning med Time-klassen.
	 * 
	 *	<p>Mycket av funktionaliteten i denna klass har 
	 *	deklarerats som final, detta då klassen mer eller mindre 
	 *	är fastställd.</p>
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-17
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Time {
		
		//-------------------------------------------------------
		// Public final getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Tiden det tog för systemet att gå från en bildruta 
		 *	till en annan. Tiden mäts i millisekunder.
		 */
		public final function get timeSinceLastFrame():Number {
			return _timeSinceLastFrame;
		}
		
		/**
		 *	Förfluten tid i millisekunder sedan applikationen 
		 *	först startade. Detta värde fungerar som en 
		 *	tidstämpel för systemet.
		 */
		public final function get timeOfCurrentFrame():Number {
			return _timeOfCurrentFrame;
		}
		
		/**
		 *	Tidstämpel för föregående bildruta. Egenskapen 
		 *	används för att beräkna tiden som förflutit mellan 
		 *	den aktuella och föregående bildrutan.
		 */
		public final function get timeOfPreviousFrame():Number {
			return _timeOfPreviousFrame;
		}
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Tiden det tog för systemet att gå från en bildruta 
		 *	till en annan. Tiden beräknas i millisekunder.
		 * 
		 *	@default 0
		 */
		private var _timeSinceLastFrame:Number = 0;
		
		/**
		 *	Förfluten tid i millisekunder sedan applikationen 
		 *	först startade. Detta värde fungerar som en 
		 *	tidstämpel för systemet.
		 * 
		 *	@default 0
		 */
		private var _timeOfCurrentFrame:Number = 0;
		
		/**
		 *	Tidstämpel för föregående bildruta. Egenskapen 
		 *	används för att beräkna tiden som förflutit mellan 
		 *	den aktuella och föregående bildrutan.
		 * 
		 *	@default 0
		 */
		private var _timeOfPreviousFrame:Number = 0;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av Time.
		 */
		public function Time() {
			
		}
		
		//-------------------------------------------------------
		// Public final method
		//-------------------------------------------------------
		
		/**
		 *	Sparar en ny tidstämpel och beräknar tiden mellan 
		 *	föregående och nuvarande bildruta. Beräkningen 
		 *	används för att fastställa hur mycket tid som 
		 *	förflutit mellan den nuvarande och dåvarande 
		 *	uppdateringen.
		 * 
		 *	@return void
		 */
		public final function update():void {
			_timeOfPreviousFrame = _timeOfCurrentFrame;
			_timeOfCurrentFrame  = getTimer();
			if (_timeOfPreviousFrame == 0) _timeOfPreviousFrame = _timeOfCurrentFrame;
			_timeSinceLastFrame	 = _timeOfCurrentFrame - _timeOfPreviousFrame;
		}
		
		/**
		 *	Nollställer tideräkningen.
		 * 
		 *	@return void
		 */
		public final function reset():void {
			_timeSinceLastFrame	 = 0;
			_timeOfCurrentFrame  = getTimer();
			_timeOfPreviousFrame = _timeOfCurrentFrame;
		}
	}
}