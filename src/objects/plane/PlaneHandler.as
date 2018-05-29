package objects.plane {
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	import entity.fx.Trail;
	
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundMixer;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;

	//-----------------------------------------------------------
	// PlaneHandler
	// Handles the planes sounds, movement, controls, cooldowns
	// and powerups.
	//-----------------------------------------------------------
	internal class PlaneHandler {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_plane:Plane;
		private var m_controls:EvertronControls;
		private var m_onePU:Boolean    = false;
		private var m_fireDelay:Number = FIRE_DELAY;
		private var m_burstSize:int = 5;
		
		//-----------------------------------------------------------
		// Internal properties
		//-----------------------------------------------------------
		
		internal const ACCELERATE_FACTOR:Number = 0.25;
		internal const ACCELERATE_DURATION:int = 80;
		internal const FIRE_BURST_SIZE:int = 20;
		internal const BASE_SPEED:Number = 4;
		internal const FIRE_DELAY:int = 4;
		
		internal var _firing:Boolean  = true;
		internal var _steering:Boolean = true;
		
		internal var _takingFire:Vector.<SoundObject>;
		internal var _engineOverdriveSound:SoundObject;
		internal var _engineNoJuiceSound:SoundObject;
		internal var _fallingPlane:SoundObject;
		internal var _screamSound:SoundObject;
		internal var _engineSound:SoundObject;
		internal var _openFire:SoundObject;
		internal var _crashing:SoundObject;
		
		internal var _accelDuration:int;
		internal var _fireCounter:int;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function PlaneHandler(plane:Plane) {
			this.m_plane           = plane;
			this.m_controls        = new EvertronControls(this.m_plane.activePlayer);
			this._accelDuration    = this.ACCELERATE_DURATION;
			this._fireCounter      = this.FIRE_BURST_SIZE;
			this.m_plane.health    = this.m_plane.PLANE_DURABILITY;
			this.m_plane._velocity = this.BASE_SPEED;
			this.m_plane._angle    = 0;
		}
		
	
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------

		
		/**
		 * 
		 */
		internal function _initSound():void {
			var sc:SoundMixer = Session.sound.soundChannel;
			sc.sources.add("engineoverdrivesound", BulletReign.ENGINEOVERDRIVE_SOUND);
			sc.sources.add("planecrashing",        BulletReign.PLANE_CRASH);
			sc.sources.add("enginesound",          BulletReign.ENGINE_SOUND);
			sc.sources.add("fallingplane",         BulletReign.CRASH_SOUND);
			sc.sources.add("takingFire1",          BulletReign.HIT1_SOUND);
			sc.sources.add("takingFire2",          BulletReign.HIT2_SOUND);
			sc.sources.add("takingFire3",          BulletReign.HIT3_SOUND);
			sc.sources.add("machinegun",           BulletReign.GUN_FIRE);
			sc.sources.add("scream",               BulletReign.SCREAM_SOUND);

			this._engineOverdriveSound = sc.get("engineoverdrivesound");
			this._crashing             = sc.get("planecrashing");
			this._engineSound          = sc.get("enginesound");
			this._fallingPlane         = sc.get("fallingplane");
			this._openFire             = sc.get("machinegun");
			this._screamSound          = sc.get("scream");

			this._takingFire = new Vector.<SoundObject>;
			this._takingFire.push(Session.sound.soundChannel.get("takingFire1"), Session.sound.soundChannel.get("takingFire2"), Session.sound.soundChannel.get("takingFire3"));
		}
		
		
		
		/**	
		 * Update the planes position.
		 * Called in gameloop.
		 * @TODO: Switch case
		 */
		internal function _updateControls():void {
			if (this.m_controls != null) {
				if (Input.keyboard.pressed(this.m_controls.PLAYER_UP))              this.m_anglePlane(1);
				if (Input.keyboard.pressed(this.m_controls.PLAYER_DOWN))            this.m_anglePlane(0);
				if (Input.keyboard.pressed(this.m_controls.PLAYER_BUTTON_1)) {      this.m_fireBullets(); this.m_plane._gunCoolingdown = false; }
				if (Input.keyboard.justReleased(this.m_controls.PLAYER_BUTTON_1))   this.m_plane._gunCoolingdown = true;
				if (Input.keyboard.pressed(this.m_controls.PLAYER_BUTTON_2)) {      this.m_accelerate(); this.m_plane._recharging = false; }
				if (Input.keyboard.justReleased(this.m_controls.PLAYER_BUTTON_2)) { this._engineOverdriveSound.stop(); this.m_plane._recharging = true; }
				if (Input.keyboard.justPressed(this.m_controls.PLAYER_BUTTON_4))    this._dropBanner();
			}
		}
		
		
		/**
		 * owner: 0 or 1
		 * direction: 0 [up], 1 [down]
		 */
		private function m_anglePlane(direction:int):void {
			var newAngle:Number = this.m_plane._velocity / (direction ? 1.5 : 1.15);
			
			if (this._steering && direction == 0) {
				this.m_plane._angle -= newAngle * this.m_plane._scaleFactor;
			} else if (this._steering && direction == 1) {
				this.m_plane._angle += newAngle * this.m_plane._scaleFactor;
			}
			this.updateRotation();
		}
		
		
		/**
		 * Handles angle change when hitting the sky
		 */
		internal function _reflectAngle():void {
			this.m_plane._angle = 360 - this.m_plane._angle;
		}
		
		
		/**
		 * Updates the skins rotation to match the angle.
		 */
		public function updateRotation():void {
			this.m_plane.rotation = this.m_plane._angle;
			if (this.m_plane.rotation * this.m_plane._scaleFactor < 0 ) {
				this.m_plane._facingUp = true;
			} else {
				this.m_plane._facingUp = false;
			}
		}
		
		/**
		 * Checks acceleration and sound playing
		 */
		private function m_accelerate():void {
			if (this._engineOverdriveSound.isPlaying == false && this.m_plane._accelerating) this._engineOverdriveSound.play();
			if (this._steering && this._accelDuration != 0 && this.m_plane._accelerating)    this.m_planeAcceleration();
			if (this._accelDuration <= 0 && this.m_plane._accelerating)                      this.m_stopPlaneAcceleration();
		}
		
		
		/**
		 * Accelerates the plane
		 */
		private function m_planeAcceleration():void {
			var xVel:Number = Math.cos(this.m_plane._angle * (Math.PI / 180)) * (this.m_plane._velocity * 0.25);
			var yVel:Number = Math.sin(this.m_plane._angle * (Math.PI / 180)) * (this.m_plane._velocity * 0.25);
			
			if (this.m_plane.noAccelDuration == false) {
				this._accelDuration--;
			}
			
			this.m_plane.x += xVel * this.m_plane._scaleFactor;
			this.m_plane.y += yVel * this.m_plane._scaleFactor;
			
			this.m_plane._fxMan.add(new Trail(this.m_plane.pos, this.m_plane._angle));
		}
		
		
		/**
		 * Stops the plane from accelerating
		 */
		private function m_stopPlaneAcceleration():void {
			this.m_plane._accelerating = false;
			this._engineOverdriveSound.stop();
			var timer:Timer = Session.timer.create(2000, this.m_resetAcceleration);
		}
		
		
		/**
		 * Resets the possible time of acceleration
		 */
		private function m_resetAcceleration():void {
			if (!this.m_plane._accelerating) {
				this.m_plane._accelerating = true;
				this._accelDuration = this.ACCELERATE_DURATION;
			}
		}
		
		
		/**	
		 * Default acceleration of planes.
		 * Called in gameloop.
		 */
		internal function _defaultAcceleration():void {
			if (this.m_plane.movability) {
				var xVel:Number;
				var yVel:Number;
				if (!this.m_plane.holdingBanner) {
					xVel = Math.cos(this.m_plane._angle * (Math.PI / 180)) * this.m_plane._velocity;
					yVel = Math.sin(this.m_plane._angle * (Math.PI / 180)) * this.m_plane._velocity;
				} else {
					xVel = Math.cos(this.m_plane._angle * (Math.PI / 180)) * (this.m_plane._velocity - 0.7);
					yVel = Math.sin(this.m_plane._angle * (Math.PI / 180)) * (this.m_plane._velocity - 0.7);
				}
				this.m_plane.x += xVel * this.m_plane._scaleFactor;
				this.m_plane.y += yVel * this.m_plane._scaleFactor;
			}
		}
		
		
		/**
		 * Starts and stops plane movement
		 */
		public function planeMovement(move:Boolean):void {
			if(move == false) {
				this.m_plane._velocity = 0;
				this.m_plane.removeGravity();
				this._steering = false;
			} else {
				this.m_plane._velocity = this.BASE_SPEED;
				this.m_plane.applyGravity();
				this.m_plane.setGravityFactor(1);
				this._steering = true;
			}
		}
		
		//-----------------------------------------------------------
		// Cooldowns
		//-----------------------------------------------------------
		
		/**
		 * Called in gameloop.
		 */
		internal function _rechargeCooldowns():void {
			this.m_accelDurationRecharge();
			this.m_gunCoolDown();
		}
		
		
		/**
		 * Recharges possible acceleration
		 */
		private function m_accelDurationRecharge():void {
			if (this.m_plane._recharging == true && this._accelDuration != this.ACCELERATE_DURATION) {
				this._accelDuration++;
			}
		}
		
		
		/**
		 * Coolsdown machinegun when not firing
		 */
		private function m_gunCoolDown():void {
			if (this.m_plane._gunCoolingdown == true && this._fireCounter != this.FIRE_BURST_SIZE) {
				this._fireCounter++;
			}
		}
		
		//-----------------------------------------------------------
		// Firing bullets
		//-----------------------------------------------------------

		/**
		 * Initializes firing prcedure
		 */
		private function m_fireBullets():void {
			if (this._steering) {
				this.m_fireDelay--;
				if (this.m_fireDelay <= 0 && this._fireCounter > 0 && this._firing) {
					this._openFire.play();
					this._openFire.volume = 0.9;
					if(this.m_plane.noFireCounter == false) {
						this._fireCounter--;
					}
					this.m_plane._bulletManager.add(this.m_plane._angle, this.m_plane._velocity, this.m_plane.pos, this.m_plane._scaleFactor);
					this.m_fireDelay = FIRE_DELAY;
				} else if (this._fireCounter <= 0 && this._firing){
					this._firing = false;
					var timer:Timer = Session.timer.create(1000, this.m_resetFireRate);
				}
			}
		}
		
		
		/**
		 * Resets bullets ready to fire
		 */
		private function m_resetFireRate():void {
			if (!this._firing) {
				this._firing = true;
				this._fireCounter = this.FIRE_BURST_SIZE;
			}
		}
		
		//-----------------------------------------------------------
		// Banner drop
		//-----------------------------------------------------------
		
		/**
		 * Drops banner
		 */
		internal function _dropBanner():void {
			if (!this.m_plane.crashed && this.m_plane.holdingBanner) {
				this.m_plane.holdingBanner = false;
			}
		}
		
		
		//-----------------------------------------------------------
		// Collisions
		//-----------------------------------------------------------

		/**	
		 * Called in gameloop.
		 */
		internal function _collisionControl():void {
			this.m_bulletCollision();		
		}
		
		
		/**
		 * Checks if plane hit calls for damage on plane
		 */
		private function m_bulletCollision():void {
			if (this.m_plane.crashed == false && this.m_plane._ebulletManager.checkCollision(m_plane)) {
				this.m_damageControl();
			}
		}
		
		
		/**
		 * m_damageControl
		 * @TODO: Move to gamestate?
		 */
		private function m_damageControl():void {
			if(this.m_plane.noDamage == false) {
				this.m_plane._onHit();
			}
			if(this._takingFire != null) {
				this._takingFire[Math.floor(Math.random() * this._takingFire.length)].play(); //Spelar ett random träffljud
			}
			if (this.m_plane.health <= 0 && this.m_plane.noDamage == false) {
				this.m_plane._onShotDown();
			}
		}
		
		
		//-----------------------------------------------------------
		// Clear Powerup effects
		//-----------------------------------------------------------
		
		/**
		 * Clears Speed Powerup
		 */
		internal function _clearNoAccelDuration():void {
			if (this.m_plane.powerUpActive && this.m_plane.noAccelDuration) {
				this.m_plane._skin.gotoAndStop(1);
				this.m_plane.noAccelDuration = false;
				this.m_plane.powerUpActive = false;
				this.m_onePU = false;
			}
		}
		
		
		/**
		 * Clears Machinegun Powerup
		 */
		internal function _clearNoFireCounter():void {
			if (this.m_plane.powerUpActive && this.m_plane.noFireCounter) {
				this.m_plane._skin.gotoAndStop(1);
				this.m_plane.noFireCounter = false;
				this.m_plane.powerUpActive = false;
				this.m_onePU = false;
			}
		}
		
		
		/**
		 * Clears Armor Powerup
		 */
		internal function _clearNoDamage():void {
			if (this.m_plane.powerUpActive && this.m_plane.noDamage) {
				this.m_plane._skin.gotoAndStop(1);
				this.m_plane.noDamage = false;
				this.m_plane.powerUpActive = false;
				this.m_onePU = false;
			}
		}
		
		
		/**
		 * Called in gameloop.
		 */
		internal function _powerUps():void {
			if (this.m_plane.noDamage && !this.m_onePU) {
				this.m_onePU = true;
				this.m_plane._skin.gotoAndStop(2);
				var timeout1:Timer = Session.timer.create(5000, this._clearNoDamage);
			}
			
			if (this.m_plane.noFireCounter && !this.m_onePU) {
				this.m_onePU = true;
				this.m_plane._skin.gotoAndStop(3);
				var timeout2:Timer = Session.timer.create(5000, this._clearNoFireCounter);
			}
			
			if (this.m_plane.noAccelDuration && !this.m_onePU) {
				this.m_onePU = true;
				this.m_plane._skin.gotoAndStop(4);
				var timeout3:Timer = Session.timer.create(5000, this._clearNoAccelDuration);
			}
		}
		
		
		/**
		 * Disposes
		 */
		public function dispose():void {
			trace("PlaneHandler dispose")
			this.m_plane = null;
			this.m_controls = null;
			this.m_onePU = false;
			this.m_fireDelay = 0;
			this.m_burstSize= 0;
			this._firing = false;
			this._steering = false;
			this._takingFire.length = 0;
			this._takingFire = null;
			this._engineOverdriveSound = null;
			this._engineNoJuiceSound = null;
			this._fallingPlane = null;
			this._screamSound = null;
			this._engineSound = null;
			this._openFire = null;
			this._crashing = null;
			this._accelDuration = 0;
			this._fireCounter = 0;
		}
	}
}