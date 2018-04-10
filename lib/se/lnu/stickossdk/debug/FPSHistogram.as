package se.lnu.stickossdk.debug {
	
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import se.lnu.stickossdk.system.Session;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	...
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-22
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class FPSHistogram extends Bitmap {
		
		//TODO: FIX ME
		
		//-------------------------------------------------------
		// Public properties
		//-------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@default 1000
		 */
		public var interval:Number = 1000;
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@default 0
		 */
		private var _frameCount:Number = 0;
		
		/**
		 *	...
		 * 
		 *	@default 0
		 */
		private var _currentUpdate:Number = 0;
		
		/**
		 *	...
		 * 
		 *	@default 0
		 */
		private var _previousUpdate:Number = 0;
		
		/**
		 *	...
		 * 
		 *	@default Vector
		 */
		private var _rectList:Vector.<Rectangle> = new Vector.<Rectangle>();
		
		/**
		 *	...
		 * 
		 *	@default Vector
		 */
		private var _frameHistory:Vector.<Object> = new Vector.<Object>();
		
		/**
		 *	...
		 * 
		 *	@default 0
		 */
		private var _numOfBars:int = 0;
		
		//-------------------------------------------------------
		// Private constant properties
		//-------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@default 1
		 */
		private const BAR_WIDTH:int = 1;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	...
		 */
		public function FPSHistogram() {
			super(new BitmapData(100, 16, false, 0x333333));
		}
		
		//-------------------------------------------------------
		//	Public methods
		//-------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		internal function dispose():void {
			//TODO: DENNA KAN FÖRBÄTTRAS
			_rectList.length = 0;
			_frameHistory.length = 0;
		}
		
		//-------------------------------------------------------
		//	Public methods
		//-------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		public function update():void {
			
			if (_numOfBars != width / BAR_WIDTH) {
				initRectangles();
			}
			
			_frameCount++;
			_currentUpdate = Session.application.time.timeOfCurrentFrame;
			
			if (_currentUpdate >= _previousUpdate + interval) {
				updateHistory();
				_previousUpdate	= _currentUpdate;
				_frameCount = 0;
			}
			
			render();
		}
		
		/**
		 *	TODO: hämta frameRate från engine, inte stage.
		 * 
		 */
		public function render():void 
		{
			bitmapData.fillRect(bitmapData.rect, 0x333333);
			
			for (var i:int = 0; i < _frameHistory.length; i++) {
				_rectList[i].height = _frameHistory[i].height;
				_rectList[i].y = 16 - _rectList[i].height;
				_rectList[i].x = i * _rectList[i].width;
				
				bitmapData.fillRect(_rectList[i], _frameHistory[i].color);
			}
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	... 
		 *
		 * 	@return void
		 */
		private function initRectangles():void {
			_numOfBars = width / BAR_WIDTH;
			for (var i:int = 0; i < _numOfBars; i++) {
				_rectList.push(new Rectangle(0, 0, BAR_WIDTH, height));
			}
		}
		
		/**
		 *	... 
		 *
		 * 	@return void
		 */
		private function updateHistory():void {
			var bar:Object = generateBar(_frameCount);
			_frameHistory.unshift(bar);
			if (_frameHistory.length <= _numOfBars) return;
			_frameHistory.splice(_frameHistory.length -1, 1);
		}
		
		/**
		 *	... 
		 * 
		 * 	@param	Number	frameValue
		 * 	@return Object
		 */
		private function generateBar(frameValue:Number):Object {
			var obj:Object	= new Object();
			obj.color	= getColor(frameValue);
			obj.height	= frameValue / Session.application.stage.frameRate * height;
			return obj;
		}
		
		/**
		 *	... 
		 * 
		 * 	@param	Number	frameValue
		 * 	@return uint
		 */
		private function getColor(value:Number):uint {
			value = (value / stage.frameRate) * 100;
			if (value < 33) return 0xffEF5C53;
			if (value < 66) return 0xffFDD749;
			return 0xff59C169;
		}
	}
}