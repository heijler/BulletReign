package state.gamestate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	
	//-----------------------------------------------------------
	// HowToPlay
	//-----------------------------------------------------------
	public class HowToPlay extends Gamestate {
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_backgroundLayer:DisplayStateLayer;
		
		public function HowToPlay() {
			super();
			this._gamemode = 2;
		}
		
		override protected function _initGamemode():void {
			this.m_initLayers();
		}
		
		private function m_initLayers():void {
			this.m_backgroundLayer = this.layers.add("background");

		}
	}
}