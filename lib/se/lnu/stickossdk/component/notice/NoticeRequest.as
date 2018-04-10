package se.lnu.stickossdk.component.notice {
	import se.lnu.stickossdk.media.SoundObject;
	
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
	internal class NoticeRequest {
		
		//----------------------------------------------------------------------
		// Public properties
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		public var title:String;
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		public var description:String;
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		public var icon:Class;
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		public var sound:SoundObject
		
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 */
		public function NoticeRequest(title:String, description:String, icon:Class = null, sound:SoundObject = null) {
			this.title = title;
			this.description = description;
			this.icon = icon;
			this.sound = sound;
		}
	}
}