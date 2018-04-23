package gamemodes
{
	public class Round
	{
		
		private const m_wins:int = 0;
		
		public var m_newWins:int;
		
		public function Round() {
			initWin();
		}
		
		private function initWin():void {
			this.m_newWins = m_wins;
			
			if (m_newWins <= 2) {
				m_newWins++;	
			}
		}
	}
}