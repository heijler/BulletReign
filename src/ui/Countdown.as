package ui {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	
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
		private var m_countArr:Vector.<String> = new <String>["3", "2", "1", "GO!"];
		private var m_countDownTextField:TextField;
		private var m_countDownTextFormat:TextFormat;
		private var m_countDownCounter:int = 0;
		private var m_cb:Function;
		private var m_initTimer:Timer;
		private var m_countTimer:Timer;
		private var m_cbTimer:Timer;
		
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
		override public function dispose():void {
			trace("disposing countdown");
			this.m_bestOf = "";
			this.m_countArr.length = 0;
			this.m_countArr = null;
			this.m_countDownTextField = null;
			this.m_countDownTextFormat = null;
			this.m_countDownCounter = 0;
			this.m_cb = null;
			Session.timer.remove(this.m_initTimer);
			Session.timer.remove(this.m_countTimer);
			Session.timer.remove(this.m_cbTimer);
			this.m_initTimer = null;
			this.m_countTimer = null;
			this.m_cbTimer = null;
		}
		
		/**
		 * 
		 */
		private function m_getReady():void {
			m_initTimer = Session.timer.create(500, this.m_countDown);
			this.m_addCountDownText();
		}
		
		
		/**
		 * 
		 */
		private function m_addCountDownText():void {
			this.m_countDownTextFormat = new TextFormat();
			this.m_countDownTextFormat.color = 0x000000;
			this.m_countDownTextFormat.kerning = true;
			this.m_countDownTextFormat.size = 25;
			this.m_countDownTextFormat.font = "bulletreign";
			
			this.m_countDownTextField = new TextField();
			this.m_countDownTextField.text = m_countArr[0];
			this.m_countDownTextField.autoSize = "center";
			this.m_countDownTextField.width = 300;
			this.m_countDownTextField.embedFonts = true;
			this.m_countDownTextField.setTextFormat(this.m_countDownTextFormat);
			this.m_countDownTextField.defaultTextFormat = this.m_countDownTextFormat;
			this.addChild(this.m_countDownTextField);
		}
		
		
		/**
		 * 
		 */
		private function m_countDown():void {
			m_countTimer = Session.timer.create(700, this.m_displayCountDown, this.m_countArr.length - 1);
		}
		
		
		/**
		 * 
		 */
		private function m_displayCountDown():void {
			this.m_countDownCounter++;
			this.m_drawCountDown(this.m_countArr[this.m_countDownCounter - 1]);
			if (m_countDownCounter == this.m_countArr.length) {
				this.countDownFinished = true;
				m_cbTimer = Session.timer.create(300, this.m_cb);
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