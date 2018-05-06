package entity {
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	import se.lnu.stickossdk.tween.Tween;
	import se.lnu.stickossdk.tween.easing.Quint;
	
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
		
		private const BULLET_ACTIVE_TIME:int = 1300;
		private const AMOUNT_LIMIT:int = 25;
		
		private var m_parent:DisplayObjectContainer;
		private var m_bullets:Vector.<Bullet>;
		private var m_scaleFactor:int;
		
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
		public function add(angle:Number, velocity:Number, pos:Point, scaleFactor:int):void {
			this.m_scaleFactor = scaleFactor;
			
			if (this.m_bullets.length < AMOUNT_LIMIT) {
				var bullet:Bullet = new Bullet(angle, velocity, pos, this.m_scaleFactor);
				this.m_initTimer(bullet);
				this.m_bullets.push(bullet);
				
				if(this.m_bullets.length % 5 == 0) {
					this.m_makeTraceRound(bullet);
				}
				
				this.m_parent.addChild(bullet);
				
			} else {
				var firstBullet:Bullet = this.m_bullets.shift();
				this.removeBullet(firstBullet);
			}
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
		 * @FIX: Make this private
		 */
		public function removeBullet(bullet:Bullet):void {
			var markedBullet:Vector.<Bullet> = this.m_bullets.splice(this.m_bullets.indexOf(bullet), 1);
			if (this.m_parent.contains(markedBullet[0])) {
				this.m_parent.removeChild(markedBullet[0]);
				markedBullet[0] = null;
				markedBullet = null;
			}
		}
		
		/**
		 * removeInactive
		 * @NOTE: If the bullets should be able to wrap the screen this function should be 
		 * rewritten to remove bullets after they have travelled a certain distance instead.
		 * 
		 * @NOTE: This function should consider the size of the bullet, it might matter for bigger bullets
		 */
		public function removeInactiveBullets():void {
			for (var i:int = 0; i < this.m_bullets.length; i++) {
//				trace(this.m_bullets[i].active);
				trace(this.m_bullets[i].alpha);
				if (this.m_bullets[i].active == false) {
					trace("Bullet inactive!");
					this.removeBullet(this.m_bullets[i]);
				}
			}
//			for (var i:int = 0; i < this.m_bullets.length; i++) {
//				if (this.m_bullets[i].x < 0 || this.m_bullets[i].x > Session.application.size.x ||
//					this.m_bullets[i].y < 0 || this.m_bullets[i].y > Session.application.size.y) {
//					
//					this.removeBullet(this.m_bullets[i]);
//					
//				}
//			}
		}
		
		
		/**
		 * checkCollision
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
		
		
		/**
		 * m_initTimer
		 * 
		 */
		private function m_initTimer(bullet:Bullet):void {
			// Fade out
			var tween:Tween = Session.tweener.add(bullet,{
					transition: Quint.easeInOut,
					duration: this.BULLET_ACTIVE_TIME + 300,
					alpha: 0.1
				});
			
			// Make inactive after specified amount of time
			var timer:Timer = Session.timer.create(this.BULLET_ACTIVE_TIME, function():void {
				bullet.active = false;
			});
		}
		
		
		/**
		 * m_makeTraceRound
		 * 
		 */
		private function m_makeTraceRound(bullet:Bullet):void {
			var color:uint; 		
			if (this.m_scaleFactor == 1) {
				color = 0xFF0000;
			} else if (this.m_scaleFactor == -1) {
				color = 0x0000FF;
			}
			bullet.color = color;
		}
	}
}