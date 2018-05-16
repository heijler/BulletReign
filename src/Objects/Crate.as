package Objects {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import asset.CrateArmorGFX;
	import asset.CratePowerGFX;
	import asset.CrateSpeedGFX;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.system.Session;
	import entity.MotionEntity;
	
	//-----------------------------------------------------------
	// Crate
	//-----------------------------------------------------------
	public class Crate extends MotionEntity {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		public var hitGround:Boolean = false;
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_crateClips:Vector.<MovieClip>;
		public var m_type:int;
		
		public function Crate(pos:Point) {
			super();
			this.m_pos = pos;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**	
		 * init
		 * Override.
		 */
		override public function init():void {
			this.m_initSkin();
			this.m_setSpawnPosition();
		}
		
		/**	
		 * m_initSkin
		 * Initialize skin
		 */
		private function m_initSkin():void {
			this.m_crateClips = new Vector.<MovieClip>;
			this.m_crateClips.push(new CrateArmorGFX, new CratePowerGFX, new CrateSpeedGFX);
			this.m_type = Math.floor(Math.random() * this.m_crateClips.length);
			for(var i:int = 0; i < this.m_crateClips.length; i++) {
				this.m_crateClips[i].gotoAndStop(0);
				this._setScale(this.m_crateClips[i], 2, 2);
				this.m_crateClips[i].cacheAsBitmap = true;
			}
			this.addChild(this.m_crateClips[this.m_type]);
			this.m_crateTweenLeft();
		}
		
		/**
		 * m_setSpawnPosition
		 * 
		 */
		private function m_setSpawnPosition():void {
			this.x = this.m_pos.x;
			this.y = this.m_pos.y;
		}
		
		/**	
		 * update
		 * override, gameloop
		 */
		override public function update():void {
			this.applyGravity();
		}
		
		
		/**
		 * 
		 */
		override public function dispose():void {
			trace("Dispose Crate! REMOVE ME WHEN ACTUALLY DISPOSING.");
		}
		
//		private function m_collisionControl():void {
//			this.m_planeCollision();
//			this.m_groundCollision();
//		}
		
		
		/**
		 * m_planeCollision
		 * 
		 */
		private function m_planeCollision():void {
			
		}
		
		
		/**
		 * m_groundCollision
		 * 
		 */
		public function m_groundCollision(layer:DisplayStateLayer):void {
				this.removeGravity();
				this._shake(layer, 5);
				this._flicker(this, 500);
				for(var i:int = 0; i < this.m_crateClips.length; i++) {
					this.m_crateClips[i].play();
				}
		}
		
		/**
		 * m_crateTweenLeft
		 * @IMPROVE: if not enough frames, reduce the tween work by removing x property
		 */
		private function m_crateTweenLeft():void {
			if (this.hitGround == false) {
				for(var i:int = 0; i < this.m_crateClips.length; i++) {
					Session.tweener.add(this.m_crateClips[i], {
						duration: 1300,
						rotation: -25 + (this.y / 20),
						x: 10 - (this.y / 60),
						onComplete: m_crateTweenRight
					});
				}
			}
		}
		
		/**
		 * m_crateTweenRight
		 * @IMPROVE: if not enough frames, reduce the tween work by removing x property
		 */
		private function m_crateTweenRight():void {
			if (this.hitGround == false) {
				for(var i:int = 0; i < this.m_crateClips.length; i++) {
					Session.tweener.add(this.m_crateClips[i], {
						duration: 1300,
						rotation: 25 - (this.y / 20),
						x: -10 + (this.y / 60),
						onComplete: m_crateTweenLeft
					});
				}
			}
		}
	
	}
}