package ui {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;

//???? Kan vara fel.
	
	//-----------------------------------------------------------
	// Gamestate
	//-----------------------------------------------------------
	
	public class HUD extends DisplayStateLayerSprite {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		private var scoreCounter:Number;
		private var m_HUDLayer:DisplayStateLayer;
		private var m_sc:TextField;
		private var m_tf:TextFormat;
		private var m_pos:Point;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function HUD(HUDLayer:DisplayStateLayer, pos:Point) {
			super();
			this.m_HUDLayer = HUDLayer;
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
			this.m_initScoreCounter();
			this.m_setSpawn();
			//this.m_init
		}
		
		/**	 
		 * m_initScoreCounter
		 * Initialize the Score Counter
		 */
		private function m_initScoreCounter():void {
			this.m_sc = new TextField();
			this.m_tf = new TextFormat();
			this.m_tf.color = 0xFFFFFF;
			this.m_tf.font = "Copperplate Gothic";
			this.m_sc.width = 100;
			this.m_sc.height = 100;
			this.m_sc.text = "PLAYER";
			this.m_sc.border = true;
			this.m_sc.setTextFormat(this.m_tf);
			addChild(this.m_sc);
			trace(this.m_sc);
			
		}
		
		/**	 
		 * m_initHUD
		 * Initialize the HUD
		 */
		private function m_setSpawn():void {
			this.x = this.m_pos.x;
			this.y = this.m_pos.y;
		}
	}
}