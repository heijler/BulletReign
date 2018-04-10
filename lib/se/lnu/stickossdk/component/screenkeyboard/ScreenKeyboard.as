package se.lnu.stickossdk.component.screenkeyboard {
	
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import se.lnu.stickossdk.input.EvertronControls;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	ScreenKeyboard är en klass för att erbjuda ett 
	 *	skärmtangentbord. Skärmtangentbordet är menat att 
	 *	underlätta textinmatning via ett joystick-baserat 
	 *	gränssnitt.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-23
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class ScreenKeyboard extends Sprite {
		
		//-------------------------------------------------------
		// Public properties
		//-------------------------------------------------------
		
		/**
		 *	Referens till en valbar funktion som aktiveras när 
		 *	användaren är färdig med textinmatningen (aktiverar 
		 *	knappen "Done"). När funktionen aktiveras returens 
		 *	den inmatade textsträngen som en fördefinierad 
		 *	parameter. Var därför noga med att deklarera denna 
		 *	parameter i callback-funktionen.
		 * 
		 *	@default Function
		 */
		public var callback:Function;
		
		//-------------------------------------------------------
		// Public getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Skärmtangentbordets inmatade text.
		 */
		public function get text():String {
			return _display.text;
		}
		
		/**
		 *	@private
		 */
		public function set text(value:String):void {
			_display.text = value;
		}
		
		/**
		 *	Skärmtangentbordets fördefinierade standardtext.
		 */
		public function get placeholder():String {
			return _display.placeholder;
		}
		
		/**
		 *	@private
		 */
		public function set placeholder(value:String):void {
			_display.placeholder = value;
		}
		
		/**
		 *	De kontroller som tangentbordet använder.
		 */
		public function get controls():EvertronControls {
			return _keys.controls;
		}
		
		//-------------------------------------------------------
		// Internal getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Om skärmtangentbordet är aktivt eller inaktivt.
		 */
		internal function get active():Boolean {
			return _active;
		}
		
		/**
		 *	@private
		 */
		internal function set active(value:Boolean):void {
			_active = value;
			_active ? cacheAsBitmap = false : cacheAsBitmap = true;
		}
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Om skärmtangentbordet är aktivt eller inaktivt.
		 * 
		 *	@default true
		 */
		private var _active:Boolean = true;
		
		/**
		 *	Bitmap-bild som används som bakgrund för 
		 *	skärmtangentbordet.
		 * 
		 *	@default null
		 */
		private var _background:Bitmap;
		
		/**
		 *	Objekt som representerar skärmtangentbordets 
		 *	bildskärm, dvs den plats där input-texten visas.
		 * 
		 *	@default null
		 */
		private var _display:ScreenKeyboardOutput;
		
		/**
		 *	Objekt som hanterar skärmtangentbordets tangenter och 
		 *	kontroller.
		 * 
		 *	@default null
		 */
		private var _keys:ScreenKeyboardKeys;
		
		//-------------------------------------------------------
		// Private static constants
		//-------------------------------------------------------
		
		/**
		 *	Inputvärdet för "backspace".
		 * 
		 *	@default "BACKSPACE"
		 */
		private static const INPUT_BACKSPACE:String = "BACKSPACE";
		
		/**
		 *	Inputvärdet för "enter".
		 * 
		 *	@default "ENTER"
		 */
		private static const INPUT_ENTER:String = "ENTER";
		
		//-------------------------------------------------------
		// Private static embeded constants
		//-------------------------------------------------------
		
		/**
		 *	Referens till den resurs som används för 
		 *	bakgrundsgrafiken. Bilden kommer att inkluderas i 
		 *	kompileringen.
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/background.png")]
		private static const BACKGROUND:Class;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av ScreenKeyboard.
		 */
		public function ScreenKeyboard(active:Boolean = true) {
			this.active = active;
			init();
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Nollställer skärmtangentbordet.
		 * 
		 *	@return void
		 */
		public function reset():void {
			_keys.reset();
			_display.reset();
		}
		
		/**
		 *	Uppdaterar skärmtangentbordets underliggande 
		 *	komponenter.
		 * 
		 *	@return void
		 */
		public function update():void {
			if (_active) _keys.update();
			_display.update();
		}
		
		/**
		 *	Tar bort och deallokerar objekt som allokerats av 
		 *	skärmtangentbordet (ScreenKeyboard).
		 * 
		 *	@return void
		 */
		public function dispose():void {
			_active = false;
			disposeBackground();
			disposeOutput();
			disposeKeys();
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	Initierar skärmtangentbordets underliggande 
		 *	komponenter (bakgrund, output och knappar).
		 * 
		 *	@return void
		 */
		private function init():void {
			initBackground();
			initOutput();
			initKeys();
		}
		
		/**
		 *	Initierar skärmtangentbordets bakgrundsbild.
		 * 
		 *	@return void
		 */
		private function initBackground():void {
			_background = new BACKGROUND() as Bitmap;
			addChild(_background);
		}
		
		/**
		 *	Initierar skärmtangentbordets bildskärm 
		 *	(ScreenKeyboardOutput).
		 * 
		 *	@return void
		 */
		private function initOutput():void {
			_display = new ScreenKeyboardOutput();
			_display.x = 6; //@TODO: MAGIC
			_display.y = 6; //@TODO: MAGIC
			_display.update();
			addChild(_display);
		}
		
		/**
		 *	Initierar skärmtangentbordets tangenter 
		 *	(ScreenKeyboardKeys).
		 * 
		 *	@return void
		 */
		private function initKeys():void {
			_keys = new ScreenKeyboardKeys();
			_keys.callback = handleInput;
			_keys.y = 42; //@TODO: MAGIC
			_keys.update();
			addChild(_keys);
		}
		
		/**
		 *	Hanterar inmatningsvärden.
		 * 
		 *	@param	value	Inmatningsvärde.
		 * 
		 *	@return void
		 */
		private function handleInput(value:String):void {
			switch(value) {
				case INPUT_BACKSPACE:
					_display.text = _display.text.substring(0, (_display.text.length - 1));
					break;
				
				case INPUT_ENTER:
					onInputEnter();
					break;
				
				default:
					_display.text += value;
					break;
			}
		}
		
		/**
		 *	Metoden aktiveras när en användare använder 
		 *	enter-tangenten på skärmskrivbordet. Metoden 
		 *	aktiverar en callback, om det finns en registrerad.
		 * 
		 *	@return void
		 */
		private function onInputEnter():void {
			if (callback !== null) {
				callback(_display.text);
			}
		}
		
		/**
		 *	Tar bort och deallokerar den bakgrundsbild som 
		 *	använts av skärmtangentbordet.
		 * 
		 *	@return void
		 */
		private function disposeBackground():void {
			if (_background.parent) {
				_background.parent.removeChild(_background);
			}
			
			_background = null;
		}
		
		/**
		 *	Tar bort och deallokerar skärmtangentbordets 
		 *	output-skärm.
		 * 
		 *	@return void
		 */
		private function disposeOutput():void {
			if (_display.parent) _display.parent.removeChild(_display);
			_display.dispose();
			_display = null;
		}
		
		/**
		 *	Tar bort och deallokerar skärmtangentbordets 
		 *	tangenter.
		 * 
		 *	@return void
		 */
		private function disposeKeys():void {
			if (_keys != null) {
				_keys.dispose();
				_keys = null;
			}
		}
	}
}