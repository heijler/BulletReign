package se.lnu.stickossdk.debug
{
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Basobjekt för alla text-baserade debugg-verktyg.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-22
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class DebugText extends TextField
	{
		//-------------------------------------------------------
		// private properties
		//-------------------------------------------------------
		
		/**
		 *	Referens till textformatet som debugg-texten 
		 *	använder.
		 * 
		 *	@default TextFormat
		 */
		private var _textFormat:TextFormat;
		
		//-------------------------------------------------------
		// private properties
		//-------------------------------------------------------
		
		/**
		 *	Standardfärgen som används på textfältet.
		 * 
		 *	@default 0xFFFFFF
		 */
		private static const DEFAULT_TEXT_COLOR:uint = 0xFFFFFF;
		
		/**
		 *	Standardmarginal som används på textfältet.
		 * 
		 *	@default 10
		 */
		private static const DEFAULT_TEXT_MARGIN:int = 10;
		
		/**
		 *	Typsnittet som används som standard.
		 * 
		 *	@default "system"
		 */
		private static const DEFAULT_TEXT_FONT:String = "system";
		
		/**
		 *	Standardstorleken.
		 * 
		 *	@default 8
		 */
		private static const DEFAULT_TEXT_SIZE:int = 8;
		
		/**
		 *	Standardbakgrundsfärgen för textfältet.
		 * 
		 *	@default 0x333333
		 */
		private static const DEFAULT_BACKGROUND_COLOR:uint = 0x333333;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av DebugText.
		 */
		public function DebugText() {
			init();
		}
		
		//-------------------------------------------------------
		// Internal methods
		//-------------------------------------------------------
		
		/**
		 *	Initierar objektets underliggande komponenter.
		 * 
		 *	@return void
		 */
		internal function init():void {
			initTextFormat();
			initTextField();
		}
		
		/**
		 *	Deallokerar objektets underliggande komponenter.
		 * 
		 *	@return void
		 */
		internal function dispose():void {
			_textFormat = null;
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	Initierar och konfigurerar textens format. 
		 * 
		 *	@return void
		 */
		private function initTextFormat():void {
			_textFormat = new TextFormat();
			_textFormat.leftMargin  = DEFAULT_TEXT_MARGIN;
			_textFormat.rightMargin = DEFAULT_TEXT_MARGIN;
			_textFormat.color = DEFAULT_TEXT_COLOR;
			_textFormat.font  = DEFAULT_TEXT_FONT;
			_textFormat.size  = DEFAULT_TEXT_SIZE;
			defaultTextFormat = _textFormat;
		}
		
		/**
		 *	Initierar och konfigurerar textfältets inställningar.
		 * 
		 *	@return void
		 */
		private function initTextField():void {
			backgroundColor = DEFAULT_BACKGROUND_COLOR;
			background = true;
			embedFonts = true;
			selectable = false;
			width  = 62; //@TODO: MAGIC NUMBER
			height = 16; //@TODO: MAGIC NUMBER
		}
	}
}