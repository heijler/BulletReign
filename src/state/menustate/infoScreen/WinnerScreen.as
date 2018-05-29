package state.menustate.infoScreen {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.text.TextFormat;
	import flash.display.Bitmap;
	import flash.text.TextField;
	
	import asset.AirforcemedalofhonorGFX;
	import asset.PourlemeriteGFX;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.timer.Timer;
	
	import state.menustate.RematchMenu;
	
	//-----------------------------------------------------------
	// WinnerScreen
	// Represents a WinnerScreen
	//-----------------------------------------------------------
	
	public class WinnerScreen extends DisplayState {
		
		//-----------------------------------------------------------
		// Embeds
		//-----------------------------------------------------------
		
		[Embed(source="../../../../asset/png/infoscreen/winnerscreen/winner0.png")]
		private const Winner0:Class;
		
		[Embed(source="../../../../asset/png/infoscreen/winnerscreen/winner1.png")]
		private const Winner1:Class;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_winnerScreenLayer:DisplayStateLayer;
		
		private var m_controls_one:EvertronControls = new EvertronControls(0);
		private var m_controls_two:EvertronControls = new EvertronControls(1);
		
		private var m_gamemode:int;
		private var m_winner:int;
		private var m_medalSkin:MovieClip;
		private var m_medal:String;
		private var m_medalRewarded:Boolean = false;
		private var m_updateControlFlag:Boolean = false;
		private var m_winnerTextTitle:TextField;
		private var m_winnerTextMain:TextField;
		private var m_pressBtn:TextField;
		private var m_winnerFormatTitle:TextFormat;
		private var m_winnerFormatMain:TextFormat;
		private var m_pressBtnFormat:TextFormat;
		private var m_controlsTimer:Timer;
		private var m_infoscreenMusic:SoundObject;
		private var m_winnerArt:Bitmap;
		
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
			this.m_initMusic();
			this.m_initWinnerArt();
			this.m_initMedals();
			this.m_initTimer();
		}
		
		
		/**
		 * Initialize layers
		 */
		private function m_initLayers():void {
			this.m_winnerScreenLayer = this.layers.add("winnerscreen");
		}
		
		
		/**
		 * Initialize music
		 */
		private function m_initMusic():void {
			Session.sound.musicChannel.sources.add("infoscreenmusic", BulletReign.INFOSCREEN_MUSIC);
			this.m_infoscreenMusic = Session.sound.musicChannel.get("infoscreenmusic");
			this.m_infoscreenMusic.play(int.MAX_VALUE);
			this.m_infoscreenMusic.volume = 0.7;
		}
		
		
		/**
		 * Initialize medal graphic
		 */
		private function m_initMedals():void {
			if(this.m_winner == 0) {
				this.m_medalSkin = new AirforcemedalofhonorGFX();
				this.m_medalSkin.scaleX = 2.5;
				this.m_medalSkin.scaleY = 2.5;
				this.m_medalSkin.x = Session.application.size.x / 2;
				this.m_medalSkin.y = Session.application.size.y / 2;
				this.m_medalSkin.gotoAndStop(1);
				this.m_winnerScreenLayer.addChild(this.m_medalSkin);
			} else {
				this.m_medalSkin = new PourlemeriteGFX();
				this.m_medalSkin.scaleX = 2.5;
				this.m_medalSkin.scaleY = 2.5; 
				this.m_medalSkin.x = Session.application.size.x / 2;
				this.m_medalSkin.y = Session.application.size.y / 2;
				this.m_medalSkin.gotoAndStop(1);
				this.m_winnerScreenLayer.addChild(this.m_medalSkin);
			}
		}
		
		
		
		/**
		 * Initialize art of the winning plane
		 */
		private function m_initWinnerArt():void {
			if (this.m_winner == 0) {
				this.m_winnerArt = new Winner0;
				this.m_winnerArt.scaleX = 2.5;
				this.m_winnerArt.scaleY = 2.5;
				this.m_winnerArt.x = 50;
				this.m_winnerArt.y = Session.application.size.y - this.m_winnerArt.height - 20;
			} else if (this.m_winner == 1) {
				this.m_winnerArt = new Winner1;
				this.m_winnerArt.scaleX = 2.5;
				this.m_winnerArt.scaleY = 2.5;
				this.m_winnerArt.x = Session.application.size.x - this.m_winnerArt.width - 20;
				this.m_winnerArt.y = Session.application.size.y - this.m_winnerArt.height - 20;
			}
			this.m_winnerScreenLayer.addChild(this.m_winnerArt);
		}
		
		
		/**
		 * Initialize the timer until the controls are enabled.
		 * The controls are on a timer to prevent missclicks.
		 */
		private function m_initTimer():void {
			this.m_controlsTimer = Session.timer.create(1000, this.m_enableControls);
		}
		
		
		/**
		 * Enables controls
		 */
		private function m_enableControls():void {
			this.m_updateControlFlag = true;
			this.m_medalSkin.gotoAndStop(2);
		}
		
		
		/**
		 * Depending on winner, sets a string to a certain type of medal.
		 */
		private function m_awardMedal():void {
			if (this.m_winner == 0) {
				this.m_medal = "MEDAL OF HONOR";
			}
			if (this.m_winner == 1) {
				this.m_medal = "POUR LE MERITE";
			}
		}
		
		
		/**
		 * Creates the TextField to display the message saying "Congratulations..."
		 */
		private function m_winnerMessage():void {
			this.m_winnerTextTitle = new TextField();
			this.m_winnerTextMain = new TextField();
			this.m_winnerTextTitle.text = "CONGRATULATIONS PLAYER" + (this.m_winner + 1); 
			this.m_winnerTextMain.text = "YOU HAVE BEEN REWARDED " + this.m_medal;
			this.m_winnerTextTitle.autoSize = "center";
			this.m_winnerTextMain.autoSize = "center";
			this.m_winnerTextTitle.x = (Session.application.size.x / 2) - (this.m_winnerTextTitle.width / 2);
			this.m_winnerTextMain.x = (Session.application.size.x / 2) - (this.m_winnerTextMain.width / 2);
			this.m_winnerTextTitle.y = (Session.application.size.y / 2) - 200;
			this.m_winnerTextMain.y = (Session.application.size.y / 2) - 160;
			
			this.m_winnerFormatTitle = new TextFormat();
			this.m_winnerFormatTitle.color = 0xFFF392; //0xFFFFFF
			this.m_winnerFormatTitle.kerning = true;
			this.m_winnerFormatTitle.letterSpacing = 3;
			this.m_winnerFormatTitle.size = 16;
			this.m_winnerFormatTitle.font = "bulletreign";
			
			this.m_winnerFormatMain = new TextFormat();
			this.m_winnerFormatMain.color = 0xFFF392; //0xFFFFFF
			this.m_winnerFormatMain.kerning = true;
			this.m_winnerFormatMain.letterSpacing = 3;
			this.m_winnerFormatMain.size = 10;
			this.m_winnerFormatMain.leading = 8;
			this.m_winnerFormatMain.font = "bulletreign";
				
			this.m_winnerTextTitle.embedFonts = true;
			this.m_winnerTextMain.embedFonts = true;
			this.m_winnerTextTitle.setTextFormat(this.m_winnerFormatTitle);
			this.m_winnerTextMain.setTextFormat(this.m_winnerFormatMain);
				
			this.m_winnerScreenLayer.addChild(this.m_winnerTextTitle);
			this.m_winnerScreenLayer.addChild(this.m_winnerTextMain);
		}
		
		
		/**
		 * Creates and displays the "Press any button"-text.
		 */
		private function m_pressAnyButton():void {
			this.m_pressBtn = new TextField();
			this.m_pressBtn.text = "- press any button -".toUpperCase();
			this.m_pressBtn.autoSize = "center";
			this.m_pressBtn.x = (Session.application.size.x * 0.5) - (this.m_pressBtn.width * 0.5);
			this.m_pressBtn.y = Session.application.size.y - 50;
			this.m_pressBtn.embedFonts = true;
			
			this.m_pressBtnFormat = new TextFormat();
			this.m_pressBtnFormat.color = 0xebd320; //0xFFFFFF
			this.m_pressBtnFormat.kerning = true;
			this.m_pressBtnFormat.letterSpacing = 3;
			this.m_pressBtnFormat.size = 12;
			this.m_pressBtnFormat.leading = 8;
			this.m_pressBtnFormat.font = "bulletreign";
			
			this.m_pressBtn.setTextFormat(this.m_pressBtnFormat);
			this.m_winnerScreenLayer.addChild(this.m_pressBtn);
		}
		
		
		/**
		 * update
		 * override
		 */
		override public function update():void {
			this.m_updateControls();
			if (this.m_medalRewarded == false) {
				this.m_medalRewarded = true;
				this.m_awardMedal();
				this.m_winnerMessage();
				this.m_pressAnyButton();
			}
			
		}
		
		
		/**
		 * Accept both control inputs
		 */
		private function m_updateControls():void {
			this.m_controlMove(this.m_controls_one);
			this.m_controlMove(this.m_controls_two);
		}
		
		
		/**
		 * On any button press, display rematch menu
		 */
		private function m_controlMove(control:EvertronControls):void {
			if (Input.keyboard.anyPressed() && this.m_updateControlFlag == true) {
				this.m_updateControlFlag = false;
				this.m_newState();
			}
		}
		
		
		/**
		 * Set new state.
		 */
		private function m_newState():void {
			Session.application.displayState = new RematchMenu(this.m_gamemode);
		}
		
		
		/**
		 * dispose
		 * override
		 */
		override public function dispose():void {
			trace("WinnerScreen dispose");
			this.m_controls_one = null;
			this.m_controls_two = null;
			this.m_gamemode = 0;
			this.m_winner = 0;
			this.m_medalSkin = null;
			this.m_medal = null;
			this.m_medalRewarded = false;
			if (this.m_winnerTextTitle.parent != null) {
				this.m_winnerScreenLayer.removeChild(this.m_winnerTextTitle);
			}
			if (this.m_winnerTextMain.parent != null) {
				this.m_winnerScreenLayer.removeChild(this.m_winnerTextMain);
			}
			this.m_winnerTextTitle = null;
			this.m_winnerTextMain = null;
			this.m_winnerFormatTitle = null;
			this.m_winnerFormatMain = null;
			Session.timer.remove(this.m_controlsTimer);
			this.m_controlsTimer = null;
			this.m_infoscreenMusic = null;
			if (this.m_winnerArt.parent != null) {
				this.m_winnerScreenLayer.removeChild(this.m_winnerArt);
			}
			this.m_winnerArt = null;
			this.m_pressBtnFormat = null;
			if (this.m_pressBtn.parent != null) {
				this.m_winnerScreenLayer.removeChild(this.m_pressBtn);
			}
		}
	}
}