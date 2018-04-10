package se.lnu.stickossdk.input {
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Klass för knapphantering. Klassen erbjuder ett 
	 *	standardiserat gränssitt för att hantera kontroller för 
	 *	spelare ett eller två. Klassen gör det därför möjligt att 
	 *	använda samma programkod för att hantera ett objekt utan 
	 *	att "lyssna" på olika kontroller.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class EvertronControls {
		
		//-------------------------------------------------------
		// Public static constants
		//-------------------------------------------------------
		
		/**
		 *	Spelare ett.
		 * 
		 *	@default uint
		 */
		public static const PLAYER_ONE:uint = 0;
		
		/**
		 *	Spelare två.
		 * 
		 *	@default uint
		 */
		public static const PLAYER_TWO:uint = 1;
		
		//-------------------------------------------------------
		// Public properties
		//-------------------------------------------------------
		
		/**
		 *	Indikerar vilka kontroller som ska vara i bruk. 
		 *	Använd klassens statiska egenskaper för att bestämma 
		 *	till vilken spelare som kontrollerna ska vara 
		 *	kopplade (PLAYER_ONE & PLAYER_TWO).
		 * 
		 *	@default 0
		 */
		public var player:uint = 0;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instnas av EvertronControls.
		 * 
		 *	@param	playerControls	Till viken spelare som kontrollerna ska vara kopplade.
		 */
		public function EvertronControls(playerControls:uint = 0) {
			player = playerControls;
		}
		
		//-------------------------------------------------------
		// Public getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Hämtar tangenten för upp. Resultatet är relativt till 
		 *	vilken spelare som kontrollerna är kopplade till (kan 
		 *	vara spelare ett eller två). 
		 */
		public function get PLAYER_UP():String {
			if (player == PLAYER_ONE) return EvertronInput.PLAYER_1_UP;
			else return EvertronInput.PLAYER_2_UP;
		}
		
		/**
		 *	Hämtar tangenten för höger. Resultatet är relativt till 
		 *	vilken spelare som kontrollerna är kopplade till (kan 
		 *	vara spelare ett eller två). 
		 */
		public function get PLAYER_RIGHT():String {
			if (player == PLAYER_ONE) return EvertronInput.PLAYER_1_RIGHT;
			else return EvertronInput.PLAYER_2_RIGHT;
		}
		
		/**
		 *	Hämtar tangenten för ner. Resultatet är relativt till 
		 *	vilken spelare som kontrollerna är kopplade till (kan 
		 *	vara spelare ett eller två). 
		 */
		public function get PLAYER_DOWN():String {
			if (player == PLAYER_ONE) return EvertronInput.PLAYER_1_DOWN;
			else return EvertronInput.PLAYER_2_DOWN;
		}
		
		/**
		 *	Hämtar tangenten för vänster. Resultatet är relativt 
		 *	till vilken spelare som kontrollerna är kopplade till 
		 *	(kan vara spelare ett eller två). 
		 */
		public function get PLAYER_LEFT():String {
			if (player == PLAYER_ONE) return EvertronInput.PLAYER_1_LEFT;
			else return EvertronInput.PLAYER_2_LEFT;
		}
		
		/**
		 *	Hämtar tangenten för knapp 1. Resultatet är relativt 
		 *	till vilken spelare som kontrollerna är kopplade till 
		 *	(kan vara spelare ett eller två). 
		 */
		public function get PLAYER_BUTTON_1():String {
			if (player == PLAYER_ONE) return EvertronInput.PLAYER_1_BUTTON_1;
			else return EvertronInput.PLAYER_2_BUTTON_1;
		}
		
		/**
		 *	Hämtar tangenten för knapp 2. Resultatet är relativt 
		 *	till vilken spelare som kontrollerna är kopplade till 
		 *	(kan vara spelare ett eller två). 
		 */
		public function get PLAYER_BUTTON_2():String {
			if (player == PLAYER_ONE) return EvertronInput.PLAYER_1_BUTTON_2;
			return EvertronInput.PLAYER_2_BUTTON_2;
		}
		
		/**
		 *	Hämtar tangenten för knapp 3. Resultatet är relativt 
		 *	till vilken spelare som kontrollerna är kopplade till 
		 *	(kan vara spelare ett eller två). 
		 */
		public function get PLAYER_BUTTON_3():String {
			if (player == PLAYER_ONE) return EvertronInput.PLAYER_1_BUTTON_3;
			return EvertronInput.PLAYER_2_BUTTON_3;
		}
		
		/**
		 *	Hämtar tangenten för knapp 4. Resultatet är relativt 
		 *	till vilken spelare som kontrollerna är kopplade till 
		 *	(kan vara spelare ett eller två). 
		 */
		public function get PLAYER_BUTTON_4():String {
			if (player == PLAYER_ONE) return EvertronInput.PLAYER_1_BUTTON_4;
			return EvertronInput.PLAYER_2_BUTTON_4;
		}
		
		/**
		 *	Hämtar tangenten för knapp 5. Resultatet är relativt 
		 *	till vilken spelare som kontrollerna är kopplade till 
		 *	(kan vara spelare ett eller två). 
		 */
		public function get PLAYER_BUTTON_5():String {
			if (player == PLAYER_ONE) return EvertronInput.PLAYER_1_BUTTON_5;
			return EvertronInput.PLAYER_2_BUTTON_5;
		}
		
		/**
		 *	Hämtar tangenten för knapp 6. Resultatet är relativt 
		 *	till vilken spelare som kontrollerna är kopplade till 
		 *	(kan vara spelare ett eller två). 
		 */
		public function get PLAYER_BUTTON_6():String {
			if (player == PLAYER_ONE) return EvertronInput.PLAYER_1_BUTTON_6;
			else return EvertronInput.PLAYER_2_BUTTON_6;
		}
		
		/**
		 *	Hämtar tangenten för knapp 7. Resultatet är relativt 
		 *	till vilken spelare som kontrollerna är kopplade till 
		 *	(kan vara spelare ett eller två). 
		 */
		public function get PLAYER_BUTTON_7():String {
			if (player == PLAYER_ONE) return EvertronInput.PLAYER_1_BUTTON_7;
			else return EvertronInput.PLAYER_2_BUTTON_7;
		}
		
		/**
		 *	Hämtar tangenten för knapp 8. Resultatet är relativt 
		 *	till vilken spelare som kontrollerna är kopplade till 
		 *	(kan vara spelare ett eller två). 
		 */
		public function get PLAYER_BUTTON_8():String {
			if (player == PLAYER_ONE) return EvertronInput.PLAYER_1_BUTTON_8;
			else return EvertronInput.PLAYER_2_BUTTON_8;
		}
	}
}