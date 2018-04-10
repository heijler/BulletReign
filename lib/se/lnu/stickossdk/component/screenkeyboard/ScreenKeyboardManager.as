package se.lnu.stickossdk.component.screenkeyboard {
	
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.DisplayObjectContainer;
	
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.tween.easing.Quad;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Denna klass används för att hantera ett skärmtangentbord 
	 *	(ScreenKeyboard).
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-24
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class ScreenKeyboardManager {
		
		//-------------------------------------------------------
		// Public static constants
		//-------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@default 0
		 */
		public static const TRANSITION_FADE:int = 0; 
		
		/**
		 *	...
		 * 
		 *	@default 0
		 */
		public static const TRANSITION_SLIDE:int = 1;
		
		//-------------------------------------------------------
		// Public properties
		//-------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@default TRANSITION_FADE
		 */
		public var transition:int = TRANSITION_FADE;
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@default Bitmap
		 */
		private var _active:Boolean;
		
		/**
		 *	...
		 * 
		 *	@default Bitmap
		 */
		private var _inMotion:Boolean;
		
		/**
		 *	...
		 * 
		 *	@default Function
		 */
		private var _callback:Function;
		
		/**
		 *	...
		 * 
		 *	@default Bitmap
		 */
		private var _parent:DisplayObjectContainer;
		
		/**
		 *	...
		 * 
		 *	@default Bitmap
		 */
		private var _keyboard:ScreenKeyboard = new ScreenKeyboard(false);
		
		/**
		 *	...
		 * 
		 *	@default ""
		 */
		private var _value:String = "";
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Creates a new instance of screen keyboard manager.
		 */
		public function ScreenKeyboardManager(parent:DisplayObjectContainer) {
			_parent = parent;
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Enables an on-screen keyboard. This method can only 
		 *	be used when there is no active instance of the 
		 *	on-screen keyboard. Call deactivate to disable an 
		 *	active keyboard.
		 * 
		 *	@param	callback	...
		 *	@param	defaultText	...
		 * 
		 *	@param	void
		 */
		public function activate(callback:Function, player:uint, defaultText:String = "Enter Name"):void {
			if (_active == false && _inMotion == false) {
				_active = true;
				activateKeyboard(callback, player, defaultText);
			}
		}
		
		/**
		 *	...
		 * 
		 *	@param	void
		 */
		public function deactivate():void {
			if (_active == true && _inMotion == false) {
				_active = false;
				deactivateKeyboard();
			}
		}
		
		/**
		 *	...
		 * 
		 *	@param	void
		 */
		public function update():void {
			if (_keyboard == null) return;
			_keyboard.update();
		}
		
		/**
		 *	...
		 * 
		 *	@param	void
		 */
		public function reset():void {
			if (_keyboard.parent) _keyboard.parent.removeChild(_keyboard);
			_active = false;
			_keyboard.active = false;
			_inMotion = false;
		}
		
		/**
		 *	...
		 * 
		 *	@param	void
		 */
		public function dispose():void {
			if (_keyboard == null) return;
			if (_keyboard.parent != null) {
				_keyboard.parent.removeChild(_keyboard);
			}
			
			_keyboard.dispose();
			_keyboard = null;
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@param	void
		 */
		private function activateKeyboard(callback:Function, player:uint, defaultText:String):void {
			if (_keyboard == null) return;
			_callback = callback;
			//_keyboard.callback = onCallback;
			_keyboard.callback = onInput;
			_keyboard.placeholder = defaultText;
			_keyboard.controls.player = player;
			
			if (transition == TRANSITION_FADE) fadeIn();
			else slideIn();
		}
		
		/**
		 *	...
		 * 
		 *	@param	void
		 */
		private function deactivateKeyboard():void {
			if (transition == TRANSITION_FADE) fadeOut();
			else slideOut();
		}
		
		/**
		 *	...
		 * 
		 *	@param	void
		 */
		private function onInput(value:String):void {
			_value = value;
			deactivate();
		}
		
		/**
		 *	...
		 * 
		 *	@param	void
		 */
		private function onCallback(value:String):void {
			if (_callback is Function) {
				_callback(value);
			}
			
			//deactivate();
		}
		
		/**
		 *	...
		 * 
		 *	@param	void
		 */
		private function slideIn(duration:Number = 500):void {
			_keyboard.x = (Session.application.size.x >> 1) - (_keyboard.width  >> 1);
			_keyboard.y = Session.application.size.y;
			Session.tweener.add(_keyboard, {
				duration: duration,
				transition: Quad.easeOut,
				onInit: onTransitionInit,
				onComplete: onTransitionInComplete,
				y: (Session.application.size.y >> 1) - (_keyboard.height >> 1)
			});
		}
		
		/**
		 *	...
		 * 
		 *	@param	void
		 */
		private function slideOut(duration:Number = 500):void {
			_keyboard.x = (Session.application.size.x >> 1) - (_keyboard.width  >> 1);
			_keyboard.y = (Session.application.size.y >> 1) - (_keyboard.height >> 1);
			Session.tweener.add(_keyboard, {
				duration: duration,
				transition: Quad.easeIn,
				onInit: onTransitionInit,
				onComplete: onTransitionOutComplete,
				y: _keyboard.height * -1
			});
		}
		
		/**
		 *	...
		 * 
		 *	@param	void
		 */
		private function fadeIn(duration:Number = 500):void {
			_keyboard.x = ((Session.application.size.x >> 1) - (_keyboard.width  >> 1));
			_keyboard.y = ((Session.application.size.y >> 1) - (_keyboard.height >> 1));
			_keyboard.alpha = 0;
			
			Session.tweener.add(_keyboard, {
				duration: duration,
				transition: Quad.easeOut,
				onInit: onTransitionInit,
				onComplete: onTransitionInComplete,
				alpha: 1
			});
		}
		
		/**
		 *	...
		 * 
		 *	@param	void
		 */
		private function fadeOut(duration:Number = 500):void {
			_keyboard.x = ((Session.application.size.x >> 1) - (_keyboard.width  >> 1));
			_keyboard.y = ((Session.application.size.y >> 1) - (_keyboard.height >> 1));
			_keyboard.alpha = 1;
			
			Session.tweener.add(_keyboard, {
				duration: duration,
				transition: Quad.easeOut,
				onInit: onTransitionInit,
				onComplete: onTransitionOutComplete,
				alpha: 0
			});
		}
		
		/**
		 *	...
		 * 
		 *	@param void
		 */
		private function onTransitionInit():void {
			if (_keyboard.parent == null) _parent.addChild(_keyboard);
			_keyboard.active = false;
			_inMotion = true;
		}
		
		/**
		 *	...
		 * 
		 *	@param	void
		 */
		private function onTransitionInComplete():void {
			if (_keyboard == null) return;
			_keyboard.active = true;
			_inMotion = false;
		}
		
		/**
		 *	...
		 * 
		 *	@param	void
		 */
		private function onTransitionOutComplete():void {
			_parent.removeChild(_keyboard);
			_keyboard.reset();
			_inMotion = false;
			_active = false;
			
			onCallback(_value); //DENNA ÄR NY
		}
	}
}