package state.menustate.infoScreen {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.DisplayObject;
	import flash.display.Bitmap;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.input.Input;
	
	import state.menustate.MainMenu;
	
	//-----------------------------------------------------------
	// InfoScreen
	// Represents an InfoScreen / Simple screen that displays 
	// an image and changes state on control input
	//-----------------------------------------------------------
	
	public class InfoScreen extends DisplayState {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_infoScreenLayer:DisplayStateLayer;
		private var m_controls_one:EvertronControls = new EvertronControls(0);
		private var m_controls_two:EvertronControls = new EvertronControls(1);
		
		//-----------------------------------------------------------
		// Protected properties
		//-----------------------------------------------------------
		
		protected var _infoScreen:Bitmap;
		protected var _background:DisplayObject;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		public function InfoScreen() {
			super();
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**
		 * init override
		 */
		override public function init():void {
			this._initInfoScreen();
			this.m_initLayer();
			this._initBackground();
		}
		
		
		/**
		 * update override
		 */
		override public function update():void {
			this.m_updateControls();
		}
			
		
		/**
		 * dispose override
		 */
		override public function dispose():void {
			trace("InfoScreen dispose");
			if (this.m_infoScreenLayer.contains(this._background)) {
				this.m_infoScreenLayer.removeChild(this._background);
			}
			this.m_infoScreenLayer = null;
			this.m_controls_one = null;
			this.m_controls_two = null;
			this._infoScreen = null;
			this._background = null;
		}
		
		
		/**
		 * Accept both control inputs
		 */
		private function m_updateControls():void {
			this._controlMove(this.m_controls_one);
			this._controlMove(this.m_controls_two);
		}
		
		
		/**
		 * Initialize layer
		 */
		private function m_initLayer():void {
			this.m_infoScreenLayer = this.layers.add("infoScreen");
		}
		
		
		/**
		 * By default an infoscreen will change state to MainMenu on any button press. 
		 * This can be overridden by the child classes.
		 */
		protected function _controlMove(control:EvertronControls):void {
			//Overridden by children
			if (Input.keyboard.anyPressed()) {
				this._newState();
			}
		}
		
		
		/**
		 * Sets the state to MainMenu, can be overridden by child classes.
		 */
		protected function _newState():void {
			//Overridden by children
			Session.application.displayState = new MainMenu();
		}
		
		
		/**
		 * This method is run on InfoScreen init.
		 */
		protected function _initInfoScreen():void {
			// Overridden by children
		}
		
		
		
		/**
		 * Initialize background
		 */
		protected function _initBackground():void {
			this._background = this._infoScreen;
			this._background.scaleX = 2.5;
			this._background.scaleY = 2.5;
			this.m_infoScreenLayer.addChild(this._background);
		}
	}
}