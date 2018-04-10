package se.lnu.stickossdk.timer {
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	En klass för att uppdatera och hantera underliggande 
	 *	Timer-objekt. Klassen ansvarar för att Timer-objekt som 
	 *	är föråldrade tas bort från systemet.
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-17
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Timers
	{
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Lista innehållande samtliga registrerade 
		 *	Timer-objekt. Timer-objekt som inte förekommer i 
		 *	denna lista  kommer inte att uppdateras.
		 * 
		 *	@default Vector
		 */
		private var _timers:Vector.<Timer> = new Vector.<Timer>();
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av Timers.
		 */
		public function Timers() {
			
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Lägger till en ny timer i listan över registrerade 
		 *	Timer-objekt. En timer kan inte uppdateras eller 
		 *	deallokeras om den inte läggs till.
		 * 
		 *	@param	timer		Timer som ska läggas till.
		 *	@param	autoStart	Om timern ska starta automatiskt.
		 * 
		 *	@return Den tillagda timern.
		 */
		public function add(timer:Timer, autoStart:Boolean = true):Timer {
			_timers.push(timer);
			if (autoStart) timer.start();
			return timer;
		}
		
		/**
		 *	Tar bort en registrerad timer. När en timer är 
		 *	borttagen kommer den inte längre att vara aktiv. 
		 *	Inaktiva Timer-objekt deallokeras auotmatisk.
		 * 
		 *	@param	timer	Timer att ta bort.
		 * 
		 *	@return void
		 */
		public function remove(timer:Timer):void {
			//TODO: DENNA HAR INTE TESTATS ORDENTLIGT.
			for (var i:int = 0; i < _timers.length; i++) {
				if (_timers[i] == timer) {
					_timers[i].dispose();
					_timers[i] = null;
					_timers.splice(i, 1);
				}
			}
		}
		
		/**
		 *	Skapar och lägger till en ny timer i listan över 
		 *	registrerade Timer-objekt. En timer kan inte 
		 *	uppdateras eller deallokeras om den inte läggs till. 
		 *	Metoden är menad att underlägga processen med att 
		 *	skapa en ny timer.
		 * 
		 *	@param	duration	Tidsfördröjning (millisekunder).
		 *	@param	callback	Återuppringningsmetod.
		 *	@param	repeat		Antal repetitioner.
		 *	@param	autoStart	Om timern ska starta automatiskt.
		 * 
		 *	@return Den tillagda timern.
		 */
		public function create(duration:Number, callback:Function, repeat:int = 0, autoStart:Boolean = true):Timer {
			var timer:Timer = new Timer(duration, callback, repeat);
			return add(timer, autoStart);
		}
		
		/**
		 *	Uppdaterar samtliga registrerade Timer-objekt.
		 * 
		 *	@return void
		 */
		public function update():void {
			updateTimers();
		}
		
		/**
		 *	Tar bort och deallokerar samtliga registrerade 
		 *	Timer-objekt.
		 * 
		 *	@return void
		 */
		public function dispose():void {
			disposeTimers();
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar samtliga aktiva registrerade Timer-objekt.
		 * 
		 *	@return void
		 */
		public function updateTimers():void {
			for (var i:int = 0; i < _timers.length; i++) {
				if (_timers[i].active) {
					updateTimer(i);
				}
			}
		}
		
		/**
		 *	Uppdaterar en specifik timer. Om en timer har nått 
		 *	sin slutpunkt kommer den att tas bort och 
		 *	deallokeras.
		 * 
		 *	@param	index	Index till den timer som ska uppdateras.
		 * 
		 *	@return void
		 */
		public function updateTimer(index:int):void {
			if (_timers[index].update()) {
				_timers[index].dispose();
				_timers[index] = null;
				_timers.splice(index, 1);
			}
		}
		
		/**
		 *	Tar bort och deallokerar samtliga registrerade 
		 *	Timer-objekt.
		 * 
		 *	@return void
		 */
		public function disposeTimers():void {
			for (var i:int = 0; i < _timers.length; i++) {
				_timers[i].dispose();
				_timers[i] = null;
				_timers.splice(i, 1);
			}
			
			_timers.length = 0;
		}
	}
}