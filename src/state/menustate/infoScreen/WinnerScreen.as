package state.menustate.infoScreen {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import asset.AirforcemedalofhonorGFX;
	import asset.IroncrossGFX;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	import state.menustate.RematchMenu;
	
	//-----------------------------------------------------------
	// WinnerScreen
	//-----------------------------------------------------------
	
	public class WinnerScreen extends DisplayState {
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_winnerScreenLayer:DisplayStateLayer;
		
		private var m_controls_one:EvertronControls = new EvertronControls(0);
		private var m_controls_two:EvertronControls = new EvertronControls(1);
		
		private var m_gamemode:int;
		private var m_winner:int;
		private var m_airForceMedalOfHonor:MovieClip;
		private var m_ironCross:MovieClip;
		private var m_medal:String;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		public function WinnerScreen(gamemode:int, winner:int) {
			super();
			this.m_gamemode = gamemode;
			this.m_winner = winner;
			trace("Running winnerScreen");
			
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
			this.m_initMedals();
			this.update();
		}
		
		/**
		 * m_initLayers
		 * 
		 */
		private function m_initLayers():void {
			this.m_winnerScreenLayer = this.layers.add("winnerscreen");
		}
		
		/**
		 * m_initBackground
		 * 
		 */
		private function m_initMedals():void {
			this.m_airForceMedalOfHonor = new AirforcemedalofhonorGFX();
			this.m_airForceMedalOfHonor.scaleX = 2;
			this.m_airForceMedalOfHonor.scaleY = 2;
			this.m_airForceMedalOfHonor.x = (Session.application.size.x / 2) - 200;
			this.m_airForceMedalOfHonor.y = (Session.application.size.y / 2);
			this.m_airForceMedalOfHonor.gotoAndStop(0);
			
			this.m_ironCross = new IroncrossGFX();
			this.m_ironCross.scaleX = 2;
			this.m_ironCross.scaleY = 2; 
			this.m_ironCross.x = (Session.application.size.x / 2) + 200;
			this.m_ironCross.y = (Session.application.size.y / 2);
			this.m_ironCross.gotoAndStop(0);
			
			this.m_winnerScreenLayer.addChild(this.m_airForceMedalOfHonor);
			this.m_winnerScreenLayer.addChild(this.m_ironCross);
			
		}
		
		private function m_awardMedal():void {
			if (this.m_winner == 0) {
				this.m_airForceMedalOfHonor.play();
				this.m_medal = "AIR FORCE MEDAL OF HONOR";
			}
			if (this.m_winner == 1) {
				this.m_ironCross.play();
				this.m_medal = "IRON CROSS";
			}
		}
		
		private function m_winnerMessage():void {
			var winnerText:TextField = new TextField();
				winnerText.text = "CONGRATULATIONS PLAYER " + (this.m_winner + 1) + "\nYOU HAVE BEEN REWARDED THE " + " \n" + this.m_medal + " FOR YOUR VICTORY!";
				winnerText.autoSize = "center";
				winnerText.x = Session.application.size.x / 2.6;
				winnerText.y = (Session.application.size.y / 2) - 200;
			
			var winnerFormat:TextFormat = new TextFormat();
				winnerFormat.color = 0xFFF392; //0xFFFFFF
				winnerFormat.kerning = true;
				winnerFormat.letterSpacing = 3;
				winnerFormat.size = 24;
				winnerFormat.font = "bulletreign";
				
				winnerText.setTextFormat(winnerFormat);
				
				this.m_winnerScreenLayer.addChild(winnerText);
		}
		
		/**
		 * update
		 * 
		 */
		override public function update():void {
			this.m_updateControls();
			this.m_awardMedal();
			this.m_winnerMessage();
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
			Session.application.displayState = new RematchMenu(this.m_gamemode);
		}
	}
}