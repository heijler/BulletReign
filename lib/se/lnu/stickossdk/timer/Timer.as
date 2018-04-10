package se.lnu.stickossdk.timer
{
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.system.Session;

	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Timer-klassen erbjuder ett gränssnitt för att skapa och 
	 *	hantera timers. En timer tillåter dig att köra programkod 
	 *	på en angiven tidssekvens. Använd metoden start() för att 
	 *	aktivera en timer. Tidsenheten som används för att 
	 *	beräkna tid är millisekunder.
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-17
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Timer {
		
		//-------------------------------------------------------
		// Public getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Om Timer-objektet är aktivt eller inte.
		 */
		public function get active():Boolean {
			return _active;
		}
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Om Timer-objektet är aktivt eller inte.
		 * 
		 *	@default false
		 */
		private var _active:Boolean;
		
		/**
		 *	Antalet millisekunder som Timer-objektet har varit 
		 *	aktivt. Egenskapen används för att beräkna när 
		 *	tidsfördröjningen har utgått.
		 * 
		 *	@default 0
		 */
		private var _activeTimeElapsed:Number = 0;
		
		/**
		 *	Eventuell återuppringningsmetod. Denna metod 
		 *	aktiveras när tidsfördröjningen når noll.
		 * 
		 *	@default null
		 */
		private var _callback:Function;
		
		/**
		 *	Timer-objektets tidsfördröjning.
		 * 
		 *	@default 0
		 */
		private var _duration:Number = 0;
		
		/**
		 *	Antalet gånger som tidsfördröjningen ska 
		 *	återupprepas.
		 * 
		 *	@default 1
		 */
		private var _repeat:int = 0;
		
		/**
		 *	Beräknar hur många gånger som en tidsfördröjning har 
		 *	återupprepats. Egenskapen används för att beräkna när 
		 *	Timer-objektet har nått sin slutpunkt.
		 * 
		 *	@default 0
		 */
		private var _repeatCount:int = 0;
		
		//-------------------------------------------------------
		// Private getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Den tidpunkt då Timer-objektets nedreäkning 
		 *	påbörjades.
		 */
		private function get _timerStart():Number {
			return Session.application.time.timeOfCurrentFrame - _activeTimeElapsed;
		}
		
		/**
		 *	Den tidpunkt då Timer-objektet tidsfördröjning 
		 *	beräknas utgången.
		 * 
		 *	@return Number
		 */
		private function get _timerEnd():Number {
			return Session.application.time.timeOfCurrentFrame + (_duration - _activeTimeElapsed);
		}
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny Timer-instans.
		 * 
		 *	@param	duration	Tidsfördröjning (millisekunder).
		 *	@param	onComplete	Återuppringningsmetod.
		 *	@param	repeat		Antal repetitioner.
		 */
		public function Timer(duration:Number, onComplete:Function, repeat:int = 0) {
			_duration = duration;
			_callback = onComplete;
			_repeat	  = repeat;
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Startar timern, om den inte redan är igång.
		 * 
		 *	@return void
		 */
		public function start():void {
			_active = true;
		}
		
		/**
		 *	Stoppar timern. När en timer stoppas återställs 
		 *	tidsfördröjningen och antalet repetitioner.
		 * 
		 *	@return void
		 */
		public function stop():void {
			_active = false;
			_activeTimeElapsed = 0;
			_repeatCount = 0;
		}
		
		/**
		 *	Startar om timern.
		 * 
		 *	@return void
		 */
		public function restart():void {
			stop();
			start();
		}
		
		//-------------------------------------------------------
		// Internal methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar objektets underliggande komponenter. 
		 *	Denna metod returnerar true om timern har nått sin 
		 *	slutpunkt.
		 * 
		 *	@return Om timern har nått sin slutpunkt.
		 */
		internal function update():Boolean {
			updateElapsedTime();
			return isComplete();
		}
		
		/**
		 *	Avslutar och rensar upp Timer-objektet.
		 * 
		 *	@return void
		 */
		internal function dispose():void {
			stop();
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	Beräknar förfluten tid sedan timern startade.
		 * 
		 *	@return void
		 */
		private function updateElapsedTime():void {
			_activeTimeElapsed += Session.application.time.timeSinceLastFrame;
			if (Session.application.time.timeOfCurrentFrame > _timerEnd) {
				_repeatCount++;
				_activeTimeElapsed = 0;
				_callback();
			}
		}
		
		/**
		 *	Kontrollerar om timern har nått sin slutpunkt.
		 * 
		 *	@return Boolean
		 */
		private function isComplete():Boolean {
			return (_repeatCount >= _repeat + 1) ? true : false;
		}
	}
}