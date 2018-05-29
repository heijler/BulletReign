package objects {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import asset.CrateArmorGFX;
	import asset.CratePowerGFX;
	import asset.CrateSpeedGFX;
	
	import entity.MotionEntity;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.system.Session;
	
	//-----------------------------------------------------------
	// Crate
	// Handles a crate
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
				this.setScale(this.m_crateClips[i], 2, 2);
				this.m_crateClips[i].cacheAsBitmap = true;
			}
			this.addChild(this.m_crateClips[this.m_type]);
			this.m_crateTweenLeft();
		}
		
		/**
		 * Set crate spawnposition
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
		 * Disposes
		 */
		override public function dispose():void {
			trace("Crate dispose");
			this.hitGround = false;
			for (var i:int = 0; i < this.m_crateClips.length; i++) {
				if (this.m_crateClips[i].parent != null) {
					this.removeChild(this.m_crateClips[i]);
				}
			}
			this.m_crateClips.length = 0;
			this.m_type = 0;
		}
		
		
		/**
		 * When crate collides with ground
		 * 
		 */
		public function m_onGroundCollision(layer:DisplayStateLayer):void {
			this.removeGravity();
			this.shake(layer, 5);
			this.flicker(this, 500);
			for(var i:int = 0; i < this.m_crateClips.length; i++) {
				this.m_crateClips[i].play();
			}
		}
		
		
		/**
		 * @IMPROVE: if not enough frames, reduce the tween work by removing x property
		 * Crate swinging from right to left
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
		 * @IMPROVE: if not enough frames, reduce the tween work by removing x property
		 * Crate swinging from left to right
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