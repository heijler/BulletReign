package objects {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.Point;
	
	import asset.Plane1GFX;
	import asset.Plane2GFX;
	
	import entity.MotionEntity;
	import entity.fx.FXManager;
	import entity.fx.Particle;
	import entity.fx.Trail;
	
	import managers.BulletManager;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	
	
	//-----------------------------------------------------------
	// Plane
	//-----------------------------------------------------------
	
	public class Plane extends MotionEntity {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		public const PLANE_DURABILITY:Number = 10;
		
		public var crashed:Boolean = false;
		public var m_newDurability:Number; //@TODO: Rename if public, does it need to be public?
		public var m_activePlayer:int = 0; //@TODO: Rename if public, does it need to be public?
		public var m_noAccelDuration:Boolean = false;
		public var m_noDamage:Boolean = false;
		public var m_noFireCounter:Boolean = false;
		public var wins:int;
		public var holdingBanner:Boolean = false;
		public var m_engineSound:SoundObject;
		public var wonRound:Boolean = false;
		public var powerUpActive:Boolean = false;
		public var tailHitbox:Shape;
		public var bodyHitbox:Shape;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const FIRE_DELAY:int = 4; //4
		private const ACCELERATE_FACTOR:Number = 0.25;
		private const ACCELERATE_DURATION:int = 80;
		private const BASE_SPEED:Number = 4; //4
		private const FIRE_BURST_SIZE:int = 20;
		
		private var m_fxMan:FXManager;
		private var m_skin:MovieClip;
		private var m_bulletManager:BulletManager;
		private var m_ebulletManager:BulletManager;
		private var m_controls:EvertronControls;
		private var m_fireDelay:Number = FIRE_DELAY;
		private var m_burstSize:int = 5;
		private var m_scaleFactor:int = 1;
		private var m_steering:Boolean = true;
		private var m_accelDuration:int;
		private var m_accelerating:Boolean = true;
		private var m_fireCounter:int;
		private var m_firing:Boolean = true;
		private var m_openFire:SoundObject;
		private var m_crashing:SoundObject;
		private var m_engineOverdriveSound:SoundObject;
		private var m_fallingPlane:SoundObject;
		private var m_screamSound:SoundObject;
		private var m_takingFire:Vector.<SoundObject>;
		private var m_facingUp:Boolean = false;
		private var m_movability:Boolean;
		private var m_onePU:Boolean = false;

		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		//@TODO type all parameters
		public function Plane(player:int, bulletMngr:BulletManager, ebulletMngr:BulletManager, pos:Point, scaleFactor:int, fxMan:FXManager, movability:Boolean) {
			super();
			this.m_movability = movability;
			this.m_activePlayer = player;
			this.m_bulletManager = bulletMngr;
			this.m_ebulletManager = ebulletMngr;
			this.m_pos = pos;
			this.m_scaleFactor = scaleFactor;
			this.m_fxMan = fxMan;
			
			this.m_newDurability = this.PLANE_DURABILITY;
			this.m_controls = new EvertronControls(this.m_activePlayer);
			this._velocity = this.BASE_SPEED;
			this._angle = 0;
			this.m_accelDuration = this.ACCELERATE_DURATION;
			this.m_fireCounter = this.FIRE_BURST_SIZE;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**	
		 * init
		 * override
		 */
		override public function init():void {
			this.m_initSkin();
			this.m_setSpawnPosition();
			this.m_initSound();
		}
		
		
		/**	
		 * m_initSkin
		 * Initialize skin
		 */
		private function m_initSkin():void {
			if (m_activePlayer == 0) {
				this.m_skin = new Plane1GFX;
				this._setScale(this.m_skin, 2, 2);
			} else if (m_activePlayer == 1) {
				this.m_skin = new Plane2GFX;
				this._setScale(this.m_skin, -2, 2);
			}
			this.m_skin.cacheAsBitmap = true; // @TODO: Check perf.
			this.m_skin.gotoAndStop(1);
			this.m_setHitboxes();
			this.addChild(this.m_skin);
		}
		
		
		/**
		 * m_setHitboxes
		 * 
		 */
		private function m_setHitboxes():void {
			this.tailHitbox = new Shape();
//			this.tailHitbox.graphics.beginFill(0xFF0000);
			this.tailHitbox.graphics.drawRect(-8, -1, 7, 3);
//			this.tailHitbox.graphics.endFill();
			this.m_skin.addChild(this.tailHitbox);
			
			this.bodyHitbox = new Shape();
//			this.bodyHitbox.graphics.beginFill(0xFFFF00);
			this.bodyHitbox.graphics.drawRect(-1, -2, 9, 6);
//			this.bodyHitbox.graphics.endFill();
			this.m_skin.addChild(this.bodyHitbox);
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
		 * m_setFrame
		 * 
		 */
		private function m_setFrame(frame:int):void {
			this.m_skin.gotoAndStop(frame);
		}
		
		
		/**
		 * m_initSound
		 * 
		 */
		private function m_initSound():void {
			Session.sound.soundChannel.sources.add("machinegun", BulletReign.GUN_FIRE);
			Session.sound.soundChannel.sources.add("planecrashing", BulletReign.PLANE_CRASH);
			Session.sound.soundChannel.sources.add("enginesound", BulletReign.ENGINE_SOUND);
			Session.sound.soundChannel.sources.add("engineoverdrivesound", BulletReign.ENGINEOVERDRIVE_SOUND);
			Session.sound.soundChannel.sources.add("fallingplane", BulletReign.CRASH_SOUND);
			Session.sound.soundChannel.sources.add("scream", BulletReign.SCREAM_SOUND);
			Session.sound.soundChannel.sources.add("takingFire1", BulletReign.HIT1_SOUND);
			Session.sound.soundChannel.sources.add("takingFire2", BulletReign.HIT2_SOUND);
			Session.sound.soundChannel.sources.add("takingFire3", BulletReign.HIT3_SOUND);
			this.m_openFire = Session.sound.soundChannel.get("machinegun");
			this.m_crashing = Session.sound.soundChannel.get("planecrashing");
			this.m_engineSound = Session.sound.soundChannel.get("enginesound");
			this.m_engineOverdriveSound = Session.sound.soundChannel.get("engineoverdrivesound");
			this.m_fallingPlane = Session.sound.soundChannel.get("fallingplane");
			this.m_screamSound = Session.sound.soundChannel.get("scream");
			this.m_takingFire = new Vector.<SoundObject>;
			this.m_takingFire.push(Session.sound.soundChannel.get("takingFire1"), Session.sound.soundChannel.get("takingFire2"), Session.sound.soundChannel.get("takingFire3"));
			
		}
		
		
		/**	
		 * update
		 * override, gameloop
		 */
		override public function update():void {
			super.update();
			this.applyGravity();
			this.m_updateControls();
			this.m_defaultSpeed();
			this.m_collisionControl();
			this.m_updatePosition();
			this.m_powerUps();
			
			if (!this.m_steering) {
//				this.m_fxMan.add(new Particle(this.m_getPos(), this._angle, 0.001, new <uint>[0xEBEBEB]));
				this.m_fxMan.add(new Particle(this.m_getPos(), this._angle, 0.01, null, false, true));
				this.m_fxMan.add(new Particle(this.m_getPos(), this._angle, 0.001, new <uint>[0xE35100, 0xeFFA220, 0xEBD320], false));
			}
		}
		
		
		/**
		 * dispose
		 * 
		 */
		override public function dispose():void {
			trace("Dispose plane! REMOVE ME WHEN ACTUALLY DISPOSING.");
		}
		
		
		/**	
		 * m_updateControls  
		 * Update the planes position.
		 * @TODO: Switch case
		 */
		private function m_updateControls():void {
			if (this.m_controls != null) {
				if (Input.keyboard.pressed(this.m_controls.PLAYER_UP)) {
					this.m_anglePlane(1);
				}
				
				if (Input.keyboard.pressed(this.m_controls.PLAYER_DOWN)) {
					this.m_anglePlane(0);
				}
				
				if (Input.keyboard.justPressed(this.m_controls.PLAYER_BUTTON_2)) {
					this.m_engineOverdriveSound.play();
				}
				
				if (Input.keyboard.justReleased(this.m_controls.PLAYER_BUTTON_2)) {
					this.m_engineOverdriveSound.stop();
				} 
				
				if (Input.keyboard.pressed(this.m_controls.PLAYER_BUTTON_2)) {
					this.m_accelerate();
				}
				
				if (Input.keyboard.pressed(this.m_controls.PLAYER_BUTTON_1)) {
					this.m_fireBullets();
				}
				
				if (Input.keyboard.justPressed(this.m_controls.PLAYER_BUTTON_4)) {
					this.m_dropBanner();
				}
			}
		}
		
		
		/**
		 * m_anglePlane
		 * owner: 0 or 1
		 * direction: 0 [up], 1 [down]
		 */
		private function m_anglePlane(direction:int):void {
			var newAngle:Number = this._velocity / (direction ? 1.5 : 1.15);
			
			if (this.m_steering && direction == 0) {
				this._angle -= newAngle * this.m_scaleFactor;
			} else if (this.m_steering && direction == 1) {
				this._angle += newAngle * this.m_scaleFactor;
			}
			
			this._angle %= 360; // resets angle at 360
			if (this._angle < 0) this._angle = this._angle + 360; // Prevents minus angles
			this.updateRotation();
		}
		
		
		/**
		 * reflectAngle
		 * 
		 */
		public function reflectAngle():void {
			this._angle = 360 - this._angle;
			
//			if (this.m_scaleFactor == -1 && this._angle < 180 && this._angle > 360) {
//				this._angle = 360 - this._angle;
//			}
		}
		
		
		/**
		 * updateRotation
		 * Updates the skins rotation to match the angle.
		 */
		public function updateRotation():void {
			this.rotation = this._angle;
			if (this.m_activePlayer == 0 ) {
				if (this._angle > 180 && this._angle < 360) {
					this.m_facingUp	= true;
				} else {
					this.m_facingUp = false;
				}
				
			} else if (this.m_activePlayer == 1) {
				if (this._angle > 0 && this._angle < 180) {
					this.m_facingUp	= true;
				} else {
					this.m_facingUp = false;
				}
			}
		}
		
		
		/**
		 * m_accelerate
		 * 
		 */
		private function m_accelerate():void {
			if (this.m_steering && this.m_accelDuration != 0 && this.m_accelerating) {
				var xVel:Number = Math.cos(this._angle * (Math.PI / 180)) * (this._velocity * 0.25);
				var yVel:Number = Math.sin(this._angle * (Math.PI / 180)) * (this._velocity * 0.25);
				if(this.m_noAccelDuration == false) {
					this.m_accelDuration--;
				}
				this.x += xVel * this.m_scaleFactor;
				this.y += yVel * this.m_scaleFactor;
				this.m_fxMan.add(new Trail(this.m_getPos(), this._angle));			
				
			} else if (this.m_accelDuration <= 0 && this.m_accelerating){
				this.m_accelerating = false;
				this.m_engineOverdriveSound.stop();
				var timer:Timer = Session.timer.create(2000, this.m_resetAcceleration);
			}
		}
		
		
		/**
		 * m_clearNoAccelDuration
		 * 
		 */
		private function m_clearNoAccelDuration():void {
			if(powerUpActive && this.m_noAccelDuration) {
				this.m_setFrame(1);
				this.m_noAccelDuration = false;
				this.powerUpActive = false;
				this.m_onePU = false;
			}
		}
		
		
		/**
		 * m_clearNoFireCounter
		 * 
		 */
		private function m_clearNoFireCounter():void {
			if(powerUpActive && this.m_noFireCounter) {
				this.m_setFrame(1);
				this.m_noFireCounter = false;
				this.powerUpActive = false;
				this.m_onePU = false;
			}
		}
		
		
		/**
		 * m_clearNoDamage
		 * 
		 */
		private function m_clearNoDamage():void {
			if(powerUpActive && this.m_noDamage) {
				this.m_setFrame(1);
				this.m_noDamage = false;
				this.powerUpActive = false;
				this.m_onePU = false;
			}
		}
		
		
		/**
		 * m_powerUps
		 * 
		 */
		private function m_powerUps():void {
			if (m_noDamage && !this.m_onePU) {
				this.m_onePU = true;
				this.m_setFrame(2);
				var timeout1:Timer = Session.timer.create(5000, this.m_clearNoDamage);
				
			}
			
			if (m_noFireCounter && !this.m_onePU) {
				this.m_onePU = true;
				this.m_setFrame(3);
				var timeout2:Timer = Session.timer.create(5000, this.m_clearNoFireCounter);
				
			}
			
			if (m_noAccelDuration && !this.m_onePU) {
				this.m_onePU = true;
				this.m_setFrame(4);
				var timeout3:Timer = Session.timer.create(5000, this.m_clearNoAccelDuration);
			}
		}
		
		
		/**
		 * m_resetAcceleration
		 * 
		 */
		private function m_resetAcceleration():void {
			if (!this.m_accelerating) {
				this.m_accelerating = true;
				this.m_accelDuration = this.ACCELERATE_DURATION;
			}
		}
		
		
		/**
		 * m_fireBullets
		 * 
		 */
		private function m_fireBullets():void {
			if (this.m_steering) {
				this.m_fireDelay--;
				if (this.m_fireDelay <= 0 && this.m_fireCounter > 0 && this.m_firing) {
					this.m_openFire.play();
					if(this.m_noFireCounter == false) {
						this.m_fireCounter--;
					}
					this.m_bulletManager.add(this._angle, this._velocity, this.m_getPos(), this.m_scaleFactor);
					this.m_fireDelay = FIRE_DELAY;
				} else if (this.m_fireCounter <= 0 && this.m_firing){
					this.m_firing = false;
					var timer:Timer = Session.timer.create(1000, this.m_resetFireRate);
				}
			}
		}
		
		
		/**
		 * m_dropBanner
		 * 
		 */
		private function m_dropBanner():void {
			if (!this.crashed && this.holdingBanner) {
				this.holdingBanner = false;
			}
		}
		
		
		/**
		 * m_resetFireRate
		 * 
		 */
		private function m_resetFireRate():void {
			if (!this.m_firing) {
				this.m_firing = true;
				this.m_fireCounter = this.FIRE_BURST_SIZE;
			}
			
		}
		
		
		/**
		 * m_getPos
		 * @TODO: Raname!
		 * @TODO: Move up!
		 */
		public function m_getPos():Point {
			return new Point(this.x, this.y);
		}
		
		
		/**
		 * get angle
		 * @TODO: Move up!
		 */
		public function get angle():Number {
			return this._angle;
		}
		
		
		/**
		 * get scaleFactor
		 * @TODO: Move up!
		 */
		public function get scaleFactor():int {
			return this.m_scaleFactor;
		}
		
		
		/**
		 * get velocity
		 * @TODO: Move up!
		 */
		public function get velocity():int {
			return this._velocity;
		}
		
		
		/**
		 * m_updatePosition
		 * 
		 */
		private function m_updatePosition():void {
			this.wrapAroundObjects();
		}
		
		
		/**	
		 * m_defaultSpeed
		 * Default speed of planes, no acceleration needed to keep in air
		 */
		private function m_defaultSpeed():void {
			var xVel:Number = Math.cos(this._angle * (Math.PI / 180)) * this._velocity;
			var yVel:Number = Math.sin(this._angle * (Math.PI / 180)) * this._velocity;
			
			this.x += xVel * this.m_scaleFactor;
			this.y += yVel * this.m_scaleFactor;
		}
		

		/**	
		 * m_checkCollision
		 * 
		 */
		private function m_collisionControl():void {
			this.m_bulletCollision();		
		}
		
		
		/**
		 * m_bulletCollision
		 * 
		 */
		private function m_bulletCollision():void {
			if (this.crashed == false && this.m_ebulletManager.checkCollision(this)) {
				this.m_damageControl();
			}
		}
		
		
		/**
		 * crash
		 * 
		 */
		public function crash(layer:DisplayStateLayer):void {
			this.movability(false);
			this._shake(layer, 5);
			this._flicker(this, 500);
			this.m_fallingPlane.stop();
			this.m_crashing.play();
		}
		
		
		/**
		 * movability
		 * 
		 */
		public function movability(move:Boolean):void {
			if(move == false) {
				this._velocity = 0;
				this.removeGravity();
			} else {
				this._velocity = this.BASE_SPEED;
				this.applyGravity();
				this.setGravityFactor(1);
			}
		}
		
		
		/**
		 * m_damageControl
		 * @Flytta till gamestate
		 */
		private function m_damageControl():void {
			if(this.m_noDamage == false) {
				this.m_newDurability -= this.m_ebulletManager.damage;
			}
			if(this.m_takingFire != null) {
				this.m_takingFire[Math.floor(Math.random() * this.m_takingFire.length)].play(); //Spelar ett random träffljud
			}
			
			if (this.m_newDurability <= 0 && this.m_noDamage == false) {
//				this.m_noDamage = true;
				this.m_steering = false;
				this.m_freeFall();
				this._flicker(this, 500);
				this.m_screamSound.play();
				this.m_fallingPlane.play();
				this.holdingBanner = false;
			}
		}
		
		
		/**
		 * m_freeFall
		 * @TODO: Move this to MotionEntity
		 */
		private function m_freeFall():void {
			this._velocity = 4;
			this.setGravityFactor(4);
			if (this.m_facingUp) {
				this.reflectAngle();
			} else {
				this.setGravityFactor(6);
			}
		
			this.updateRotation();
		}
		
		
		/**
		 * m_respawn
		 * 
		 */
		public function m_respawn(move:Boolean):void {
			if(move == false) {
				this.x = this.m_pos.x;
				this.y = this.m_pos.y;
				this.m_newDurability = this.PLANE_DURABILITY;
				this.movability(true);
				this.crashed = false;
				this.m_steering = true;
				this._angle = 0;
				this.updateRotation();
			}
		}
		
	}
}