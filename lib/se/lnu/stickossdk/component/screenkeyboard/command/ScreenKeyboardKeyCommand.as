package se.lnu.stickossdk.component.screenkeyboard.command
{
	import se.lnu.stickossdk.component.screenkeyboard.ScreenKeyboardKeys;

	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	//-----------------------------------------------------------
	// Public interface
	//-----------------------------------------------------------
	
	/**
	 *	Handles all keyboard keys for the screen keyboard.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 * 				Emil Johansson <emiljohansson.se@gmail.com>
	 */
	public class ScreenKeyboardKeyCommand
	{
		/**
		 *	Handles a key press.
		 * 
		 * 	@param 	_selectedKey
		 * 	@return	void
		 */
		public function execute(keyPresenter:ScreenKeyboardKeys):void {}
	}
}