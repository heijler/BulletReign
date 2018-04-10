package se.lnu.stickossdk.component.screenkeyboard {
	
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	//-----------------------------------------------------------
	// Internal class
	//-----------------------------------------------------------
	
	/**
	 *	ScreenKeyboardOutput representerar den del av 
	 *	skärmtangentbordet som skriver ut den inmatade 
	 *	textsträngen. Klassen fungerar som en virtuell bildskärm 
	 *	för skärmtangentbordet. Klassen använder StickOS SDKs 
	 *	standardtypsnitt för textutmatningen.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-22
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	internal class ScreenKeyboardOutput extends Sprite {
		
		//-------------------------------------------------------
		// Public properties
		//-------------------------------------------------------
		
		/**
		 *	Standardtexten som skrivs ut när klassen initieras.
		 * 
		 *	@default "Enter name"
		 */
		public var placeholder:String = "Enter name";
		
		//-------------------------------------------------------
		// Public getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Textvärdet som klassen skriver ut.
		 */
		public function get text():String {
			return _textValue;
		}
		
		/**
		 *	@private
		 */
		public function set text(value:String):void {
			_textValue = value;
		}
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Det aktuella inmatningsvärdet.
		 * 
		 *	@default ""
		 */
		private var _textValue:String = "";
		
		/**
		 *	Textfältsobjektet som används för att rendera texten.
		 * 
		 *	@default null
		 */
		private var _textField:TextField;
		
		//-------------------------------------------------------
		// Private static constants
		//-------------------------------------------------------
		
		/**
		 *	Textens standardstorlek.
		 * 
		 *	@return 16
		 */
		private static const DEFAULT_FONT_SIZE:int = 16;
		
		/**
		 *	Textens typsnitt.
		 * 
		 *	@return "system"
		 */
		private static const DEFAULT_FONT_FACE:String = "system";
		
		/**
		 *	Färgen på den text som matats in som standardvärde.
		 * 
		 *	@return 0xFFFFFF
		 */
		private static const DEFAULT_FONT_COLOR:uint = 0xFFFFFF;
		
		/**
		 *	Färgen på den text som matats in av användaren.
		 * 
		 *	@return 0x19C5FF
		 */
		private static const DEFAULT_INPUT_FONT_COLOR:uint = 0x19C5FF;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av ScreenKeyboardOutput.
		 */
		public function ScreenKeyboardOutput() {
			init();
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar objektets utskriftstext. Om det inte finns 
		 *	någon inmatad text kommer objektets standardtext att 
		 *	visas.
		 * 
		 *	@return void
		 */
		public function update():void {
			if (_textValue.length == 0) setPlaceholderText();
			else setValueText();
		}
		
		/**
		 *	Nollställer den inmatade texten.
		 * 
		 *	@return void
		 */
		public function reset():void {
			_textValue = "";
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		public function dispose():void {
			_textField = null;
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	Initierar objektets underliggande komponenter.
		 * 
		 *	@return void
		 */
		private function init():void {
			initTextField();
		}
		
		/**
		 *	Initierar textfältsobjektet som används för att 
		 *	rendera inmatningstexten.
		 * 
		 *	@return void
		 */
		private function initTextField():void {
			_textField = new TextField();
			_textField.defaultTextFormat = new TextFormat(DEFAULT_FONT_FACE, DEFAULT_FONT_SIZE, DEFAULT_FONT_COLOR);
			_textField.embedFonts = true;
			_textField.selectable = false;
			_textField.width  = 408; //@TODO: MAGIC NUMBERS
			_textField.height = 30;  //@TODO: MAGIC NUMBERS
			_textField.text = "";
			
			addChild(_textField);
		}
		
		/**
		 *	Används för att återställa textfältet till 
		 *	standardkonfigurationen.
		 * 
		 *	@return void
		 */
		private function setPlaceholderText():void {
			_textField.text = placeholder;
			_textField.textColor = 0xFFFFFF;
		}
		
		/**
		 *	Används för att visa text som användaren matat in.
		 * 
		 *	@return void
		 */
		private function setValueText():void {
			_textField.text = _textValue;
			_textField.textColor = DEFAULT_INPUT_FONT_COLOR;
		}
	}
}