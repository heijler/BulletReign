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
	import se.lnu.stickossdk.timer.Timer;
	
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
		private var m_medalRewarded:Boolean = false;
		private var m_updateControlFlag:Boolean = false;
		private var m_winnerText:TextField;
		private var m_winnerFormat:TextFormat;
		private var m_controlsTimer:Timer;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		public function WinnerScreen(gamemode:int, winner:int) {
			super();
			this.m_gamemode = gamemode;
			this.m_winner = winner;
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
			this.m_initTimer();
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
			if(this.m_winner == 0) {
				this.m_airForceMedalOfHonor = new AirforcemedalofhonorGFX();
				this.m_airForceMedalOfHonor.scaleX = 2;
				this.m_airForceMedalOfHonor.scaleY = 2;
				this.m_airForceMedalOfHonor.x = Session.application.size.x / 2;
				this.m_airForceMedalOfHonor.y = Session.application.size.y / 2;
				this.m_airForceMedalOfHonor.gotoAndStop(0);
				this.m_winnerScreenLayer.addChild(this.m_airForceMedalOfHonor);
			} else {
				this.m_ironCross = new IroncrossGFX();
				this.m_ironCross.scaleX = 2;
				this.m_ironCross.scaleY = 2; 
				this.m_ironCross.x = Session.application.size.x / 2;
				this.m_ironCross.y = Session.application.size.y / 2;
				this.m_ironCross.gotoAndStop(0);
				this.m_winnerScreenLayer.addChild(this.m_ironCross);
			}
		}
		
		private function m_initTimer():void {
			this.m_controlsTimer = Session.timer.create(3000, this.m_enableControls);
		}
		
		private function m_enableControls():void {
			trace("KÖRS");
			this.m_updateControlFlag = true;
		}
		
		private function m_awardMedal():void {
			if (this.m_winner == 0) {
				this.m_airForceMedalOfHonor.play();
				this.m_medal = "MEDAL OF HONOR";
			}
			if (this.m_winner == 1) {
				this.m_ironCross.play();
				this.m_medal = "IRON CROSS";
			}
		}
		
		private function m_winnerMessage():void {
			this.m_winnerText = new TextField();
			this.m_winnerText.text = "CONGRATULATIONS PLAYER " + (this.m_winner + 1) + "\nYOU HAVE BEEN REWARDED THE " + " \n" + this.m_medal + " FOR YOUR VICTORY!";
			this.m_winnerText.autoSize = "center";
			this.m_winnerText.x = (Session.application.size.x / 2) - (this.m_winnerText.width / 2);
			this.m_winnerText.y = (Session.application.size.y / 2) - 200;
			
			this.m_winnerFormat = new TextFormat();
			this.m_winnerFormat.color = 0xFFF392; //0xFFFFFF
			this.m_winnerFormat.kerning = true;
			this.m_winnerFormat.letterSpacing = 3;
			this.m_winnerFormat.size = 12;
			this.m_winnerFormat.leading = 8;
			this.m_winnerFormat.font = "bulletreign";
				
			this.m_winnerText.embedFonts = true;
			this.m_winnerText.setTextFormat(this.m_winnerFormat);
				
			this.m_winnerScreenLayer.addChild(this.m_winnerText);
		}
		
		/**
		 * update
		 * 
		 */
		override public function update():void {
			this.m_updateControls();
			if (this.m_medalRewarded == false) {
				this.m_medalRewarded = true;
				this.m_awardMedal();
				this.m_winnerMessage();
			}
			
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
			if (Input.keyboard.anyPressed() && this.m_updateControlFlag == true) {
				this.m_updateControlFlag = false;
				this.m_newState();
			}
		}
		
		/**
		 * m_newState
		 * 
		 */
		private function m_newState():void {
			trace("STATE");
			Session.application.displayState = new RematchMenu(this.m_gamemode);
		}
		
		override public function dispose():void {
			this.m_controls_one = null;
			this.m_controls_two = null;
			this.m_gamemode = 0;
			this.m_winner = 0;
			this.m_airForceMedalOfHonor = null;
			this.m_ironCross = null;
			this.m_medal = null;
			this.m_medalRewarded = false;
			this.m_winnerText = null;
			this.m_winnerFormat = null;
			Session.timer.remove(this.m_controlsTimer);
			this.m_controlsTimer = null;
		}
	}
}