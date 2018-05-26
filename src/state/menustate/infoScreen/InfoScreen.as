package state.menustate.infoScreen {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	import state.menustate.MainMenu;
	
	//-----------------------------------------------------------
	// InfoScreen
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
		 * 
		 */
		override public function init():void {
			this._initInfoScreen();
			this.m_initLayer();
			this._initBackground();
		}
		
		
		/**
		 * 
		 */
		override public function update():void {
			this.m_updateControls();
		}
			
		
		/**
		 * 
		 */
		override public function dispose():void {
			this.m_infoScreenLayer = null;
			this.m_controls_one = null;
			this.m_controls_two = null;
			this._infoScreen = null;
			this._background = null;
		}
		
		/**
		 * 
		 */
		private function m_updateControls():void {
			this._controlMove(this.m_controls_one);
			this._controlMove(this.m_controls_two);
		}
		
		
		/**
		 * 
		 */
		private function m_initLayer():void {
			this.m_infoScreenLayer = this.layers.add("infoScreen");
		}
		
		
		
		/**
		 * 
		 */
		protected function _controlMove(control:EvertronControls):void {
			if (Input.keyboard.anyPressed()) {
				this._newState();
			}
		}
		
		
		/**
		 * 
		 */
		protected function _newState():void {
			//Overridden by children
			Session.application.displayState = new MainMenu();
		}
		
		
		/**
		 * 
		 */
		protected function _initInfoScreen():void {
			// Overridden by children
		}
		
		
		
		/**
		 * 
		 */
		protected function _initBackground():void {
			this._background = this._infoScreen;
			this._background.scaleX = 2.5;
			this._background.scaleY = 2.5;
			this.m_infoScreenLayer.addChild(this._background);
		}
	}
}