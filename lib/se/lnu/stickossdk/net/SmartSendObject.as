package se.lnu.stickossdk.net
{
	//-----------------------------------------------------------
	// Internal class
	//-----------------------------------------------------------
	
	/**
	 *	En hjälp-klass för att skicka "smarta inskickningar" 
	 *	till databasen via StickOS Highscore API. Klassen är 
	 *	intern och används enbart av Highscore-klassen.
	 *
	 *	@version	1.1
	 *	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-14
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	internal class SmartSendObject {
		
		//-------------------------------------------------------
		// Public getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	@private
		 */
		public function get game():int {
			return _game;
		}
		
		/**
		 *	@private
		 */
		public function get table():int {
			return _table;
		}
		
		/**
		 *	@private
		 */
		public function get score():int {
			return _score;
		}
		
		/**
		 *	@private
		 */
		public function get range():int {
			return _range;
		}
		
		/**
		 *	@private
		 */
		public function get callback():Function {
			return _callback;
		}
		
		/**
		 *	@private
		 */
		public function get player():uint {
			return _player;
		}
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Id-nummer till det spel som behandlas under 
		 *	inskickningen.
		 * 
		 *	@default 0
		 */
		private var _game:int;
		
		/**
		 *	Id-nummret till den tabell som behandlas under 
		 *	inskickningen.
		 * 
		 *	@default 0
		 */
		private var _table:int;
		
		/**
		 *	Poängsumman som behandlas under inskickningen.
		 * 
		 *	@default 0
		 */
		private var _score:int;
		
		/**
		 *	Intervall för hur många poängresultat som innefattas 
		 *	av highscore-listan.
		 * 
		 *	@default 0
		 */
		private var _range:int;
		
		/**
		 *	Referens till den metod som ska aktiveras när 
		 *	inskickningen är klar.
		 * 
		 *	@default null
		 */
		private var _callback:Function
		
		/**
		 *	Vilken spelare som styr namninmatningen.
		 * 
		 *	@default 0
		 */
		private var _player:uint;
		
		//-------------------------------------------------------
		// Constructor methods
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av objektet.
		 */
		public function SmartSendObject(game:int, table:int, score:int, range:int, callback:Function, player:uint) {
			_game = game;
			_table = table;
			_score = score;
			_range = range;
			_callback = callback;
			_player = player;
		}
	}
}