package se.lnu.stickossdk.component.notice {
	
	//--------------------------------------------------------------------------
	// Imports
	//--------------------------------------------------------------------------
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	
	import se.lnu.stickossdk.component.text.ScrollingTextField;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
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
	internal class Notice extends Sprite {
		
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
		private var m_header:ScrollingTextField;
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_paragraph:ScrollingTextField;
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_icon:NoticeIcon;
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private var m_sound:SoundObject;
		
		//----------------------------------------------------------------------
		// Private static constants
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@private
		 */
		private static const SOUND_ID:String = "sound_notice_popup";
		
		//----------------------------------------------------------------------
		// Private static embedded constants
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/mp3/notice/sound_notice_popup.mp3")]
		private static const SOUND:Class;
		
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
		override public function get height():Number {
			return m_bounds.height;
		}
		
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 */
		public function Notice(header:String, paragraph:String, icon:Class = null, sound:SoundObject = null, bounds:Rectangle = null) {
			m_initGraphics(bounds);
			m_initIcon(icon);
			m_initHeader(header);
			m_initParagraph(paragraph);
			m_initSound(sound);
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
			m_disposeGraphics();
			m_disposeIcon();
			m_disposeHeader();
			m_disposeParagraph();
			m_disposeSound();
		}
		
		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_initGraphics(bounds:Rectangle = null):void {
			m_bounds = (bounds != null) ? bounds : new Rectangle(0, 0, 320, 60);
			graphics.beginFill(0x000000, 0.85);
			graphics.drawRect(0, 0, m_bounds.width, m_bounds.height);
			graphics.endFill();
			graphics.lineStyle(1, 0xFFFFFF);
			graphics.moveTo(width, 1);
			graphics.lineTo(1, 1);
			graphics.lineTo(1, m_bounds.height - 2);
			graphics.lineTo(width, m_bounds.height - 2);
			graphics.endFill();
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_initIcon(source:Class = null):void {
			if (source != null) {
				m_icon = new NoticeIcon(source);
				m_icon.x = 10;
				m_icon.y = 10;
				
				addChild(m_icon);
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_initHeader(text:String = ""):void {
			m_header = new ScrollingTextField(new Rectangle(0, 0, 260, 60));
			m_header.x = (m_icon) ? 60 : 10;
			m_header.y = 10;
			m_header.text = text;
			
			addChild(m_header);
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_initParagraph(text:String = ""):void {
			m_paragraph = new ScrollingTextField(new Rectangle(0, 0, 260, 60));
			m_paragraph.textFormat = new TextFormat("Arial", 14); //@TODO: BETTER FONT?
			m_paragraph.text = text;
			m_paragraph.x = (m_icon) ? 60 : 10;
			m_paragraph.y = 30;
			
			addChild(m_paragraph);
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_initSound(sound:SoundObject = null):void {
			if (sound is SoundObject) m_sound = sound;
			else {
				Session.sound.soundChannel.sources.add(SOUND_ID, SOUND);
				m_sound = Session.sound.soundChannel.get(SOUND_ID, true, true);
			}
			
			m_sound.play();
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_disposeGraphics():void {
			m_bounds = null;
			graphics.clear();
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_disposeIcon():void {
			if (m_icon != null && m_icon.parent != null) {
				m_icon.parent.removeChild(m_icon);
				m_icon.dispose();
				m_icon = null;
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_disposeHeader():void {
			if (m_header != null && m_header.parent != null) {
				m_header.parent.removeChild(m_header);
				m_header = null;
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_disposeParagraph():void {
			if (m_paragraph != null && m_paragraph.parent != null) {
				m_paragraph.parent.removeChild(m_paragraph);
				m_paragraph = null;
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function m_disposeSound():void {
			if (m_sound != null) {
				m_sound.stop();
				m_sound = null;
			}
		}
	}
}