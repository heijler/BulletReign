package ui {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	import flash.text.TextField;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	import flash.text.TextFormat;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	//-----------------------------------------------------------
	// Countdown
	// Represents a countdown
	//-----------------------------------------------------------
	
	public class Countdown extends DisplayStateLayerSprite {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		public var countDownFinished:Boolean = false;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_bestOf:String = "BEST OF ";
		private var m_countArr:Vector.<String> = new <String>["GET READY", "3", "2", "1", "GO!"];
		private var m_countDownTextField:TextField;
		private var m_countDownCounter:int = 0;
		private var m_cb:Function;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Countdown() {
			super();
		}
		
		//-----------------------------------------------------------
		// Set / Get
		//-----------------------------------------------------------
		
		public function set bestOf(bestOf:int):void {
			this.m_bestOf += bestOf.toString();
			this.m_countArr.unshift(this.m_bestOf);
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		
		/**
		 * 
		 */
		public function start(callback:Function):void {
			this.m_cb = callback;
			this.m_getReady();
		}
		
		
		/**
		 * 
		 */
		public function disposeCountdown():void {
			this.m_bestOf = "";
			this.m_countArr.length = 0;
			this.m_countArr = null;
			this.m_countDownTextField = null;
			this.m_countDownCounter = 0;
			this.m_cb = null;
		}
		
		/**
		 * 
		 */
		private function m_getReady():void {
			var timer:Timer = Session.timer.create(500, this.m_countDown);
			this.m_addCountDownText();
		}
		
		
		/**
		 * 
		 */
		private function m_addCountDownText():void {
			var format:TextFormat = new TextFormat();
				format.color = 0x000000;
				format.kerning = true;
				format.size = 25;
				format.font = "bulletreign";
			
			this.m_countDownTextField = new TextField();
			this.m_countDownTextField.text = m_countArr[0];
			this.m_countDownTextField.autoSize = "center";
			this.m_countDownTextField.width = 300;
			this.m_countDownTextField.embedFonts = true;
			this.m_countDownTextField.setTextFormat(format);
			this.m_countDownTextField.defaultTextFormat = format;
			this.addChild(this.m_countDownTextField);
		}
		
		
		/**
		 * 
		 */
		private function m_countDown():void {
			var timer:Timer = Session.timer.create(700, this.m_displayCountDown, this.m_countArr.length - 1);
		}
		
		
		/**
		 * 
		 */
		private function m_displayCountDown():void {
			this.m_countDownCounter++;
			this.m_drawCountDown(this.m_countArr[this.m_countDownCounter - 1]);
			if (m_countDownCounter == this.m_countArr.length) {
				this.countDownFinished = true;
				var timer:Timer = Session.timer.create(300, this.m_cb);
			}
		}
		
		
		/**
		 * 
		 */
		private function m_drawCountDown(string:String):void {
			this.m_countDownTextField.text = string;
		}
	}
}