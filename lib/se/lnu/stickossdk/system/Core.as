package se.lnu.stickossdk.system {
	import flash.geom.Rectangle;
	
	import se.lnu.stickossdk.timer.Timer;
	import se.lnu.stickossdk.timer.Timers;
	import se.lnu.stickossdk.tween.Tweener;
	
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
	internal class Core {
		
		//----------------------------------------------------------------------
		// Public getter and setter methods
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		public function get timer():Timers {
			return m_timers;
		}
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		public function get tweener():Tweener {
			return m_tweener;
		}
		
		//----------------------------------------------------------------------
		// Private properties
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_timers:Timers;
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_tweener:Tweener;
		
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 */
		public function Core() {
			init();
		}
		
		//----------------------------------------------------------------------
		// Public methods
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		public function init():void {
			m_initTimers();
			m_initTweener();
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		public function update():void {
			m_updateTimers();
			m_updateTweener();
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		public function dispose():void {
			m_disposeTimers();
			m_disposeTweener();
		}
		
		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_initTimers():void {
			m_disposeTimers();
			m_timers = new Timers();
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_initTweener():void {
			m_disposeTweener();
			m_tweener = new Tweener();
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_updateTimers():void {
			if (m_timers != null) {
				m_timers.update();
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_updateTweener():void {
			if (m_tweener != null) {
				m_tweener.update();
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_disposeTimers():void {
			if (m_timers != null) {
				m_timers.dispose();
				m_timers = null;
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_disposeTweener():void {
			if (m_tweener != null) {
				m_tweener.dispose();
				m_tweener = null;
			}
		}
	}
}