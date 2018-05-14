package ui {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import assets.DurabilityMeterv3GFX;
	import assets.DurabilityMeterv4GFX;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.media.SoundObject;
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
		private var m_playerVisualDurability:int = 1;
		private var m_playerName:TextField;
		private var m_playerWins:TextField;
//		private var m_playerHealth:TextField;
		private var m_wins:int;
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
		
		override public function set name(value:String):void {
			this.m_playerName.text = value;
		}
		
		public function set win(value:int):void {
			this.m_wins = value;
		}
		
		public function set visualDurability(value:int):void {
			this.m_playerVisualDurability = value;
		}
		
		/**	 
		 * init
		 * override
		 */
		override public function init():void {
			this.m_initPlayerInfo();
			this.m_setSpawn();
		}
		
		
		/**
		 * 
		 */
		override public function dispose():void {
			trace("Dispose HUD! REMOVE ME WHEN ACTUALLY DISPOSING.");
		}
		
		/**	 
		 * m_initScoreCounter
		 * Initialize the Score Counter
		 */
		private function m_initPlayerInfo():void {
			this.m_playerName = new TextField();
			this.m_playerWins= new TextField();
//			this.m_playerHealth = new TextField();
			this.m_textFormat = new TextFormat();
//			this.m_playerHealth.text = "health".toUpperCase();
			this.m_textFormat.size = 7; 
			this.m_textFormat.color = 0x000000; // 0x306141;
			this.m_textFormat.font = "bulletreign";
			this.m_playerWins.text = "wins".toUpperCase() + " " + this.m_wins;
			this.updateWins();
			this.m_durabilityMeter = new DurabilityMeterv3GFX;
			this.m_durabilityMeter = new DurabilityMeterv4GFX; 
			
			
			
			if (m_player == 0) {
				this.m_durabilityMeter = new DurabilityMeterv3GFX; 
				this.m_durabilityMeter.x = Session.application.size.x / 2 - this.m_durabilityMeter.width / 2 - 1;
				this.m_durabilityMeter.y = Session.application.size.y / this.m_durabilityMeter.height / 2 - 12;
				this.m_durabilityMeter.gotoAndStop(11);
				
			} else if (m_player == 1){
				this.m_durabilityMeter = new DurabilityMeterv4GFX;
				this.m_durabilityMeter.x = Session.application.size.x / 2 + this.m_durabilityMeter.width / 2 + 1;
				this.m_durabilityMeter.y = Session.application.size.y / this.m_durabilityMeter.height / 2 - 12;
				this.m_durabilityMeter.gotoAndStop(11);
			}

			this.m_playerName.embedFonts = true;
			this.m_playerName.setTextFormat(this.m_textFormat);
			this.m_playerName.defaultTextFormat = this.m_textFormat;
			addChild(this.m_playerName);
			
			this.m_playerWins.embedFonts = true;
			this.m_playerWins.setTextFormat(this.m_textFormat);
			this.m_playerWins.defaultTextFormat = this.m_textFormat;
			addChild(this.m_playerWins);
			
//			this.m_playerHealth.embedFonts = true;
//			this.m_playerHealth.setTextFormat(this.m_textFormat);
			addChild(this.m_durabilityMeter);
//			addChild(this.m_playerHealth);
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
//			this.m_playerHealth.x = Session.application.size.x / 2 - this.m_playerHealth.width / 2.5;
//			this.m_playerHealth.y = 10;
		}
		
		public function updateWins():void {
			this.m_playerWins.text = "wins".toUpperCase() + " " + this.m_wins;
		}
		
		public function updateHealth():void {
			this.m_durabilityMeter.gotoAndStop(this.m_playerVisualDurability);
		}
	}
}