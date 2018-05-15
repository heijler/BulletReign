package state.menustate.infoScreen {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.DisplayObject;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	import state.menustate.MainMenu;
	
	//-----------------------------------------------------------
	// Credits
	//-----------------------------------------------------------
	
	public class Credits extends DisplayState {
		
		//-----------------------------------------------------------
		// Embeds
		//-----------------------------------------------------------
		
		[Embed(source="../../../../asset/png/infoscreen/credits/credits.png")]
		private const InstructionsSheet:Class;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_instructionsLayer:DisplayStateLayer;
		private var m_background:DisplayObject;
		
		private var m_controls_one:EvertronControls = new EvertronControls(0);
		private var m_controls_two:EvertronControls = new EvertronControls(1);
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Credits() {
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
			this.m_initBackground();
			this.update();
		}
		
		
		/**
		 * m_initLayers
		 * 
		 */
		private function m_initLayers():void {
			this.m_instructionsLayer = this.layers.add("howtoplay");
		}
		
		
		/**
		 * m_initBackground
		 * 
		 */
		private function m_initBackground():void {
			this.m_background = new InstructionsSheet();
			this.m_background.scaleX = 2.5;
			this.m_background.scaleY = 2.5; 
			this.m_instructionsLayer.addChild(this.m_background);
		}
		
		
		/**
		 * update
		 * 
		 */
		override public function update():void {
			this.m_updateControls();
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
			if (Input.keyboard.anyPressed()) {
				this.m_newState();
			}
		}
		
		
		/**
		 * m_newState
		 * 
		 */
		private function m_newState():void {
			Session.application.displayState = new MainMenu();
		}
	}
}