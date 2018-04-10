package se.lnu.stickossdk.net
{
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.util.URLUtils;

	//-----------------------------------------------------------
	// Internal class
	//-----------------------------------------------------------
	
	/**
	 *	En klass för att underlätta stränghanteringen kring 
	 *	sökvägarna till StickOS Highscore API. Klassen innehåller 
	 *	statiska metoder för att hämta sökvägar till tillgängliga 
	 *	API-metoder.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	internal class HighscoreQuery {
		
		//-------------------------------------------------------
		// Public static getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Sökvägen till StickOS Highscore APIs ingångssida.
		 * 
		 *	@default String
		 */
		public static function get DEFAULT_DATABASE_LOCATION():String {
			return Session.application.initExternalDatabaseLocation || "http://localhost/stickos";
		}
		
		//-------------------------------------------------------
		// Constructor methods
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av HighscoreQuery.
		 */
		public function HighscoreQuery() {
			throw new Error("HighscoreQuery is a static class and should not be instantiated.");
		}
		
		//-------------------------------------------------------
		// Public static methods
		//-------------------------------------------------------
		
		/**
		 *	Returnerar sökvägen till att skicka ett nytt 
		 *	poängresultat till StickOS Highscore API.
		 * 
		 *	@param	game	Spelets unika identifierare.
		 *	@param	table	Tabellen där poängsumman ska sparas.
		 *	@param	score	Poängsumman som ska sparas.
		 *	@param	name	Namn som ska associeras med poängsumman.
		 * 
		 *	@return String
		 */
		public static function getSubmitQuery(game:int, table:int, score:int, name:String):String {
			return DEFAULT_DATABASE_LOCATION+'?method_id=2&game_id='+game+'&table_id='+table+'&name='+URLUtils.encode(name)+'&score='+score;
		}
		
		/**
		 *	Returnerar sökvägen till att hämta poängresultat 
		 *	från StickOS Highscore API.
		 * 
		 *	@param	game	Spelets unika identifierare.
		 *	@param	table	Tabellen där poängsummorna ska hämtas.
		 *	@param	limit	Antalet poängresultat som ska hämtas.
		 * 
		 *	@return String
		 */
		public static function getReciveQuery(game:int, table:int, limit:int):String {
			return DEFAULT_DATABASE_LOCATION+'?method_id=1&game_id='+game+'&table_id='+table+'&limit='+limit;
		}
		
		/**
		 *	Returnerar sökvägen till att kontrollera om en 
		 *	poängsumma är ett nytt highscore.
		 * 
		 *	@param	game	Spelets unika identifierare.
		 *	@param	table	Tabellen där poängsumman ska sparas.
		 *	@param	score	Poängsumman som ska kontrolleras.
		 * 
		 *	@return String
		 */
		public static function getCheckQuery(game:int, table:int, score:int):String {
			return DEFAULT_DATABASE_LOCATION+'?method_id=3&game_id='+game+'&table_id='+table+'&score='+score;
		}
		
		/**
		 *	Returnerar sökvägen till att rensa en highscore-tabell
		 * 
		 *	@param	game	Spelets unika identifierare.
		 *	@param	table	Tabellen som skall rensas.
		 * 
		 *	@return String
		 */
		public static function getResetQuery(game:int, table:int):String {
			return DEFAULT_DATABASE_LOCATION+'?method_id=4&game_id='+game+'&table_id='+table;
		}
	}
}