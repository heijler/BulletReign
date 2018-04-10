package se.lnu.stickossdk.system {
	
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.net.SharedObject;

	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Används för att spara tillstånds- eller sessionsbaserad 
	 *	data. Klassen kan inte spara information till hårddisken 
	 *	utan erbjuder enbart en minnesbank som är aktiv så länge 
	 *	som spelet körs i StickOS eller Adobe Flash Player.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	internal class Data {
		
		//-------------------------------------------------------
		// Public getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Objekt som används för att lagra "global" 
		 *	information. Denna information är menad att finnas 
		 *	tillgänglig så länge som applikationen befinner sig i 
		 *	körning.
		 */
		public function get global():Object {
			return _global;
		}
		
		/**
		 *	Objekt som används för att lagra "lokal" information. 
		 *	Denna information kommer att rensas då StickOS SDK 
		 *	byter DisplayState.
		 */
		public function get local():Object {
			return _local;
		}
		
		/**
		 *	...
		 */
		public function get permanent():Object {
			return _permanent.data;
		}
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Objekt som används för att lagra "global" 
		 *	information. Denna information är menad att finnas 
		 *	tillgänglig så länge som applikationen befinner sig i 
		 *	körning.
		 * 
		 *	@default Object
		 */
		private var _global:Object = new Object();
		
		/**
		 *	Objekt som används för att lagra "lokal" information. 
		 *	Denna information kommer att rensas då StickOS SDK 
		 *	byter DisplayState.
		 * 
		 *	@default Object
		 */
		private var _local:Object = new Object();
		
		/**
		 *	...
		 * 
		 *	@default Object
		 */
		private var _permanent:Object = SharedObject.getLocal(String(Session.application.id));
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av Data.
		 */
		public function Data() {
			
		}
		
		//-------------------------------------------------------
		// Internal methods
		//-------------------------------------------------------
		
		/**
		 *	Deallokerar minne som allokerats av klassen. När 
		 *	denna metod aktiveras kommer all information som 
		 *	sparats i objektet att rensas.
		 * 
		 *	@return void
		 */
		internal function dispose():void {
			_global = new Object();
			reset();
		}
		
		/**
		 *	Denna metod rensar den "lokala" sessionsinformationen. 
		 *	Den information som sparats i global kommer 
		 *	fortfarande att vara tillgänglig.
		 * 
		 *	@return void
		 */
		internal function reset():void {
			_local = new Object();
		}
	}
}