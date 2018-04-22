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
		// Getters/Setters
		//-----------------------------------------------------------
		
		public function get damage():Number {
			return this.m_bullets[0].BULLET_DAMAGE;
		}
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_parent:DisplayObjectContainer;
		private  var m_bullets:Vector.<Bullet>;
		private const AMOUNT_LIMIT:int = 15;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function BulletManager(parent:DisplayObjectContainer) {
			this.m_parent = parent;
			this.m_bullets = new Vector.<Bullet>;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**	
		 * add
		 * Limited to AMOUNT_LIMIT;
		 */
		public function add(angle:Number, velocity:Number, pos:Point, owner:int):void {
			if (this.m_bullets.length < AMOUNT_LIMIT) {
				var bullet:Bullet = new Bullet(angle, velocity, pos, owner);
				this.m_bullets.push(bullet);
				this.m_parent.addChild(bullet);
			} else {
				var firstBullet:Bullet = this.m_bullets.shift();
				this.removeBullet(firstBullet);
			}
			//this.removeInactive();
		}
		
		/**
		 * get
		 * Get bullets vector
		 * @TODO: Rename, dumt namn
		 */
		public function getBullets():Vector.<Bullet> {
			return this.m_bullets;
		}
		
		/**
		 * removeAll
		 * 
		 */
		private function removeAll():void {
			for (var i:int = 0; i < this.m_bullets.length; i++) {
				this.removeBullet(this.m_bullets[i]);
			}
			this.m_bullets.length = 0;
		}
		
		/**
		 * removeBullet
		 * 
		 */
		public function removeBullet(bullet:Bullet):void {
			if (this.m_parent.contains(bullet)) {
				this.m_parent.removeChild(bullet);
				bullet = null;
			}
			
		}
		
		/**
		 * removeInactive
		 * 
		 */
		public function removeInactive():void {
			for (var i:int = 0; i < this.m_bullets.length; i++) {
				if (!this.isActive(this.m_bullets[i])) {
					this.removeBullet(this.m_bullets[i]);
				}
			}
		}
		
		/**
		 * isActive
		 * Checks if bullet is flagged as active or not
		 */
		public function isActive(bullet:Bullet):Boolean {
			return bullet.active;
		}
		
		
		/**
		 * 
		 */
		public function checkCollision(plane:Plane):Boolean {
			var val:Boolean = false;
			for(var i:int = 0; i < this.m_bullets.length; i++) {
				if(plane.hitTestObject(this.m_bullets[i])) {
					val = true;
					this.removeBullet(this.m_bullets[i]);
				}
			}
			return val;
		}
		
		
	}
}