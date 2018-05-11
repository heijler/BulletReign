package ui {
	
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.DisplayObjectContainer;
	import asset.HealthCloudGFX;
	import flash.display.MovieClip;
	import se.lnu.stickossdk.system.Session;
	
	//-----------------------------------------------------------
	// PlaneManager
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
			this.m_initHealthCloud();
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		
		/**
		 * 
		 */
		public function add(hud:HUD):void {
			if (this.m_huds.length < AMOUNT_LIMIT) {
				this.m_huds.push(hud);
				this.m_parent.addChild(hud);
				hud.name = "Player ".toUpperCase() + this.m_huds.length;
			}
		}
		
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
		private function m_initHealthCloud():void {
			var skin:MovieClip = new HealthCloudGFX;
				skin.scaleX = 2.5;
				skin.scaleY = 2.5;
				skin.x = Session.application.size.x/2;
				skin.y = 16;
			this.m_parent.addChild(skin);	
		}
	}
}