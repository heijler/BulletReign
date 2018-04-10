package se.lnu.stickossdk.component.screenkeyboard
{
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	//-----------------------------------------------------------
	// Internal class
	//-----------------------------------------------------------
	
	/**
	 *	This class represents a screen keyboard key. A key 
	 *	contains a value and a graphical representation.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-13
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 * 
	 * 	@todo
	 * 		- Ability to customize which parts of the texture to retrieve.
	 * 		- Can the constructor be cleaned up?  It looks like trash..
	 */
	internal class ScreenKeyboardKey extends Bitmap {
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	If the key is active (true) or inactive (false).
		 * 
		 *	@default false
		 */
		private var _active:Boolean = false;
		
		/**
		 *	The value that the key represents, the value is 
		 *	handled as a string.
		 * 
		 *	@default ""
		 */
		private var _value:String = "";
		
		/**
		 *	Reference to a bitmap texture used for the key. A 
		 *	texture contains graphics for the button's different 
		 *	states; normal and selected.
		 * 
		 *	@default null
		 */
		private var _texture:Bitmap;
		
		/**
		 *	Rectangle objects for internal calculations.
		 * 
		 *	@default Rectangle
		 */
		private var _rectangle:Rectangle = new Rectangle();
		
		/**
		 *	Point objects for internal calculations.
		 * 
		 *	@default Point
		 */
		private var _point:Point = new Point();
		
		//-------------------------------------------------------
		// Public getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	If the key is active (true) or inactive (false).
		 */
		public function get active():Boolean {
			return _active;
		}
		
		/**
		 *	@private
		 */
		public function set active(value:Boolean):void {
			_active = value;
			render();
		}
		
		/**
		 *	Contains the string value of the key.
		 */
		public function get value():String {
			return _value;
		}
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Creates a new ScreenKeyboardKey instance.
		 */
		public function ScreenKeyboardKey(value:String, source:Class) {
			_value = value;
			_texture = new source() as Bitmap;
			_rectangle = new Rectangle(0, 0, _texture.width >> 1, _texture.height);
			super(new BitmapData(_rectangle.width, _rectangle.height));
			render();
		}
		
		//-------------------------------------------------------
		// Private method
		//-------------------------------------------------------
		
		/**
		 *	Calculates which portion of the texture to be used 
		 *	for the key's current state. This method will update 
		 *	the object's current map data.
		 * 
		 *	@return void
		 */
		private function render():void {
			if (_active) _rectangle.x = _texture.width >> 1;
			else  _rectangle.x = 0;
			
			bitmapData.copyPixels(_texture.bitmapData, _rectangle, _point);
		}
	}
}