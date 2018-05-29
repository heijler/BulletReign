package ui {
	
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import se.lnu.stickossdk.system.Session;
	
	//-----------------------------------------------------------
	// HUDManager
	//-----------------------------------------------------------
	
	public class HUDManager {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const AMOUNT_LIMIT:int = 2;
		private var m_parent:DisplayObjectContainer;
		private var m_huds:Vector.<HUD>;
		
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function HUDManager(parent:DisplayObjectContainer) {
			this.m_parent = parent;
			this.m_huds = new Vector.<HUD>;
			this.m_initHealthLabel();
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		
		/**
		 * Lägger till hud i add
		 */
		public function add(hud:HUD):void {
			if (this.m_huds.length < AMOUNT_LIMIT) {
				this.m_huds.push(hud);
				this.m_parent.addChild(hud);
				hud.name = "Player ".toUpperCase() + this.m_huds.length;
			}
		}
		/**
		 * Inkremera vinster
		 */
		
		public function incrementWins(planeIndex:int, wins):void {
			this.m_huds[planeIndex].win = wins;
			this.m_huds[planeIndex].updateWins();
		}
		
		public function incrementDecrementHealth(planeIndex:int, durability):void {
			this.m_huds[planeIndex].visualDurability = Math.floor(durability + 1);
			this.m_huds[planeIndex].updateHealth();
		}
		
		
		/**
		 * 
		 */
		public function getHuds():Vector.<HUD> {
			return this.m_huds;
		}
		
		
		/**
		 * 
		 */
		private function m_initHealthLabel():void {
			var tf:TextFormat = new TextFormat();
				tf.color = 0x000000;
				tf.kerning = true;
				tf.letterSpacing = 3;
				tf.size = 7;
				tf.font = "bulletreign";
			
			var text:TextField = new TextField();
				text.text = "health";
				text.autoSize = "center";
				text.embedFonts = true;
				text.x = (Session.application.size.x * 0.5) - (text.width * 0.5);
				text.y = 0;
				text.setTextFormat(tf);
			this.m_parent.addChild(text);
		}
	}
}