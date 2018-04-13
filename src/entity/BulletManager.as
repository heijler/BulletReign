package entity {
	import flash.display.DisplayObjectContainer;
	
	//-----------------------------------------------------------
	// BulletManager
	//-----------------------------------------------------------
	
	public class BulletManager {
		
		//-----------------------------------------------------------
		// Properties
		//-----------------------------------------------------------
		private var m_parent:DisplayObjectContainer;
		private  var bullets:Vector.<Bullet>;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function BulletManager(parent:DisplayObjectContainer) {
			this.m_parent = parent;
			this.bullets = new Vector.<Bullet>;
		}
		
		/**	
		 * add
		 * 
		 */
		public function add(angle:Number, velocity:Number, x:int, y:int, owner:int):void {
			var bullet:Bullet = new Bullet(angle, velocity, x, y, owner);
			this.bullets.push(bullet);
			this.m_parent.addChild(bullet);
		}
		
		/**
		 * get
		 * Get bullets vector
		 */
		public function get():Vector.<Bullet> {
			return this.bullets;
		}
		
		/**
		 * removeAll
		 * 
		 */
		private function removeAll():void {
			for (var i:int = 0; i < bullets.length; i++) {
				this.removeBullet(bullets[i]);
			}
			bullets.length = 0;
		}
		
		/**
		 * removeBullet
		 * 
		 */
		private function removeBullet(bullet:Bullet):void {
			this.m_parent.removeChild(bullet);
			bullet = null;
		}
		
		
	}
}