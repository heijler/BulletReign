package ui {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.text.TextField;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	//-----------------------------------------------------------
	// Gamestate
	//-----------------------------------------------------------
	
	public class HUD extends DisplayStateLayerSprite {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		private var scoreCounter:Number;
		private var player:String;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function HUD(bajs) {
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
			this.m_initScoreCounter();
			this.m_initPlayerName();
			//this.m_init
		}
		
		/**	 
		 * m_initScoreCounter
		 * Initialize the Score Counter
		 */
		private function m_initScoreCounter():void {
			var sc:TextField = new TextField();
			sc.y = 50;
			sc.text = "RED GREEN BLUE";
			addChild(sc);
			
		}
		
		/**	 
		 * m_initHUD
		 * Initialize the HUD
		 */
		private function m_initPlayerName():void {
			
		}
	}
}