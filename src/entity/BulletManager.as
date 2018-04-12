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
		public var bullets:Vector.<Bullet>;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function BulletManager(parent:DisplayObjectContainer) {
			this.m_parent = parent;
			this.bullets = new Vector.<Bullet>;
		}
		
		public function add(angle:Number, velocity:Number):void {
			var bullet:Bullet = new Bullet(angle, velocity);
			this.bullets.push(bullet);
			this.m_parent.addChild(bullet);
		}
		
		public function removeAll():void {
			
		}
	}
}