package se.lnu.stickossdk.component.notice {
	
	//--------------------------------------------------------------------------
	// Imports
	//--------------------------------------------------------------------------
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import se.lnu.stickossdk.component.text.ScrollingTextField;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	import se.lnu.stickossdk.tween.Tween;
	
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
	 *	@since		2017-04-05
	 */
	public class Notices extends Sprite {
		
		//----------------------------------------------------------------------
		//  Public static constants
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 */
		public static const SLIDE_DURATION:int = 500;
		
		/**
		 *	...
		 */
		public static const DISPLAY_DURATION:int = 6000;
		
		//----------------------------------------------------------------------
		//  Override public getter and setter methods
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
		// Private properties
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
		private var m_notice:Notice;
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_requests:Vector.<NoticeRequest> = new Vector.<NoticeRequest>();
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_timer:Timer;
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_tweener:Tween;
		
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 */
		public function Notices(width:Number = 800, height:Number = 600) {
			m_bounds = new Rectangle(0, 0, width, height);
		}
		
		//----------------------------------------------------------------------
		// Public methods
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		public function show(header:String, paragraph:String, icon:Class = null, sound:SoundObject = null, queue:Boolean = true):void {
			if (m_requests.length > 0 && queue == false) return;
			m_requests.push(new NoticeRequest(header, paragraph, icon, sound));
			if (m_requests.length == 1) m_initNotice();
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		public function dispose():void {
			m_disposeNotice();
			m_disposeRequests();
		}
		
		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_initNotice():void {
			if (m_notice == null && m_requests.length > 0) {
				m_notice = new Notice(
					m_requests[0].title,
					m_requests[0].description,
					m_requests[0].icon,
					m_requests[0].sound
				);
				
				addChild(m_notice);
				m_slideIn(m_notice);
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_disposeNotice():void {
			if (m_notice != null && m_notice.parent != null) {
				m_notice.parent.removeChild(m_notice);
				m_notice.dispose();
				m_notice = null;
			}
			
			m_requests.splice(0, 1);
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_disposeTween():void {
			if (m_tweener != null) {
				Session.core.tweener.remove(m_tweener);
				m_tweener = null;
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_disposeRequests():void {
			m_requests.length = 0;
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_slideIn(notice:Notice):void {
			notice.alpha = 0.0;
			notice.x = m_bounds.width;
			notice.y = 25;
			m_slide(notice, m_bounds.width - notice.width, 1.0, m_onNoticeInFocus);
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_slideOut(notice:Notice):void {
			notice.alpha = 1.0;
			notice.x = (m_bounds.width - notice.width);
			notice.y = 25;
			m_slide(notice, width, 0.0, m_onNoticeLostFocus);
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_slide(notice:Notice, x:Number, alpha:Number, callback:Function):void {
			m_disposeTween();
			m_tweener = Session.core.tweener.add(m_notice, {
				x: x,
				alpha: alpha,
				onComplete: callback,
				duration: SLIDE_DURATION
			});
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_onNoticeInFocus():void {
			m_timer = Session.core.timer.create(DISPLAY_DURATION, function():void { //@TODO: MAGIC
				m_slideOut(m_notice);
			});
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_onNoticeLostFocus():void {
			m_disposeNotice();
			m_initNotice();
		}
	}
}