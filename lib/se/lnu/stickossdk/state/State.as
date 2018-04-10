package se.lnu.stickossdk.state {
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	En tillståndsklass (State) som kan användas av en 
	 *	StateMachine. Syftet med denna klass är att innehålla 
	 *	programkod som är specifik för ett objekts tillstånd, 
	 *	exempelvis vilken programkod som ska köras då en spelare 
	 *	är aktiv eller inaktiv.
	 * 
	 *	Precis som DisplayState består ett State av metoderna 
	 *	init(), update() och dispose().
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-22
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class State {
		
		//-------------------------------------------------------
		// Public properties
		//-------------------------------------------------------
		
		/**
		 *	Länkar init-förfrågan till en tillgänglig metod. Som 
		 *	standard aktiveras metoden init som finns tillgänglig 
		 *	i detta tillstånd (State).
		 *	
		 * 	@default init()
		 */
		public var onInit:Function = init;
		
		/**
		 *	Länkar update-förfrågan till en tillgänglig metod. 
		 *	Som standard aktiveras metoden init som finns 
		 *	tillgänglig i detta tillstånd (State).
		 *	
		 * 	@default update()
		 */
		public var onUpdate:Function = update;
		
		/**
		 *	Länkar dispose-förfrågan till en tillgänglig metod. 
		 *	Som standard aktiveras metoden init som finns 
		 *	tillgänglig i detta tillstånd (State).
		 *	
		 * 	@default dispose()
		 */
		public var onDispose:Function = dispose;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av State.
		 */
		public function State() {	
			
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Fördefinierad metod som är menad att överskrivas av 
		 *	en super-klass. Metoden aktiveras när tillståndet 
		 *	initieras av en StateMachine.
		 * 
		 *	@return void
		 */
		public function init():void {
			//ÖVERSKRIV FRÅN SUPER
		}
		
		/**
		 *	Fördefinierad metod som är menad att överskrivas av 
		 *	en super-klass. Metoden aktiveras när tillståndet 
		 *	uppdateras av en StateMachine.
		 * 
		 *	@return void
		 */
		public function update():void {
			//ÖVERSKRIV FRÅN SUPER
		}
		
		/**
		 *	Fördefinierad metod som är menad att överskrivas av 
		 *	en super-klass. Metoden aktiveras när tillståndet 
		 *	deallokeras av en StateMachine.
		 * 
		 *	@return void
		 */
		public function dispose():void {
			//ÖVERSKRIV FRÅN SUPER
		}
	}
}