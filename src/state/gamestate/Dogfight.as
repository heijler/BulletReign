package state.gamestate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	
	//-----------------------------------------------------------
	// Dogfight
	//-----------------------------------------------------------

	public class Dogfight extends Gamestate { 
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_currentRound:int;
		private var m_winFlag:Boolean = false;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Dogfight() {
			super();
			this._gamemode = 0;
			this.m_flagSwitch(true);
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**
		 * _updateGamemode
		 * 
		 */
		override protected function _updateGamemode():void {
			this.m_resolveRound();
			this.m_resolveGame();
		}
		
		
		/**
		 * m_resolveRound
		 * Non-crashed player gets a point
		 */
		private function m_resolveRound():void {
			for(var i:int = 0; i < this.m_planes.length; i++) {
				if(this.m_planes[i].crashed) {
					for(var j:int = 0; j < this.m_planes.length; j++) {
						if(this.m_planes[j].crashed == false) {							
							if(this.m_winFlag == false) {
								this.m_winSound.play();
								this.m_planes[j].wins++;
								this.m_winFlag = true;
								this.m_incrementWins(this.m_planes[j].m_activePlayer, this.m_planes[j].wins);
								var timer:Timer = Session.timer.create(3000, this.m_respawnNow);
							}
						}
					}
				}
				if(this.m_planes[0].crashed == true && this.m_planes[1].crashed == true && this.m_winFlag == false) {
					var dimer:Timer = Session.timer.create(3000, this.m_respawnNow);
					this.m_winFlag = true;
				}
			}
		}
		
		
		/**
		 * m_resolveGame
		 * 
		 */
		private function m_resolveGame():void {
			for(var i:int = 0; i < this.m_planes.length; i++) {
				if(this.m_planes[i].wins == this._winLimit) {
					var timer:Timer = Session.timer.create(3000, this.m_matchOver);
				}
			}
		}
		
		
		/**
		 * m_respawnNow
		 * 
		 */
		override protected function m_respawnNow():void {
			super.m_respawnNow();
			this.m_winFlag = false;
		}
		
		
		/**
		 * m_flagSwitch
		 */
		private function m_flagSwitch(flag):void {
			this.m_roundFlag = flag;
		}
	}
}