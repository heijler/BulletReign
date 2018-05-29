package state.menustate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;

	//-----------------------------------------------------------
	// Menu
	//-----------------------------------------------------------
	
	public class Menu extends DisplayState {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		private const SELECT_CHAR:String = "@";
		private const COPY_CHAR:String = "©";
		
		private var m_menuLayer:DisplayStateLayer;
		private var m_controls_one:EvertronControls  = new EvertronControls(0);
		private var m_controls_two:EvertronControls  = new EvertronControls(1);
		private var m_menuOptions:Vector.<TextField> = new Vector.<TextField>();
		private var m_menuObject:Vector.<Object>;
		private var m_menuSelect:int = 0;
		private var m_blinkCounter:int = 0;
		private var m_selected:Boolean;
		private var m_format:TextFormat;
		private var m_selectedFormat:TextFormat;
		private var m_menuMoveSound:SoundObject;
		private var m_menuSelectSound:SoundObject;
		private var m_image:Bitmap;
		private var m_artWork:Vector.<Bitmap> = new Vector.<Bitmap>();
		private var m_copy:TextField;
		private var m_newStateTimer:Timer;

		
		
		//-----------------------------------------------------------
		// Protected properties
		//-----------------------------------------------------------
		
		protected var _items:Vector.<String> = new Vector.<String>();
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Menu() {
			super();
		}
		
		//-----------------------------------------------------------
		// Overrides
		//-----------------------------------------------------------
		
		
		/**
		 * init
		 */
		override public function init():void {
			this.m_initLayers();
			this.m_initFormat();
			this.initMenu();
			this.m_initSound();
		}
		
		
		/**
		 * update
		 */
		override public function update():void {
			this.m_updateControls();
			this.m_blinkSelection();
		}
		
		
		/**
		 * dispose
		 */
		override public function dispose():void {
			this.m_controls_one = null;
			this.m_controls_two = null;
			this.m_menuSelect = 0;
			if (this.m_copy != null) {
				this.m_copy.parent.removeChild(this.m_copy);
			}
			this.m_copy = null;
			this.m_menuOptions.length = 0;
			this.m_menuOptions = null;
			this.m_menuObject.length = 0;
			this.m_menuObject = null;
			this.m_format = null;
			this.m_selectedFormat = null;
			this.m_menuMoveSound = null;
			this.m_menuSelectSound = null;
			this.m_image = null;
			this.m_selected = false;
			this.m_blinkCounter = 0;
			this._disposeMenu();
			Session.timer.remove(this.m_newStateTimer);
			this.m_newStateTimer = null;
		}
		
		
		/**
		 * initMenu
		 */
		protected function initMenu():void {
			//Child classes override this method.
		}
		
		
		/**
		 * disposeMenu
		 */
		protected function _disposeMenu():void {
			this.m_disposeArtwork();
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * m_initLayers
		 * 
		 */
		private function m_initLayers():void {
			this.m_menuLayer = this.layers.add("mainMenu");
		}
		
		
		/**
		 * m_initSound
		 *  
		 */
		private function m_initSound():void {
			Session.sound.soundChannel.sources.add("menumove", BulletReign.MENUMOVE_SOUND);
			Session.sound.soundChannel.sources.add("menuselect", BulletReign.MENUSELECT_SOUND);
			this.m_menuMoveSound = Session.sound.soundChannel.get("menumove");
			this.m_menuSelectSound = Session.sound.soundChannel.get("menuselect");
		}
		
		
		/**
		 * m_initFormat
		 * 
		 */
		private function m_initFormat():void {
			this.m_format = new TextFormat();
			this.m_format.color = 0xFFF392; //0xFFFFFF
			this.m_format.kerning = true;
			this.m_format.letterSpacing = 3;
			this.m_format.size = 14;
			this.m_format.font = "bulletreign";
			
			this.m_selectedFormat = new TextFormat();
			this.m_selectedFormat.color = 0xEBD320;
			this.m_selectedFormat.kerning = true;
			this.m_selectedFormat.letterSpacing = 3;
			this.m_selectedFormat.size = 14;
			this.m_selectedFormat.font = "bulletreign";
		}
		
		
		/**
		 * m_initText
		 * 
		 */
		private function m_initText():void {
			for(var i:int = 0; i < _items.length; i++) {
				this.m_menuOptions.push(this.m_createMenuItem(_items[i]));
			}
			this.m_addChildren();
			this.m_menuShow();
		}
		
		
		
		/**
		 * m_addChildren
		 * 
		 */
		private function m_addChildren():void {
			for (var i:int = 0; i < this.m_menuOptions.length; i++) {
				this.m_menuLayer.addChild(this.m_menuOptions[i]);
			}
			
			for (var j:int = 0; j < this.m_artWork.length; j++) {
				if (this.m_artWork[j] != null) {
					this.m_menuLayer.addChild(this.m_artWork[j]);
				}
			}
			
			if(this.m_image != null) {
				this.m_menuLayer.addChild(this.m_image);
			}
		}
		
		
		/**
		 * m_createMenuItem
		 * 
		 */
		private function m_createMenuItem(text:String):TextField {
			var menuItem:TextField = new TextField();
			menuItem.text = text.toUpperCase();
			menuItem.x = Session.application.size.x * 0.5 - 100; //@FIX: Magic numbers
			menuItem.y = Session.application.size.y * 0.35 + this.m_format.size + this.m_menuOptions.length * 50; //@FIX: Magic numbers
			menuItem.autoSize = TextFieldAutoSize.LEFT;
			menuItem.setTextFormat(this.m_format);
			menuItem.defaultTextFormat = this.m_format;
			menuItem.embedFonts = true;
			return menuItem;
		}
		
		
		/**
		 * m_updateControls
		 * 
		 */
		private function m_updateControls():void {
			this.m_controlMove(this.m_controls_one);
			this.m_controlMove(this.m_controls_two);
		}
		
		
		/**
		 * m_controlMove
		 * 
		 */
		private function m_controlMove(control:EvertronControls):void {
			if (Input.keyboard.justPressed(control.PLAYER_UP) && !this.m_selected) {
				this.m_menuMoveSound.play();
				this.m_menuSelect--;
				this.m_menuMove();
			} else if (Input.keyboard.justPressed(control.PLAYER_DOWN) && !this.m_selected) {
				this.m_menuMoveSound.play();
				this.m_menuSelect++;
				this.m_menuMove();
			} else if (Input.keyboard.justPressed(control.PLAYER_BUTTON_1) && !this.m_selected) {
				this.m_menuSelectSound.play();
				this.m_selected = true;
				this.m_newStateTimer = Session.timer.create(700, this.m_newState);
			}
		}
		
		
		/**
		 * m_menuMove
		 * 
		 */
		private function m_menuMove():void {
			if (this.m_menuSelect < 0) {
				this.m_menuSelect = this.m_menuOptions.length - 1;
			} else if (this.m_menuSelect >= this.m_menuOptions.length) {
				this.m_menuSelect = 0;
			}
			this.m_resetMenu();
			this.m_menuShow();
		
		}
		
		
		/**
		 * m_newState
		 * 
		 */
		private function m_newState():void {
			Session.application.displayState = new this.m_menuObject[this.m_menuSelect].state;
		}
		
		
		/**
		 * m_resetMenu
		 */
		private function m_resetMenu():void {
			for (var i:int = 0; i < this.m_menuOptions.length; i++) {
				if (this.m_menuOptions[i].text.indexOf(this.SELECT_CHAR) != -1) {
					this.m_menuOptions[i].text = this.m_menuOptions[i].text.substring(1, this.m_menuOptions[i].text.length);
				}
			}
		}
		
		
		/**
		 * m_menuShow
		 * 
		 */
		private function m_menuShow():void {
			this.m_menuOptions[this.m_menuSelect].text = this.SELECT_CHAR + this.m_menuOptions[this.m_menuSelect].text;
			this.m_menuOptions[this.m_menuSelect].setTextFormat(this.m_selectedFormat);
		}
		
		
		/**
		 * m_blinkSelection
		 * 
		 */
		private function m_blinkSelection():void {
			//@TODO: Gör detta på något smidigare sätt
			if (this.m_selected) {
				this.m_blinkCounter++;
				var text:TextField = this.m_menuOptions[this.m_menuSelect];
				if (this.m_blinkCounter == 4) {
					text.setTextFormat(this.m_format);
				} else if(this.m_blinkCounter == 8) {
					text.setTextFormat(this.m_selectedFormat);
					this.m_blinkCounter = 0;
				}
			}
		}
		
		
		/**
		 * 
		 */
		private function m_disposeArtwork():void {
			for (var i:int = 0; i < this.m_artWork.length; i++) {
				if (this.m_menuLayer.contains(this.m_artWork[i])) {
					this.m_menuLayer.removeChild(this.m_artWork[i]);
					this.m_artWork[i] = null;
				}
			}
			this.m_artWork.length = 0;
			this.m_artWork = null;
		}
		
		
		//-----------------------------------------------------------
		// Protected methods
		//-----------------------------------------------------------
		
		/**
		 * _addImage
		 * 
		 */
		protected function _addImage(image:Bitmap, pos:Point):void {
			this.m_image = image;
			this.m_image.x = pos.x;
			this.m_image.y = pos.y;
		}
		
		
		/**
		 * _addArt
		 * 
		 */
		protected function _addArt(art:Bitmap, pos:Point):void {
			this.m_artWork.push(art);
			this.m_artWork[this.m_artWork.indexOf(art)].x = pos.x;
			this.m_artWork[this.m_artWork.indexOf(art)].y = pos.y;
		}
		
		
		/**
		 * _addMenuItems
		 * 
		 */
		protected function _addMenuItems(menuObjects:Vector.<Object>):void {
			this.m_menuObject = menuObjects;
			for (var i:int = 0; i < menuObjects.length; i++) {
				this._items.push(menuObjects[i].name);
			}
			this.m_initText();
		}
		
		
		/**
		 * 
		 */
		protected function _addCopy():void {
			this.m_copy = new TextField();
			this.m_copy.text = (this.COPY_CHAR + "\\>[} skak-fx");
			this.m_copy.setTextFormat(this.m_selectedFormat);
			this.m_copy.embedFonts = true;
			this.m_copy.autoSize = TextFieldAutoSize.LEFT;
			this.m_copy.x = (Session.application.size.x * 0.5) - (this.m_copy.width * 0.5);
			this.m_copy.y = Session.application.size.y - 40;
			this.m_menuLayer.addChild(this.m_copy);
		}
		
	}
}