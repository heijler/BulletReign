package se.lnu.stickossdk.component.text {
	
	//--------------------------------------------------------------------------
	// Imports
	//--------------------------------------------------------------------------
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	import se.lnu.stickossdk.tween.Tween;
	import se.lnu.stickossdk.tween.easing.Linear;
	
	//--------------------------------------------------------------------------
	// Public class
	//--------------------------------------------------------------------------
	
	/**
	 *	...
	 *
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 *	@copyright	Copyright (c) 2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@version	1.0
	 *	@sincStateGame13-11-22
	 */
	public class ScrollingTextField extends Sprite {
		
		//----------------------------------------------------------------------
		//  Private properties
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_bounds:Rectangle;
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_duration:int = 6000;
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_delay:int = 500;
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_textFormat:TextFormat;
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_textField:TextField;
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_mask:Sprite;
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_tween:Tween;
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_timer:Timer;
		
		//----------------------------------------------------------------------
		//  Override Public getter and setter method
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 */
		override public function get width():Number {
			return m_bounds.width;
		}
		
		/**
		 *	...
		 */
		override public function set width(value:Number):void {
			m_bounds.width = value;
		}
		
		/**
		 *	...
		 */
		override public function get height():Number {
			return m_bounds.height;
		}
		
		/**
		 *	...
		 */
		override public function set height(value:Number):void {
			m_bounds.height = value;
		}
		
		//----------------------------------------------------------------------
		//  Public getter and setter method
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 */
		public function get duration():int {
			return m_duration;
		}
		
		/**
		 *	...
		 */
		public function set duration(value:int):void {
			m_duration = value;
			m_initScroll();
		}
		
		/**
		 *	...
		 */
		public function get delay():int {
			return m_delay;
		}
		
		/**
		 *	...
		 */
		public function set delay(value:int):void {
			m_delay = value;
			m_initScroll();
		}
		
		/**
		 *	...
		 */
		public function get text():String {
			return m_textField.text;
		}
		
		/**
		 *	...
		 */
		public function set text(value:String):void {
			m_textField.text = value;
			m_initScroll();
		}
		
		/**
		 *	...
		 */
		public function get textFormat():TextFormat {
			return m_textFormat;
		}
		
		/**
		 *	...
		 */
		public function set textFormat(value:TextFormat):void {
			m_textFormat = value;
			m_textField.setTextFormat(m_textFormat);
			m_textField.defaultTextFormat = m_textFormat;
			m_textField.x = 0;
			m_textField.y = 0;
		}
		
		/**
		 *	...
		 */
		public function get embeddedFonts():Boolean {
			return m_textField.embedFonts;
		}
		
		/**
		 *	...
		 */
		public function set embeddedFonts(value:Boolean):void {
			m_textField.embedFonts = value;
		}
		
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		public function ScrollingTextField(bounds:Rectangle) {
			m_initMask(bounds);
			m_initTextFormat();
			m_initTextField();
			m_initScroll();
		}
		
		//----------------------------------------------------------------------
		// Public methods
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		public function dispose():void {
			m_disposeTween();
			m_disposeTextField();
			m_disposeTextFormat();
			m_disposeMask();
		}
		
		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_initMask(bounds:Rectangle):void {
			m_mask = new Sprite();
			m_mask.graphics.beginFill(0x00FF00);
			m_mask.graphics.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
			m_mask.graphics.endFill();
			m_bounds = bounds;
			
			addChild(m_mask);
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_initTextFormat():void {
			m_textFormat = new TextFormat();
			m_textFormat.font = "Arial";
			m_textFormat.color = 0xFFFFFF;
			m_textFormat.size = 18;
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_initTextField():void {
			m_textField = new TextField();
			m_textField.autoSize = TextFieldAutoSize.LEFT;
			m_textField.setTextFormat(m_textFormat);
			m_textField.defaultTextFormat = m_textFormat;
			m_textField.mask = m_mask;
			m_textField.antiAliasType = AntiAliasType.ADVANCED;
			//m_textField.border = true;
			//m_textField.borderColor = 0xFFFFFF;
			
			addChild(m_textField);
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_initScroll():void {
			if (m_textField.textWidth > m_bounds.width) {
				m_textField.x = width;
				m_timer = Session.timer.create(m_delay, m_initTween);
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_initTween():void {
			m_disposeTween();
			m_textField.x = width;
			m_tween = Session.core.tweener.add(m_textField, {
				x: -m_textField.width,
				duration: m_duration,
				transition: Linear.easeNone,
				onComplete: m_initTween
			});
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_disposeTween():void {
			if (m_tween != null) {
				Session.core.tweener.remove(m_tween);
				m_tween.dispose();
				m_tween = null;
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_disposeTextField():void {
			if (m_textField != null && m_textField.parent != null) {
				m_textField.parent.removeChild(m_textField);
				m_textField = null;
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_disposeTextFormat():void {
			if (m_textFormat != null) {
				m_textFormat  = null;
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_disposeMask():void {
			if (m_mask != null && m_mask.parent != null) {
				m_mask.parent.removeChild(m_mask);
				m_mask.graphics.clear();
				m_mask = null;
			}
		}
	}
}