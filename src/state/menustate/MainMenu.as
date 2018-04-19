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
		private const MENU_ITEM_MARGIN:int = 15;
		
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
			
			
			var menu1:TextField = new TextField();
				menu1.text = "Dogfight".toUpperCase();
				menu1.x = Session.application.size.x * 0.5 - 200;
				menu1.y = 150;
				menu1.autoSize = TextFieldAutoSize.LEFT;
				menu1.setTextFormat(this.m_format);
				menu1.embedFonts = true;
			this.m_menuLayer.addChild(menu1);
			
			var menu2:TextField = new TextField();
				menu2.text = "Conquer the Banner".toUpperCase();
				menu2.x = menu1.x;
				menu2.y = menu1.y + this.m_format.size + this.MENU_ITEM_MARGIN;
				menu2.autoSize = TextFieldAutoSize.LEFT;
				menu2.setTextFormat(this.m_format);
				menu2.embedFonts = true;
			this.m_menuLayer.addChild(menu2);
			
			var menu3:TextField = new TextField();
				menu3.text = "How to play".toUpperCase();
				menu3.x = menu1.x;
				menu3.y = menu2.y + this.m_format.size + this.MENU_ITEM_MARGIN;
				menu3.autoSize = TextFieldAutoSize.LEFT;
				menu3.setTextFormat(this.m_format);
				menu3.embedFonts = true;
			this.m_menuLayer.addChild(menu3);
			
			var menu4:TextField = new TextField();
				menu4.text = "Credits".toUpperCase();
				menu4.x = menu1.x;
				menu4.y = menu3.y + this.m_format.size + this.MENU_ITEM_MARGIN;
				menu4.autoSize = TextFieldAutoSize.LEFT;
				menu4.setTextFormat(this.m_format);
				menu4.embedFonts = true;
			this.m_menuLayer.addChild(menu4); // Make method to addChildren to menuLayer
			
			this.m_menuOptions.push(menu1, menu2, menu3, menu4);
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
		 * 
		 */
		private function m_menuShow():void {
			this.m_menuOptions[this.m_menuSelect].text = "*" + this.m_menuOptions[this.m_menuSelect].text;
			this.m_menuOptions[this.m_menuSelect].setTextFormat(this.m_selectedFormat);
		}
		
		private function m_resetMenu():void {
			for (var i:int = 0; i < this.m_menuOptions.length; i++) {
				this.m_menuOptions[i].text;
				if (this.m_menuOptions[i].text.indexOf("*") != -1) {
					this.m_menuOptions[i].text = this.m_menuOptions[i].text.substring(1, this.m_menuOptions[i].text.length);
					this.m_menuOptions[i].setTextFormat(this.m_format);
				}
			}
		}
	}
}