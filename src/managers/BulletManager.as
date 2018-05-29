package managers {
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	import objects.Bullet;
	import objects.plane.Plane;
	
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	import se.lnu.stickossdk.tween.Tween;
	import se.lnu.stickossdk.tween.easing.Quint;
	
	//-----------------------------------------------------------
	// BulletManager
	// Represents a planes stack of bullets
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
		private var m_firstBullet:Bullet; 				
		private var m_bullet:Bullet;					
		private var m_bulletTween:Tween;				
		private var m_bulletTweenTimer:Timer;			
		private var m_tracerColor:uint;					
		
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
				this.m_bullet = new Bullet(angle, velocity, pos, this.m_scaleFactor);
				this.m_initTimer(this.m_bullet);
				this.m_bullets.push(this.m_bullet);
				this.m_parent.addChild(this.m_bullet);
				
			} else {
				this.m_firstBullet = this.m_bullets.shift();
				this.removeBullet(this.m_firstBullet);
			}
		}
		
		
		/**
		 * get
		 * returns the bullets in the stash / vector
		 */
		public function getBullets():Vector.<Bullet> {
			return this.m_bullets;
		}
		
		
		/**
		 * removeAll
		 * removes all bullets from bullet stash / vector
		 */
		private function removeAll():void {
			for (var i:int = 0; i < this.m_bullets.length; i++) {
				this.removeBullet(this.m_bullets[i]);
			}
			this.m_bullets.length = 0;
		}
		
		
		/**
		 * removeBullet
		 * removes used bullets from the planes stash / vector of bullets
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
		 * checkCollision
		 * checks for bullets colliding whit hitboxes on plane and removes bullet after collision
		 */
		public function checkCollision(plane:Plane):Boolean {
			var val:Boolean = false;
			for(var i:int = 0; i < this.m_bullets.length; i++) {
				if(plane.tailHitbox.hitTestObject(this.m_bullets[i]) || plane.bodyHitbox.hitTestObject(this.m_bullets[i])) {
					val = true;
					this.removeBullet(this.m_bullets[i]);
				}
			}
			return val;
		}
		
		
		/**
		 * m_initTimer
		 * fades and inactivates bullets
		 */
		private function m_initTimer(bullet:Bullet):void {
			// Fade out
			this.m_bulletTween = Session.tweener.add(bullet,{
					transition: Quint.easeInOut,
					duration: this.BULLET_ACTIVE_TIME + 300,
					alpha: 0.1,
					onComplete: this.m_removeBulletTween,
					requestParam: true
				});
			
			// Make inactive after specified amount of time
			this.m_bulletTweenTimer = Session.timer.create(this.BULLET_ACTIVE_TIME, function():void {
				bullet.active = false;
			});
		}
		
		
		/**
		 * m_removeBulletTween
		 * removing tween and bullet
		 */
		private function m_removeBulletTween(tween, target):void {
			Session.tweener.remove(tween);
			tween = null;
			if (this.m_parent.contains(target)) {
				this.removeBullet(target);				
			}
		}
		
		
		/**
		 * dispose
		 * bulletManager dispose
		 */
		public function dispose():void {
			for(var i:int; i < this.m_bullets.length; i++) {
				if (this.m_bullets[i].parent != null) {
					this.m_parent.removeChild(this.m_bullets[i]);
				}
				this.m_bullets[i].dispose();
				this.m_bullets[i] = null;
			}
			this.m_bullets.length = 0;
			this.m_bullets = null;
			this.m_parent = null;
			this.m_firstBullet = null;
			this.m_scaleFactor = 0;
			this.m_bullet = null;
			this.m_bulletTween = null;
			Session.timer.remove(this.m_bulletTweenTimer);
			this.m_bulletTweenTimer = null;
			this.m_tracerColor = 0;
		}
	}
}