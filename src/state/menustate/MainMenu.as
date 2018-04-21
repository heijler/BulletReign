package state.menustate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	import state.gamestate.Gamestate;
	
	//-----------------------------------------------------------
	// MainMenu
	//-----------------------------------------------------------
	
	public class MainMenu extends DisplayState {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		public var m_menuLayer:DisplayStateLayer;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_controls_one:EvertronControls = new EvertronControls(0);
		private var m_controls_two:EvertronControls = new EvertronControls(1);
		private var m_menuSelect:int = 0;
		private var m_menuOptions:Vector.<TextField> = new Vector.<TextField>();
		private var m_format:TextFormat;
		private var m_selectedFormat:TextFormat;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function MainMenu() {
			super();
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**	
		 * init
		 * override
		 */
		override public function init():void {
			this.m_initLayers();
			this.m_initFormat();
			this.m_initText();
			this.m_menuShow();
		}
		
		
		/**	
		 * update
		 * override
		 */
		override public function update():void {
			// Gameloop
			this.m_updateControls();
		}
		
		
		/**	
		 * dispose
		 * override
		 */
		override public function dispose():void {
			// Ta bort displaystate, tömmer minne
		}
		
		
		/**
		 * m_initLayers
		 * 
		 */
		private function m_initLayers():void {
			this.m_menuLayer = this.layers.add("mainMenu");
		}
		
		
		/**
		 * m_initFormat
		 * 
		 */
		private function m_initFormat():void {
			this.m_format = new TextFormat();
			this.m_format.color = 0xFFFFFF;
			this.m_format.kerning = true;
			this.m_format.letterSpacing = 3;
			this.m_format.size = 24;
			this.m_format.font = "adore64";
			
			this.m_selectedFormat = new TextFormat();
			this.m_selectedFormat.color = 0xEBD320;
			this.m_selectedFormat.kerning = true;
			this.m_selectedFormat.letterSpacing = 3;
			this.m_selectedFormat.size = 24;
			this.m_selectedFormat.font = "adore64";
		}
		
		
		/**
		 * m_initText
		 * 
		 */
		private function m_initText():void {
			var menuItems:Vector.<String> = new <String>["Dogfight", "Conquer the Banner", "How to Play", "Credits"];
			for(var i:int = 0; i < menuItems.length; i++) {
				this.m_menuOptions.push(this.m_createMenuItem(menuItems[i]));
				this.m_menuLayer.addChild(this.m_menuOptions[i]);
			}
		}
		
		
		/**
		 * m_createMenuItem
		 * 
		 */
		private function m_createMenuItem(text:String):TextField {
			var menuItem:TextField = new TextField();
				menuItem.text = text.toUpperCase();
				menuItem.x = Session.application.size.x * 0.5 - 200; //@FIX: Magic numbers
				menuItem.y = Session.application.size.y * 0.25 + this.m_format.size + this.m_menuOptions.length * 50; //@FIX: Magic numbers
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
			if (Input.keyboard.justPressed(control.PLAYER_UP)) {
				this.m_menuSelect--;
				this.m_menuMove();
			} else if (Input.keyboard.justPressed(control.PLAYER_DOWN)) {
				this.m_menuSelect++;
				this.m_menuMove();
			} else if (Input.keyboard.justPressed(control.PLAYER_BUTTON_1)) {
				Session.application.displayState = new Gamestate();
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
		 * m_menuShow
		 * 
		 */
		private function m_menuShow():void {
			this.m_menuOptions[this.m_menuSelect].text = "*" + this.m_menuOptions[this.m_menuSelect].text;
			this.m_menuOptions[this.m_menuSelect].setTextFormat(this.m_selectedFormat);
		}
		
		
		/**
		 * m_resetMenu
		 * 
		 */
		private function m_resetMenu():void {
			for (var i:int = 0; i < this.m_menuOptions.length; i++) {
				if (this.m_menuOptions[i].text.indexOf("*") != -1) {
					this.m_menuOptions[i].text = this.m_menuOptions[i].text.substring(1, this.m_menuOptions[i].text.length);
				}
			}
		}
	}
}