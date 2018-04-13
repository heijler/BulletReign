package entity {
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	//-----------------------------------------------------------
	// BulletManager
	//-----------------------------------------------------------
	
	public class BulletManager {
		
		//-----------------------------------------------------------
		// Properties
		//-----------------------------------------------------------
		private var m_parent:DisplayObjectContainer;
		private  var bullets:Vector.<Bullet>;
		private const AMOUNT_LIMIT:int = 10;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function BulletManager(parent:DisplayObjectContainer) {
			this.m_parent = parent;
			this.bullets = new Vector.<Bullet>;
		}
		
		/**	
		 * add
		 * Limited to AMOUNT_LIMIT;
		 */
		public function add(angle:Number, velocity:Number, pos:Point, owner:int, fireRate:Number):void {
			if (this.bullets.length < AMOUNT_LIMIT) {
				var bullet:Bullet = new Bullet(angle, velocity, pos, owner);
				this.bullets.push(bullet);
				this.m_parent.addChild(bullet);
			} else {
				var firstBullet:Bullet = this.bullets.shift();
				this.removeBullet(firstBullet);
			}
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