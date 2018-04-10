package se.lnu.stickossdk.component.screenkeyboard.command
{
	import se.lnu.stickossdk.component.screenkeyboard.ScreenKeyboardKeys;

	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	//-----------------------------------------------------------
	// Internal class
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
	public class ScreenKeyboardKeyDownCommand extends ScreenKeyboardKeyCommand
	{
		/**
		 * @inheritDoc
		 */
		override public function execute(keyPresenter:ScreenKeyboardKeys):void {
			keyPresenter.selectedKey.y++;
			if (keyPresenter.selectedKey.y > keyPresenter.keys.length - 1) {
				keyPresenter.selectedKey.y = 0;
			}
			if (keyPresenter.selectedKey.x > keyPresenter.keys[keyPresenter.selectedKey.y].length - 1) {
				keyPresenter.selectedKey.x = keyPresenter.keys[keyPresenter.selectedKey.y].length - 1;
			}
		}
	}
}

