package objects {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.Point;
	
	import asset.Plane1GFX;
	import asset.Plane2GFX;
	import asset.Plane3GFX;
	
	import entity.MotionEntity;
	import entity.fx.FXManager;
	import entity.fx.Smoke;
	import entity.fx.Fire;
	import entity.fx.Trail;
	
	import managers.BulletManager;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.timer.Timer;

	//-----------------------------------------------------------
	// Plane
	//-----------------------------------------------------------
	
	public class Plane extends MotionEntity {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		public const PLANE_DURABILITY:Number = 10;
		
		public var crashed:Boolean           = false;
		public var shotDown:Boolean          = false;
		public var m_noAccelDuration:Boolean = false; //@TODO: Rename
		public var m_noDamage:Boolean        = false; //@TODO: Rename
		public var m_noFireCounter:Boolean   = false; //@TODO: Rename
		public var holdingBanner:Boolean     = false;
		public var powerUpActive:Boolean     = false;
		public var m_winner:Boolean          = false; //@TODO: Rename
		
		public var health:Number; //@TODO: Rename
		public var m_activePlayer:int = 0; //@TODO: Rename
		
		public var wins:int;
		
		public var m_engineSound:SoundObject; //@TODO: Rename
		
		public var tailHitbox:Shape;
		public var bodyHitbox:Shape;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const ACCELERATE_FACTOR:Number = 0.25;
		private const ACCELERATE_DURATION:int = 80;
		private const FIRE_BURST_SIZE:int = 20;
		private const BASE_SPEED:Number = 4;
		private const FIRE_DELAY:int = 4;
		
		private var m_skin:MovieClip;
		
		private var m_ebulletManager:BulletManager;
		private var m_bulletManager:BulletManager;
		private var m_fxMan:FXManager;
		
		private var m_controls:EvertronControls;
		
		private var m_fireDelay:Number = FIRE_DELAY;
		private var m_scaleFactor:int = 1;
		private var m_burstSize:int = 5;
		private var m_accelDuration:int;
		private var m_fireCounter:int;
		
		private var m_gunCoolingdown:Boolean = true;
		private var m_accelerating:Boolean   = true;
		private var m_recharging:Boolean     = false;
		private var m_facingUp:Boolean       = false;
		private var m_steering:Boolean       = true;
		private var m_firing:Boolean         = true;
		private var m_onePU:Boolean          = false;
		private var m_movability:Boolean;
		
		private var m_takingFire:Vector.<SoundObject>;
		private var m_engineOverdriveSound:SoundObject;
		private var m_engineNoJuiceSound:SoundObject;
		private var m_fallingPlane:SoundObject;
		private var m_screamSound:SoundObject;
		private var m_openFire:SoundObject;
		private var m_crashing:SoundObject;
		
		private var m_smoke:Smoke;
		private var m_fire:Fire;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------

		public function Plane(player:int, bulletMngr:BulletManager, ebulletMngr:BulletManager, pos:Point, scaleFactor:int, fxMan:FXManager, movability:Boolean) {
			super();
			this.m_movability     = movability;
			this.m_activePlayer   = player;
			this.m_bulletManager  = bulletMngr;
			this.m_ebulletManager = ebulletMngr;
			this.m_pos            = pos;
			this.m_scaleFactor    = scaleFactor;
			this.m_fxMan          = fxMan;
			
			this.m_controls      = new EvertronControls(this.m_activePlayer);
			this.m_accelDuration = this.ACCELERATE_DURATION;
			this.health = this.PLANE_DURABILITY;
			this.m_fireCounter   = this.FIRE_BURST_SIZE;
			this._velocity       = this.BASE_SPEED;
			this._angle          = 0;
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
			return this.m_scaleFactor;
		}
		
		
		/**
		 * Get plane velocity
		 */
		public function get velocity():int {
			return this._velocity;
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**	
		 * override
		 */
		override public function init():void {
			this.m_initSkin();
			this.m_setSpawnPosition();
			this.m_initSound();
			this.m_initEffects();
		}
		
		
		/**	
		 * override, gameloop
		 */
		override public function update():void {
			super.update();
			this.applyGravity();
			this.wrapAroundObjects();
			this.m_updateControls();
			this.m_defaultAcceleration();
			this.m_collisionControl();
			this.m_powerUps();
			this.m_rechargeCooldowns();
			this.m_updateEffects();
		}
		
		
		/**
		 * 
		 */
		override public function dispose():void {
			trace("Dispose plane! REMOVE ME WHEN ACTUALLY DISPOSING.");
		}
		
		
		/**	
		 * Initialize skin
		 */
		private function m_initSkin():void {
			if (m_activePlayer == 0) {
				this.m_skin = new Plane1GFX;
				if (BulletReign.rbp == 0) this.m_initAltSkin();
				this._setScale(this.m_skin, 2, 2);
			} else if (m_activePlayer == 1) {
				this.m_skin = new Plane2GFX;
				if (BulletReign.rbp == 1) this.m_initAltSkin();
				this._setScale(this.m_skin, -2, 2);
			}
			this.m_skin.cacheAsBitmap = true; // @TODO: Check perf.
			this.m_skin.gotoAndStop(1);
			this.m_setHitboxes();
			this.addChild(this.m_skin);
		}
		
		
		/**
		 * 
		 */
		public function m_initAltSkin():void {
			if (BulletReign.rb && (BulletReign.rbp > -1)) {
				this.m_skin = new Plane3GFX;
			}
		}
		
		
		/**
		 * 
		 */
		private function m_setHitboxes():void {
			this.tailHitbox = new Shape();
			
			// Debug
			if (BulletReign.debug) this.tailHitbox.graphics.beginFill(0xFF0000);
			
			this.tailHitbox.graphics.drawRect(-8, -1, 7, 3);
			
			// Debug
			if (BulletReign.debug) this.tailHitbox.graphics.endFill();
			
			this.m_skin.addChild(this.tailHitbox);
			
			
			this.bodyHitbox = new Shape();
			
			// Debug
			if (BulletReign.debug) this.bodyHitbox.graphics.beginFill(0xFFFF00);
			
			this.bodyHitbox.graphics.drawRect(-1, -2, 9, 6);
			
			// Debug
			if (BulletReign.debug) this.bodyHitbox.graphics.endFill();
			
			this.m_skin.addChild(this.bodyHitbox);
		}
		
		
		/**
		 * 
		 */
		private function m_setSpawnPosition():void {
			this.x = this.m_pos.x;
			this.y = this.m_pos.y;
		}
		
		
		/**
		 * 
		 */
		private function m_initSound():void {
			Session.sound.soundChannel.sources.add("engineoverdrivesound", BulletReign.ENGINEOVERDRIVE_SOUND);
			Session.sound.soundChannel.sources.add("planecrashing", BulletReign.PLANE_CRASH);
			Session.sound.soundChannel.sources.add("enginesound", BulletReign.ENGINE_SOUND);
			Session.sound.soundChannel.sources.add("fallingplane", BulletReign.CRASH_SOUND);
			Session.sound.soundChannel.sources.add("takingFire1", BulletReign.HIT1_SOUND);
			Session.sound.soundChannel.sources.add("takingFire2", BulletReign.HIT2_SOUND);
			Session.sound.soundChannel.sources.add("takingFire3", BulletReign.HIT3_SOUND);
			Session.sound.soundChannel.sources.add("machinegun", BulletReign.GUN_FIRE);
			Session.sound.soundChannel.sources.add("scream", BulletReign.SCREAM_SOUND);

			this.m_engineOverdriveSound = Session.sound.soundChannel.get("engineoverdrivesound");
			this.m_crashing = Session.sound.soundChannel.get("planecrashing");
			this.m_engineSound = Session.sound.soundChannel.get("enginesound");
			this.m_fallingPlane = Session.sound.soundChannel.get("fallingplane");
			this.m_openFire = Session.sound.soundChannel.get("machinegun");
			this.m_screamSound = Session.sound.soundChannel.get("scream");

			this.m_takingFire = new Vector.<SoundObject>;
			this.m_takingFire.push(Session.sound.soundChannel.get("takingFire1"), Session.sound.soundChannel.get("takingFire2"), Session.sound.soundChannel.get("takingFire3"));
		}
		
		
		/**
		 * 
		 */
		private function m_initEffects():void {
			this.m_smoke = new Smoke(this.parent);
			this.m_fire = new Fire(this.parent);
		}
		
		//-----------------------------------------------------------
		// Plane Controls
		//-----------------------------------------------------------
		
		/**	
		 * Update the planes position.
		 * Called in gameloop.
		 * @TODO: Switch case
		 */
		private function m_updateControls():void {
			if (this.m_controls != null) {
				
				// UP
				if (Input.keyboard.pressed(this.m_controls.PLAYER_UP)) this.m_anglePlane(1);
				
				// DOWN
				if (Input.keyboard.pressed(this.m_controls.PLAYER_DOWN)) this.m_anglePlane(0);
				
				// FIRE
				if (Input.keyboard.pressed(this.m_controls.PLAYER_BUTTON_1)) { this.m_fireBullets(); this.m_gunCoolingdown = false; }
				
				// FIRE RELEASE
				if (Input.keyboard.justReleased(this.m_controls.PLAYER_BUTTON_1)) this.m_gunCoolingdown = true;
				
				// ACCELERATE
				if (Input.keyboard.pressed(this.m_controls.PLAYER_BUTTON_2)) { this.m_accelerate(); this.m_recharging = false; }
				
				// ACCELERATE RELEASE
				if (Input.keyboard.justReleased(this.m_controls.PLAYER_BUTTON_2)) { this.m_engineOverdriveSound.stop(); this.m_recharging = true; }
				
				// DROP BANNER
				if (Input.keyboard.justPressed(this.m_controls.PLAYER_BUTTON_4)) this.m_dropBanner();
			}
		}
		
		
		//-----------------------------------------------------------
		// Plane movement
		//-----------------------------------------------------------
		
		/**
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
			this.updateRotation();
		}
		
		
		/**
		 * 
		 */
		public function reflectAngle():void {
			this._angle = 360 - this._angle;
		}
		
		
		/**
		 * Updates the skins rotation to match the angle.
		 */
		public function updateRotation():void {
			this.rotation = this._angle;
			if (this.rotation * this.m_scaleFactor < 0 ) {
				this.m_facingUp = true;
			} else {
				this.m_facingUp = false;
			}
		}
		
		
		/**
		 * 
		 */
		private function m_accelerate():void {
			if (this.m_accelDuration == this.ACCELERATE_DURATION && this.m_accelerating) this.m_engineOverdriveSound.play();
			if (this.m_steering && this.m_accelDuration != 0 && this.m_accelerating)     this.m_planeAcceleration();
			if (this.m_accelDuration <= 0 && this.m_accelerating)                        this.m_stopPlaneAcceleration();
		}
		
		
		/**
		 * 
		 */
		private function m_planeAcceleration():void {
			var xVel:Number = Math.cos(this._angle * (Math.PI / 180)) * (this._velocity * 0.25);
			var yVel:Number = Math.sin(this._angle * (Math.PI / 180)) * (this._velocity * 0.25);
			
			if (this.m_noAccelDuration == false) {
				this.m_accelDuration--;
			}
			
			this.x += xVel * this.m_scaleFactor;
			this.y += yVel * this.m_scaleFactor;
			
			this.m_fxMan.add(new Trail(this.pos, this._angle));
		}
		
		
		/**
		 * 
		 */
		private function m_stopPlaneAcceleration():void {
			this.m_accelerating = false;
			this.m_engineOverdriveSound.stop();
			var timer:Timer = Session.timer.create(2000, this.m_resetAcceleration);
		}
		
		
		/**
		 * 
		 */
		private function m_resetAcceleration():void {
			if (!this.m_accelerating) {
				this.m_accelerating = true;
				this.m_accelDuration = this.ACCELERATE_DURATION;
			}
		}
		
		
		/**	
		 * Default acceleration of planes.
		 * Called in gameloop.
		 */
		private function m_defaultAcceleration():void {
			var xVel:Number;
			var yVel:Number;
			if (!this.holdingBanner) {
				xVel = Math.cos(this._angle * (Math.PI / 180)) * this._velocity;
				yVel = Math.sin(this._angle * (Math.PI / 180)) * this._velocity;
			} else {
				xVel = Math.cos(this._angle * (Math.PI / 180)) * (this._velocity - 0.7);
				yVel = Math.sin(this._angle * (Math.PI / 180)) * (this._velocity - 0.7);
			}
			
			this.x += xVel * this.m_scaleFactor;
			this.y += yVel * this.m_scaleFactor;
		}
		
		
		/**
		 * 
		 */
		public function planeMovement(move:Boolean):void {
			if(move == false) {
				this._velocity = 0;
				this.removeGravity();
			} else {
				this._velocity = this.BASE_SPEED;
				this.applyGravity();
				this.setGravityFactor(1);
			}
		}
		
		//-----------------------------------------------------------
		// Cooldowns
		//-----------------------------------------------------------
		
		/**
		 * Called in gameloop.
		 */
		private function m_rechargeCooldowns():void {
			this.m_accelDurationRecharge();
			this.m_gunCoolDown();
		}
		
		
		/**
		 * 
		 */
		private function m_accelDurationRecharge():void {
			if (this.m_recharging == true && this.m_accelDuration != this.ACCELERATE_DURATION) {
				this.m_accelDuration++;
			}
		}
		
		
		/**
		 * 
		 */
		private function m_gunCoolDown():void {
			if (this.m_gunCoolingdown == true && this.m_fireCounter != this.FIRE_BURST_SIZE) {
				this.m_fireCounter++;
			}
		}
		
		//-----------------------------------------------------------
		// Firing bullets
		//-----------------------------------------------------------

		/**
		 * 
		 */
		private function m_fireBullets():void {
			if (this.m_steering) {
				this.m_fireDelay--;
				if (this.m_fireDelay <= 0 && this.m_fireCounter > 0 && this.m_firing) {
					this.m_openFire.play();
					this.m_openFire.volume = 0.9;
					if(this.m_noFireCounter == false) {
						this.m_fireCounter--;
					}
					this.m_bulletManager.add(this._angle, this._velocity, this.pos, this.m_scaleFactor);
					this.m_fireDelay = FIRE_DELAY;
				} else if (this.m_fireCounter <= 0 && this.m_firing){
					this.m_firing = false;
					var timer:Timer = Session.timer.create(1000, this.m_resetFireRate);
				}
			}
		}
		
		
		/**
		 * 
		 */
		private function m_resetFireRate():void {
			if (!this.m_firing) {
				this.m_firing = true;
				this.m_fireCounter = this.FIRE_BURST_SIZE;
			}
			
		}
		
		//-----------------------------------------------------------
		// Banner drop
		//-----------------------------------------------------------
		
		/**
		 * 
		 */
		private function m_dropBanner():void {
			if (!this.crashed && this.holdingBanner) {
				this.holdingBanner = false;
			}
		}
		
		
		/**
		 * 
		 */
		private function m_updateEffects():void {
			this.m_smoke.x = this.x;
			this.m_smoke.y = this.y;
			this.m_fire.x  = this.x;
			this.m_fire.y  = this.y;
		}
		
		//-----------------------------------------------------------
		// Collisions
		//-----------------------------------------------------------

		/**	
		 * Called in gameloop.
		 */
		private function m_collisionControl():void {
			this.m_bulletCollision();		
		}
		
		
		/**
		 * 
		 */
		private function m_bulletCollision():void {
			if (this.crashed == false && this.m_ebulletManager.checkCollision(this)) {
				this.m_damageControl();
			}
		}
		
		
		/**
		 * m_damageControl
		 * @TODO: Move to gamestate?
		 */
		private function m_damageControl():void {
			if(this.m_noDamage == false) {
				this.m_onHit();
			}
			if(this.m_takingFire != null) {
				this.m_takingFire[Math.floor(Math.random() * this.m_takingFire.length)].play(); //Spelar ett random träffljud
			}
			if (this.health <= 0 && this.m_noDamage == false) {
				this.m_onShotDown();
			}
		}
		
		
		//-----------------------------------------------------------
		// Clear Powerup effects
		//-----------------------------------------------------------
		
		/**
		 * 
		 */
		private function m_clearNoAccelDuration():void {
			if (powerUpActive && this.m_noAccelDuration) {
				this.m_skin.gotoAndStop(1);
				this.m_noAccelDuration = false;
				this.powerUpActive = false;
				this.m_onePU = false;
			}
		}
		
		
		/**
		 * 
		 */
		private function m_clearNoFireCounter():void {
			if (powerUpActive && this.m_noFireCounter) {
				this.m_skin.gotoAndStop(1);
				this.m_noFireCounter = false;
				this.powerUpActive = false;
				this.m_onePU = false;
			}
		}
		
		
		/**
		 * 
		 */
		private function m_clearNoDamage():void {
			if (powerUpActive && this.m_noDamage) {
				this.m_skin.gotoAndStop(1);
				this.m_noDamage = false;
				this.powerUpActive = false;
				this.m_onePU = false;
			}
		}
		
		
		/**
		 * Called in gameloop.
		 */
		private function m_powerUps():void {
			if (m_noDamage && !this.m_onePU) {
				this.m_onePU = true;
				this.m_skin.gotoAndStop(2);
				var timeout1:Timer = Session.timer.create(5000, this.m_clearNoDamage);
			}
			
			if (m_noFireCounter && !this.m_onePU) {
				this.m_onePU = true;
				this.m_skin.gotoAndStop(3);
				var timeout2:Timer = Session.timer.create(5000, this.m_clearNoFireCounter);
			}
			
			if (m_noAccelDuration && !this.m_onePU) {
				this.m_onePU = true;
				this.m_skin.gotoAndStop(4);
				var timeout3:Timer = Session.timer.create(5000, this.m_clearNoAccelDuration);
			}
		}
		
		//-----------------------------------------------------------
		// Events
		//-----------------------------------------------------------
		
		/**
		 * When plane is crashed into the ground
		 */
		public function onCrash(layer:DisplayStateLayer):void {
			this.planeMovement(false);
			this._shake(layer, 5);
			this._flicker(this, 500);
			this.m_fallingPlane.stop();
			this.m_fire.start();
			this.m_smoke.start(2);
			this.m_crashing.play();
			this.m_crashing.volume = 0.9;
		}
		
		
		/**
		 * When plane is hit by bullet
		 */
		private function m_onHit():void {
			this.health -= this.m_ebulletManager.damage;
			this._shake(this.m_skin, 2);
			this.m_dropBanner();
			this.holdingBanner = false;
			
			if (this.health < this.PLANE_DURABILITY - (this.PLANE_DURABILITY / 5)) {
				this.m_smoke.start(this.health);
			}
		}
		
		
		/**
		 * When plane is shot down
		 */
		private function m_onShotDown():void {
			this.shotDown = true;
			this.m_steering = false;
			this.holdingBanner = false;
			this._flicker(this, 500);
			this.m_fire.start();
			this.m_onFreeFall();
			
			this.m_screamSound.play();
			this.m_screamSound.volume = 0.9;
			this.m_fallingPlane.play();
			this.m_fallingPlane.volume = 0.9;
		}
		
		
		/**
		 * When plane is falling to ground after being shot down
		 */
		private function m_onFreeFall():void {
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
		 * When plane respawns
		 */
		public function m_onRespawn(move:Boolean):void {
			if(move == false) {
				this._angle = 0;
				this.x = this.m_pos.x;
				this.y = this.m_pos.y;
				
				this.health = this.PLANE_DURABILITY;
				this.m_accelDuration = this.ACCELERATE_DURATION;
				this.m_fireCounter = this.FIRE_BURST_SIZE;
				
				this.crashed = false;
				this.m_steering = true;
				this.shotDown = false;
				this.planeMovement(true);
				
				this.updateRotation();
				this.m_clearNoAccelDuration();
				this.m_clearNoDamage();
				this.m_clearNoFireCounter();
				this.m_smoke.stop();
				this.m_fire.stop();
			}
		}	
	}
}