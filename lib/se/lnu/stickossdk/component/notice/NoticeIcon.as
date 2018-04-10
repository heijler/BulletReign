package se.lnu.stickossdk.component.notice {
	
	//--------------------------------------------------------------------------
	// Imports
	//--------------------------------------------------------------------------
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	//--------------------------------------------------------------------------
	// Internal class
	//--------------------------------------------------------------------------
	
	/**
	 *	...
	 *
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 *	@copyright	Copyright (c) 2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@version	1.0
	 *	@since		2013-11-22
	 */
	internal class NoticeIcon extends Sprite {
		
		//----------------------------------------------------------------------
		// Private properties
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_icon:MovieClip
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_mask:Sprite;
		
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 */
		public function NoticeIcon(source:Class) {
			m_initMask();
			m_initIcon(source);
		}
		
		//----------------------------------------------------------------------
		// Internal methods
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		internal function dispose():void {
			m_disposeMask();
			m_disposeIcon();
		}
		
		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_initMask():void {
			m_mask = new Sprite();
			m_mask.graphics.beginFill(0xFF00FF);
			m_mask.graphics.drawRect(0, 0, 40, 40);
			//m_mask.graphics.drawCircle(20, 20, 20);
			m_mask.graphics.endFill();
			
			addChild(m_mask);
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_initIcon(source:Class):void {
			m_icon = new source() as MovieClip;
			m_resize(m_icon);
			m_icon.x = (width  >> 1) - (m_icon.width  >> 1);
			m_icon.y = (height >> 1) - (m_icon.height >> 1);
			m_icon.mask = m_mask;
			
			addChild(m_icon);
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_disposeMask():void {
			if (m_mask != null && m_mask.parent != null) {
				m_mask.parent.removeChild(m_mask);
				m_mask = null;
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_disposeIcon():void {
			if (m_icon != null && m_icon.parent != null) {
				m_icon.parent.removeChild(m_icon);
				m_icon = null;
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_resize(obj:DisplayObject):void {
			var scaleFactor:Number = 1.0;
			if (obj.width < obj.height) scaleFactor = width / obj.width;
			else scaleFactor = height / obj.height;
			
			obj.scaleX = scaleFactor;
			obj.scaleY = scaleFactor;
		}
	}
}