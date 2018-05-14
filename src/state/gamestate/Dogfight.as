package state.gamestate
{
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;

	public class Dogfight extends Gamestate { 
		
		private var m_currentRound:int;
		
		public function Dogfight() {
			super();
			this._gamemode = 0;
			this.m_flagSwitch(true);
		}
		
		override protected function _updateGamemode():void {
			this.m_resolveRound();
		}
		
		/**
		 * m_resolveRound
		 * Non-crashed player gets a point
		 */
		protected function m_resolveRound():void {
			for(var i:int = 0; i < this.m_planes.length; i++) {
				if(this.m_planes[i].crashed && this.m_planes[i].wonRound == false ) {
					for(var j:int = 0; j < this.m_planes.length; j++) {
						if(this.m_planes[j].crashed == false) {
							this.m_planes[j].wonRound = true;
							trace("asdadgsfdg");
							/*this.m_planes[j].wins++;
							this.m_planes[0].crashed = false;
							this.m_planes[1].crashed = false;
							this.m_incrementWins(this.m_planes[j].m_activePlayer, this.m_planes[j].wins);*/
						}
					}
				}
			}
			/*trace(this.m_roundNumber);
			for (var i:int = 0; i < this.m_planes.length; i++) {
				if (this.m_planes[i].crashed == true) {
					for (var j:int = 0; j < this.m_planes.length; j++) {
						if (this.m_planes[j].crashed == false && this.m_roundFlag == true) {
							if(this.m_planes[j].wins == 0 && this.m_roundNumber == 1) {
								this.m_flagSwitch(false);
								this.m_winSound.play();
								this.m_planes[j].wins = 1;
								this.m_flagSwitch(true);
							}
							if(this.m_planes[j].wins == 0 && this.m_planes[i].wins == 1 && this.m_roundNumber == 2) {
								this.m_flagSwitch(false);
								this.m_winSound.play();
								this.m_planes[j].wins = 1;
								this.m_flagSwitch(true);
							}
							if(this.m_planes[j].wins == 1 && this.m_planes[i].wins == 0 && this.m_roundNumber == 2) {
								this.m_flagSwitch(false);
								this.m_winSound.play();
								this.m_planes[j].wins = 2;
								this.m_flagSwitch(true);
								var timer:Timer = Session.timer.create(3000, this.m_roundOver);
							}
							
							if(this.m_planes[j].wins == 1 && this.m_planes[i].wins == 1 && this.m_currentRound == 3) {
								this.m_flagSwitch(false);
								this.m_winSound.play();
								this.m_planes[j].wins = 2;
								this.m_flagSwitch(true);
								timer = Session.timer.create(3000, this.m_roundOver);
								
							}
							this.m_incrementWins(this.m_planes[j].m_activePlayer, this.m_planes[j].wins);
						}
					}
					
				}
			}*/
		}
		
		private function m_flagSwitch(flag):void {
			this.m_roundFlag = flag;
		}
	}
}