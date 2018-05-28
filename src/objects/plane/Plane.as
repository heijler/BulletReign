package objects.plane {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.Point;
	
	import asset.Plane1GFX;
	import asset.Plane2GFX;
	import asset.Plane3GFX;
	import asset.PlaneHealthGFX;
	
	import entity.MotionEntity;
	import entity.fx.FXManager;
	import entity.fx.Fire;
	import entity.fx.Smoke;
	import entity.fx.Trail;
	
	import managers.BulletManager;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;

	//-----------------------------------------------------------
	// Plane
	// Represents a plane
	//-----------------------------------------------------------
	
	public class Plane extends MotionEntity {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		public const PLANE_DURABILITY:Number = 10;
		
		public var winner:Boolean          = false;
		public var crashed:Boolean         = false;
		public var shotDown:Boolean        = false;
		public var holdingBanner:Boolean   = false;
		public var powerUpActive:Boolean   = false;
		public var noAccelDuration:Boolean = false;
		public var noDamage:Boolean        = false;
		public var noFireCounter:Boolean   = false;
		
		public var health:Number;
		public var wins:int;
		public var activePlayer:int = 0;
		public var tailHitbox:Shape;
		public var bodyHitbox:Shape;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------

		private var m_ph:PlaneHandler;
		private var m_movability:Boolean;
		private var m_healthMeter:MovieClip;
		
		//-----------------------------------------------------------
		// Internal properties
		//-----------------------------------------------------------
		
		internal var _gunCoolingdown:Boolean = true;
		internal var _accelerating:Boolean   = true;
		internal var _recharging:Boolean     = false;
		internal var _facingUp:Boolean       = false;
		
		internal var _skin:MovieClip;		
		internal var _ebulletManager:BulletManager;
		internal var _bulletManager:BulletManager;
		internal var _fxMan:FXManager;
		internal var _scaleFactor:int = 1;
		internal var _smoke:Smoke;
		internal var _fire:Fire;

		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------

		public function Plane(player:int, bulletMngr:BulletManager, ebulletMngr:BulletManager, pos:Point, scaleFactor:int, fxMan:FXManager, movability:Boolean) {
			super();
			this.m_movability    = movability;
			this.activePlayer    = player;
			this._bulletManager  = bulletMngr;
			this._ebulletManager = ebulletMngr;
			this.m_pos           = pos;
			this._fxMan          = fxMan;
			this._scaleFactor    = scaleFactor;
			this.m_ph            = new PlaneHandler(this);
		}
		
		//-----------------------------------------------------------
		// Get / Set
		//-----------------------------------------------------------
		
		/**
		 * Get plane position
		 */
		public function get pos():Point {
			return new Point(this.x, this.y);
		}
		
		
		/**
		 * Get plane angle
		 */
		public function get angle():Number {
			return this._angle;
		}
		
		
		/**
		 * Get plane scaleFactor
		 */
		public function get scaleFactor():int {
			return this._scaleFactor;
		}
		
		
		/**
		 * Get plane velocity
		 */
		public function get velocity():int {
			return this._velocity;
		}
		
		/**
		 * Get plane velocity
		 */
		public function get engineSound():SoundObject {
			return this.m_ph._engineSound;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**	
		 * override
		 */
		override public function init():void {
			this.m_initSkin();
			this.m_initPlaneHealthMeter();
			this.m_setSpawnPosition();
			this.m_ph._initSound();
			this.m_initEffects();
		}
		
		
		/**	
		 * override, gameloop
		 */
		override public function update():void {
			super.update();
			this.applyGravity();
			this.wrapAroundObjects();
			this.m_ph._updateControls();
			this.m_ph._defaultAcceleration();
			this.m_ph._collisionControl();
			this.m_ph._powerUps();
			this.m_ph._rechargeCooldowns();
			this.m_updateEffects();
		}
		
		
		/**
		 * 
		 */
		override public function dispose():void {
			trace("Dispose plane! REMOVE ME WHEN ACTUALLY DISPOSING.");
			// anropa planehandlers dispose här.
		}
		
		
		/**	
		 * Initialize skin
		 */
		private function m_initSkin():void {
			if (activePlayer == 0) {
				this._skin = new Plane1GFX;
				if (BulletReign.rbp == 0) this.m_initAltSkin();
				this.setScale(this._skin, 2, 2);
			} else if (activePlayer == 1) {
				this._skin = new Plane2GFX;
				if (BulletReign.rbp == 1) this.m_initAltSkin();
				this.setScale(this._skin, -2, 2);
			}
			this._skin.cacheAsBitmap = true; // @TODO: Check perf.
			this._skin.gotoAndStop(1);
			this.m_setHitboxes();
			this.addChild(this._skin);
		}
		
		
		/**
		 * 
		 */
		public function m_initAltSkin():void {
			if (BulletReign.rb && (BulletReign.rbp > -1)) {
				this._skin = new Plane3GFX;
			}
		}
		
		
		/**
		 * 
		 */
		private function m_initPlaneHealthMeter():void {
			this.m_healthMeter = new PlaneHealthGFX;
			this.m_healthMeter.y = -7;
			this.m_healthMeter.x = -4;
			this.m_healthMeter.gotoAndStop(11);
			this._skin.addChild(this.m_healthMeter);
		}
		
		
		/**
		 * 
		 */
		public function updateHealthMeter():void {
			this.m_healthMeter.gotoAndStop(Math.floor(this.health + 1));
		}
		
		
		/**
		 * 
		 */
		private function m_setHitboxes():void {
			// Tail hitbox
			this.tailHitbox = new Shape();
			if (BulletReign.debug) this.tailHitbox.graphics.beginFill(0xFF0000);
			this.tailHitbox.graphics.drawRect(-8, -1, 7, 3);
			if (BulletReign.debug) this.tailHitbox.graphics.endFill();
			this._skin.addChild(this.tailHitbox);
			
			// Body hitbox
			this.bodyHitbox = new Shape();
			if (BulletReign.debug) this.bodyHitbox.graphics.beginFill(0xFFFF00);
			this.bodyHitbox.graphics.drawRect(-1, -2, 9, 6);
			if (BulletReign.debug) this.bodyHitbox.graphics.endFill();
			this._skin.addChild(this.bodyHitbox);
		}
		
		
		/**
		 * 
		 */
		private function m_setSpawnPosition():void {
			this.x = this.m_pos.x;
			this.y = this.m_pos.y;
		}
		
		//-----------------------------------------------------------
		// Effects
		//-----------------------------------------------------------

		/**
		 * 
		 */
		private function m_initEffects():void {
			this._smoke = new Smoke(this.parent);
			this._fire = new Fire(this.parent);
		}
		
		
		/**
		 * 
		 */
		private function m_updateEffects():void {
			this._smoke.x = this.x;
			this._smoke.y = this.y;
			this._fire.x  = this.x;
			this._fire.y  = this.y;
		}
		
		
		//-----------------------------------------------------------
		// Events
		//-----------------------------------------------------------
		
		/**
		 * When plane is crashed into the ground
		 */
		public function onCrash(layer:DisplayStateLayer):void {
			this.m_ph.planeMovement(false);
			this.shake(layer, 5);
			this.flicker(this, 500);
			this.m_ph._fallingPlane.stop();
			this._fire.start();
			this._smoke.start(2);
			this.m_ph._crashing.play();
			this.m_ph._crashing.volume = 0.9;
			this.updateHealthMeter();
		}
		
		
		/**
		 * When plane is hit by bullet
		 */
		internal function _onHit():void {
			this.health -= this._ebulletManager.damage;
			this.shake(this._skin, 2);
			this.m_ph._dropBanner();
			this.holdingBanner = false;
			this.updateHealthMeter();
			
			if (this.health < this.PLANE_DURABILITY - (this.PLANE_DURABILITY / 5)) {
				this._smoke.start(this.health);
			}
		}
		
		
		/**
		 * When plane is shot down
		 */
		internal function _onShotDown():void {
			this.shotDown = true;
			this.m_ph._steering = false;
			this.holdingBanner = false;
			this.flicker(this, 500);
			this._fire.start();
			this._onFreeFall();
			
			this.m_ph._screamSound.play();
			this.m_ph._screamSound.volume = 0.9;
			this.m_ph._fallingPlane.play();
			this.m_ph._fallingPlane.volume = 0.9;
		}
		
		
		/**
		 * When plane is falling to ground after being shot down
		 */
		internal function _onFreeFall():void {
			this._velocity = 4;
			this.setGravityFactor(4);
			if (this._facingUp) {
				this.m_ph._reflectAngle();
			} else {
				this.setGravityFactor(6);
			}
			this.m_ph.updateRotation();
		}
		
		
		/**
		 * When plane respawns
		 */
		public function onRespawn(move:Boolean):void {
			if(move == false) {
				this._angle = 0;
				this.x = this.m_pos.x;
				this.y = this.m_pos.y;
				
				this.health = this.PLANE_DURABILITY;
				this.m_ph._accelDuration = this.m_ph.ACCELERATE_DURATION;
				this.m_ph._fireCounter = this.m_ph.FIRE_BURST_SIZE;
				
				this.crashed = false;
				this.m_ph._steering = true;
				this.shotDown = false;
				this.m_ph.planeMovement(true);
				
				this.m_ph.updateRotation();
				this.m_ph._clearNoAccelDuration();
				this.m_ph._clearNoDamage();
				this.m_ph._clearNoFireCounter();
				this.updateHealthMeter();
				this._smoke.stop();
				this._fire.stop();
			}
		}
		
		
		/**
		 * Public wrapper
		 */
		public function reflectAngle():void {
			this.m_ph._reflectAngle();
		}
		
		/**
		 * Public wrapper
		 */
		public function updateRotation():void {
			this.m_ph.updateRotation();
		}
	}
}