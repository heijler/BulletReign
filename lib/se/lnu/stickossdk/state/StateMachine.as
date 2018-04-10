package se.lnu.stickossdk.state
{
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	StateMachine används för att hantera hantera tillstånd 
	 *	(State). Ett tillstånd är en samling programkod som 
	 *	upprepas och utförs vid bestämda tillfällen. Via 
	 *	StateMachine är det möjligt att byta från ett tillstånd 
	 *	till ett annat. 
	 *
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 *	@copyright	Copyright (c) 2012.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@version	1.0
	 *	@since		2012-10-12
	 */
	public class StateMachine {
		
		//-------------------------------------------------------
		// Public properties
		//-------------------------------------------------------
		
		/**
		 *	Referens till nästa planerade tillstånd. Denna 
		 *	egenskap på man redan i förväg vill förbereda ett 
		 *	tillstånd.
		 *	
		 * 	@default null
		 */
		public var nextState:State
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Innehåller en referens till det aktuella tillståndet.
		 *	
		 * 	@default null
		 */
		private var _currentState:State;
		
		//-------------------------------------------------------
		// Public getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Det aktuella tillståndet.
		 */
		public function get currentState():State {
			return _currentState;
		}
		
		/**
		 *	@private
		 */
		public function set currentState(value:State):void {
			changeState(value);
		}
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av StateMachine.
		 */
		public function StateMachine() {	
			
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar det aktuella tillståndet.
		 * 
		 *	@return void
		 */
		public function update():void {
			if (_currentState) {
				_currentState.onUpdate();
			}
		}
		
		/**
		 *	Aktiverar det kommande tillståndet. Denna metod 
		 *	förutsätter att det finns ett tillstånd sparat i 
		 *	nextState-egenskapen.
		 * 
		 *	@return void
		 */
		public function goToNextState():void {
			if (nextState) {
				changeState(nextState);
			}
		}
		
		/**
		 *	Tar bort och deallokerar StateMachine.
		 * 
		 *	@return void
		 */
		public function dispose():void {
			disposeCurrentState();
			nextState = null;
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	Byter till ett nytt tillstånd.
		 * 
		 *	@return void
		 */
		private function changeState(state:State):void {
			disposeCurrentState();
			_currentState = state;
			_currentState.onInit();
		}
		
		/**
		 *	Tar bort och deallokerar det aktuella tillståndet.
		 * 
		 *	@return void
		 */
		private function disposeCurrentState():void {
			if (_currentState) {
				_currentState.onDispose();
				_currentState = null;
			}
		}
	}
}