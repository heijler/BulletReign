package state.gamestate {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	
	//-----------------------------------------------------------
	// Dogfight
	// Represents the Dogfight gamemode
	//-----------------------------------------------------------

	public class Dogfight extends Gamestate { 
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_callWinner:Boolean = false;
		private var m_winFlag:Boolean = false;
		private var m_respawnNowTimer:Timer;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Dogfight() {
			super();
			this._gamemode = 0;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**
		 * Method that is run on gameloop, overrides the method in the parentclass
		 */
		override protected function _updateGamemode():void {
			this.m_resolveRound();
			this.m_resolveGame();
		}
		
		
		/**
		 * Non-crashed player gets a point
		 */
		private function m_resolveRound():void {
			for(var i:int = 0; i < this._planes.length; i++) {
				if(this._planes[i].crashed) {
					for(var j:int = 0; j < this._planes.length; j++) {
						if(this._planes[j].crashed == false) {							
							if(this.m_winFlag == false) {
								this._winSound.play();
								this._winSound.volume = 0.2;
								this._planes[j].wins++;
								this.m_scoreMessage(this._planes[j].activePlayer);
								this.m_winFlag = true;
								this._incrementWins(this._planes[j].activePlayer, this._planes[j].wins);
								this.m_respawnNowTimer = Session.timer.create(3000, this.m_respawnNow);
							}
						}
					}
				}
				if(this._planes[0].crashed == true && this._planes[1].crashed == true && this.m_winFlag == false) {
					this.m_respawnNowTimer = Session.timer.create(3000, this.m_respawnNow);
					this.m_winFlag = true;
				}
			}
		}
		
		
		/**
		 * Check if match should end
		 */
		private function m_resolveGame():void {
			for(var i:int = 0; i < this._planes.length; i++) {
				if(this._planes[i].wins == this._winLimit) {
					this._planes[i].winner = true;
					if(this.m_callWinner == false){
						this._scoreMessageRemove();
						this._matchOver(this._planes[i].activePlayer);
					}
					this.m_callWinner = true;
				}
			}
		}
		
		
		/**
		 * Wrapper function
		 */
		override protected function m_respawnNow():void {
			super.m_respawnNow();
			this.m_winFlag = false;
		}
		
		
		/**
		 * Dispose Dogfight
		 */
		override public function dispose():void {
			trace("Dogfight dispose");
			super.dispose();
			this.m_winFlag = false;
			this.m_callWinner = false;
			Session.timer.remove(this.m_respawnNowTimer);
			this.m_respawnNowTimer = null;
		}
		
	}
}