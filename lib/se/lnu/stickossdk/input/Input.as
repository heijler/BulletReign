package se.lnu.stickossdk.input {
	
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.InteractiveObject;
	import flash.events.KeyboardEvent;

	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	StickOS SDKs statiska input-hanterare. Denna klass 
	 *	innehåller referenser till de input-enheter som Evertron 
	 *	erbjuder (tangentbord).
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-22
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Input {
		
		//-------------------------------------------------------
		// Public static getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Referens till tangentbordshanteraren.
		 */
		static public function get keyboard():Keyboard {
			return _keyboard;
		}
		
		/**
		 *	Om tangentbordet ska vara aktiverat eller inte.
		 */
		static public function get enableKeyboard():Boolean {
			return _keyboardEnabled;
		}
		
		/**
		 *	@private
		 */
		static public function set enableKeyboard(value:Boolean):void {
			_keyboardEnabled = value;
			_keyboardEnabled == true ? initKeyboardEvent() : disposeKeyboardEvent(); 
		}
		
		//-------------------------------------------------------
		// Private static properties
		//-------------------------------------------------------
		
		/**
		 *	Referens till tangentbordshanteraren.
		 * 
		 *	@default Keyboard
		 */
		static private var _keyboard:Keyboard = new Keyboard();
		
		/**
		 *	Om tangentbordet är aktivt eller inte.
		 * 
		 *	@default false
		 */
		static private var _keyboardEnabled:Boolean;
		
		/**
		 *	Interaktivt objekt som hanterar händelsehanteringen.
		 * 
		 *	@default null
		 */
		private static var _source:InteractiveObject;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av Input. Då denna klass är 
		 *	statisk ska den inte instansieras.
		 */
		public function Input() {
			throw new Error("Input is a static class and should not be instantiated.");
		}
		
		//-------------------------------------------------------
		// Public static functions
		//-------------------------------------------------------
		
		/**
		 *	Initierar input-hanteraren.
		 * 
		 *	@param	source	Objektet som hanterar händelselyssnarna.
		 * 
		 *	@return void
		 */
		public static function init(source:InteractiveObject):void {
			_source = source;
		}
		
		/**
		 *	Uppdaterar input-hanteraren och ser till att alla 
		 *	input-enheter är uppdaterade.
		 * 
		 *	@return void
		 */
		public static function update():void {
			_keyboard.update();
		}
		
		/**
		 *	Nollställer input-hanteraren. Alla aktiva knappar 
		 *	kommer att sättas till inaktiva.
		 * 
		 *	@return void
		 */
		public static function reset():void {
			_keyboard.reset();
		}
		
		/**
		 *	Deallokerar input-hanterarens underliggande 
		 *	komponenter.
		 * 
		 *	@return void
		 */
		public static function dispose():void {
			disposeKeyboardEvent();
			_keyboard.dispose();
			_source = null;
		}
		
		//-------------------------------------------------------
		// Private static functions
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar tangentbordshanteraren.
		 * 
		 *	@return void
		 */
		private static function updateKeyboard():void {
			_keyboard.update();
		}
		
		/**
		 *	Aktiverar händelselyssnare för att hantera 
		 *	tangentbordsinmatningar.
		 * 
		 *	@return void
		 */
		static private function initKeyboardEvent():void {
			_source.addEventListener(KeyboardEvent.KEY_DOWN, _keyboard.handleButtonDown);
			_source.addEventListener(KeyboardEvent.KEY_UP, 	 _keyboard.handleButtonUp);
		}
		
		/**
		 *	Avaktiverar händelselyssnare för att hantera 
		 *	tangentbordsinmatningar.
		 * 
		 *	@return void
		 */
		static private function disposeKeyboardEvent():void {
			_source.removeEventListener(KeyboardEvent.KEY_DOWN, _keyboard.handleButtonDown);
			_source.removeEventListener(KeyboardEvent.KEY_UP, 	_keyboard.handleButtonUp);
		}
	}
}