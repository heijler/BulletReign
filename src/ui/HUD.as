package ui {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import assets.DurabilityMeterGFX;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.system.Session;
	
	//-----------------------------------------------------------
	// Gamestate
	//-----------------------------------------------------------
	
	public class HUD extends DisplayStateLayerSprite {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		private var scoreCounter:Number;
		private var m_player:int;
		private var m_playerName:TextField;
		private var m_playerWins:TextField;
		private var m_playerHealth:TextField;
		private var m_playerOneWin:int;
		private var m_playerTwoWin:int;
		private var m_textFormat:TextFormat;
		private var m_pos:Point;
		private var m_durabilityMeter:MovieClip;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function HUD(player:int, pos:Point) {
			super();
			this.m_player = player;
			this.m_pos = pos;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**	 
		 * init
		 * override
		 */
		override public function init():void {
			this.m_initPlayerInfo();
			this.m_setSpawn();
			this.m_updateWins();
			//this.m_init
		}
		
		/**	 
		 * m_initScoreCounter
		 * Initialize the Score Counter
		 */
		private function m_initPlayerInfo():void {
			this.m_playerName = new TextField();
			this.m_playerWins= new TextField();
			this.m_playerHealth = new TextField();
			this.m_textFormat = new TextFormat();
			this.m_playerHealth.text = "HEALTH";
			this.m_textFormat.size = 12; 
			this.m_textFormat.color = 0xFFFFFF;
			this.m_textFormat.font = "adore64";
			
			if (m_player == 0) {
				this.m_playerName.autoSize = TextFieldAutoSize.LEFT;
				this.m_playerName.text = "PLAYER" + " " + this.m_player;
				this.m_playerWins.text = "WINS" + " " + this.m_playerOneWin;
				this.m_durabilityMeter = new DurabilityMeterGFX;
				this.m_durabilityMeter.scaleY = 15;
				this.m_durabilityMeter.scaleX = -10; 
				this.m_durabilityMeter.x = Session.application.width/2 - this.m_durabilityMeter.width/2 - 1;
				this.m_durabilityMeter.y = Session.application.height / this.m_durabilityMeter.height;
				this.m_durabilityMeter.gotoAndStop(1);
				
			} else if (m_player == 1){
				this.m_playerName.autoSize = TextFieldAutoSize.RIGHT;
				this.m_playerName.text = this.m_player + " " + "PLAYER";
				this.m_playerWins.text = this.m_playerTwoWin + " " + "WINS";
				this.m_durabilityMeter = new DurabilityMeterGFX;
				this.m_durabilityMeter.scaleY = 15;
				this.m_durabilityMeter.scaleX = 10;
				this.m_durabilityMeter.x = Session.application.width/2 + this.m_durabilityMeter.width/2 + 1;
				this.m_durabilityMeter.y = Session.application.height / this.m_durabilityMeter.height;
				this.m_durabilityMeter.gotoAndStop(1);
			}
			
			this.m_playerName.embedFonts = true;
			this.m_playerName.setTextFormat(this.m_textFormat);
			addChild(this.m_playerName);
			this.m_playerWins.embedFonts = true;
			this.m_playerWins.setTextFormat(this.m_textFormat);
			addChild(this.m_playerWins);
			this.m_playerHealth.embedFonts = true;
			this.m_playerHealth.setTextFormat(this.m_textFormat);
			addChild(this.m_durabilityMeter);
			addChild(this.m_playerHealth);
		}
		
		/**	 
		 * m_initHUD
		 * Initialize the HUD
		 */
		private function m_setSpawn():void {
			this.m_playerName.x = this.m_pos.x;
			this.m_playerName.y = this.m_pos.y;
			this.m_playerWins.x = this.m_pos.x;
			this.m_playerWins.y = this.m_pos.y +20;
			this.m_playerHealth.x = Session.application.width / 2 - this.m_playerHealth.width / 2.5 ;
			this.m_playerHealth.y = 10;
			trace(Session.application.height);
			trace(Session.application.width);
		}
		
		public function setPlayerName():void {
			//spelare från gameState
		}
		
		public function m_updateWins():void {
			//antal från gameState
		}
		
		public function updateHealth():void {
			//nivå från gameState
		}
	}
}