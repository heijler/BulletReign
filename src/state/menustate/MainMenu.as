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
		// Properties
		//-----------------------------------------------------------
		
		public var m_menuLayer:DisplayStateLayer;
		private var m_controls_one:EvertronControls = new EvertronControls(0);
		private var m_controls_two:EvertronControls = new EvertronControls(1);
		
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
			this.m_initText();
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
		 * m_initText
		 * 
		 */
		private function m_initText():void {
			var format:TextFormat = new TextFormat();
				format.color = 0xFFFFFF;
				format.kerning = true;
				format.letterSpacing = 1;
				format.size = 24;
			
			var menu1:TextField = new TextField();
				menu1.text = "Dogfight";
				menu1.x = 300;
				menu1.y = 150;
				menu1.autoSize = TextFieldAutoSize.LEFT;
				menu1.setTextFormat(format);
			this.m_menuLayer.addChild(menu1);
			
			var menu2:TextField = new TextField();
				menu2.text = "Conquer the Banner";
				menu2.x = menu1.x;
				menu2.y = menu1.y + format.size + 10;
				menu2.autoSize = TextFieldAutoSize.LEFT;
				menu2.setTextFormat(format);
			this.m_menuLayer.addChild(menu2);
			
			var menu3:TextField = new TextField();
				menu3.text = "How to play";
				menu3.x = menu1.x;
				menu3.y = menu2.y + format.size + 10;
				menu3.autoSize = TextFieldAutoSize.LEFT;
				menu3.setTextFormat(format);
			this.m_menuLayer.addChild(menu3);
			
			var menu4:TextField = new TextField();
				menu4.text = "Credits";
				menu4.x = menu1.x;
				menu4.y = menu3.y + format.size + 10;
				menu4.autoSize = TextFieldAutoSize.LEFT;
				menu4.setTextFormat(format);
			this.m_menuLayer.addChild(menu4);
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
				trace("Up");
			} else if (Input.keyboard.justPressed(control.PLAYER_DOWN)) {
				trace("Down");
			} else if (Input.keyboard.justPressed(control.PLAYER_BUTTON_1)) {
				Session.application.displayState = new Gamestate();
			}
		}
	}
}