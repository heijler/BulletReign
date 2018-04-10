package se.lnu.stickossdk.media {
	
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.utils.Dictionary;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Ett register över ljudresurser. En ljudresurs är 
	 *	vanligtvis en inbakad mp3-fil som förvaras i rådata.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	internal class SoundSources {
		
		//-------------------------------------------------------
		// Public getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Antalet tillgängliga ljudresurser.
		 */
		public function get length():int {
			return _length;
		}
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Register som används för att spara samtliga 
		 *	ljudresurser.
		 * 
		 *	@default Dictionary
		 */
		private var _soundSources:Dictionary = new Dictionary();
		
		/**
		 *	Innehåller antalet registrerade ljudresurser.
		 * 
		 *	@default 0
		 */
		private var _length:int = 0;
		
		//-------------------------------------------------------
		// Constructor methods
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av SoundSources.
		 */
		public function SoundSources() {
			
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Lägger till en ny ljudresurs i registret.
		 * 
		 *	@param	id		Resursens id.
		 *	@param	source	Referens till ljudresursen.
		 * 
		 *	@return	void
		 */
		public function add(id:String, source:Class):void {	
			if (_soundSources[id] == null) {
				_soundSources[id] = source;
				_length++;
			}
		}
		
		/**
		 *	Hämtar en ljudresurs från registret.
		 * 
		 *	@param	id		Id för den resurs som ska hämtas.
		 * 
		 *	@return	void
		 */
		public function get(id:String):Class {	
			return _soundSources[id];
		}
		
		/**
		 *	Tar bort en ljudresurs baserat på resursens id.
		 * 
		 *	@param	id	Resursens id.
		 * 
		 *	@return	void
		 */
		public function remove(id:String):void {	
			if (_soundSources[id] !== null) {
				delete _soundSources[id];
				_length--;
			}
		}
		
		//-------------------------------------------------------
		// Internal methods
		//-------------------------------------------------------
		
		/**
		 *	Intern metod som tömmer och deallokerar registret 
		 *	över ljudresurser.
		 * 
		 *	@return	void
		 */
		internal function dispose():void {	
			for (var p:* in _soundSources) {
				p = null;
			}
			
			_length = 0;
		}
	}
}