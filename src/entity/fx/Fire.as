package entity.fx {
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	import se.lnu.stickossdk.tween.Tween;
	import se.lnu.stickossdk.tween.easing.Sine;
	import se.lnu.stickossdk.util.MathUtils;
	
	//-----------------------------------------------------------
	// Fire
	// Represents a Fire effect that occurs when a plane is shot down
	// Based on Smoke.as by Henrik Andersen @ Medieteknik LNU
	//-----------------------------------------------------------
	
	public class Fire extends Effect {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		public var active:Boolean = false;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private var m_active:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var m_inactive:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var m_timer:Timer;
		private var m_target:DisplayObjectContainer;
		
		private var m_color:Vector.<uint> = new <uint>[0xE35100, 0xeFFA220, 0xEBD320];		
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Fire(target:DisplayObjectContainer) {
			super();
			this.m_target = target;
			this.init();
		}
		
		//-----------------------------------------------------------
		// Public methods
		//-----------------------------------------------------------
		
		/**
		 * Activates the effect
		 * Public facing interface
		 */
		public function start():void {
			this.active = true;
		}
		
		
		/**
		 * Stops the effect
		 * Public facing interface
		 */
		public function stop():void {
			this.active = false;
		}
		
		
		/**
		 * init
		 * Override
		 */
		override public function init():void {
			for (var i:int = 0; i < 10; i++) {
				var fire:MovieClip = new MovieClip();
				fire.graphics.beginFill(this.m_getRandomColor());
				fire.graphics.drawRect(this._createJitter(this.x, 2), this._createJitter(this.y, 2), 8, 8);
				fire.graphics.endFill();
				m_inactive.push(fire);
			}
			m_initTimer();
			m_createFlame();
		}
		
		
		/**
		 * Dispose
		 * override
		 */
		override public function dispose():void {
			trace("Fire dispose");
			for (var i:int = 0; i < this.m_active.length; i++) {
				if (this.m_active[i].parent != null) {
					this.m_target.removeChild(this.m_active[i]);
					var flame:Vector.<MovieClip> = this.m_active.splice(this.m_active.indexOf(this.m_active[i]), 1);					
					flame.length = 0;
					flame = null;
				}
			}
			
			for (var j:int = 0; j < this.m_inactive.length; j++) {
				if (this.m_inactive[j].parent != null) {
					this.m_target.removeChild(this.m_inactive[j]);
					var inactiveFlame:Vector.<MovieClip> = this.m_inactive.splice(this.m_inactive.indexOf(this.m_inactive[j]), 1);					
					inactiveFlame.length = 0;
					inactiveFlame = null;
				}
			}
			
			this.active = false;
			this.m_active.length = 0;
			this.m_active = null;
			this.m_inactive.length = 0;
			this.m_inactive = null;
			Session.timer.remove(this.m_timer);
			this.m_timer = null;
			this.m_target = null;
			this.m_color.length = 0;
			this.m_color = null;
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Retrieve random color from color vector, to make the effect more varied in appearence
		 */
		private function m_getRandomColor():uint {
			var color:uint = m_color[Math.floor(Math.random() * m_color.length)];
			return color;
		}
		
		
		/**
		 * Initializes timer that creates a flame / particle
		 */
		private function m_initTimer():void {
			m_timer = Session.timer.create(MathUtils.randomRange(10, 20), m_onTimerComplete);
		}
		
		
		/**
		 * Call the timer again and create a Flame
		 */
		private function m_onTimerComplete():void {
			m_initTimer();
			m_createFlame();
		}
		
		
		/**
		 * Crates a flame and adds a tween
		 */
		private function m_createFlame():void {
			if (active == true) {
				var flame:MovieClip = m_getFlame();
				if (flame != null) {
					var s:Number = MathUtils.randomRange(0.5, 0.8);
					flame.cacheAsBitmap = true;
					flame.alpha = 1.0;
					flame.scaleX = 1;
					flame.scaleY = 1;
					flame.x = this.x;
					flame.y = this.y;
					m_target.addChild(flame);
					Session.tweener.add(flame, {
						duration: 200,
						x: this._createJitter(this.x, 2),
						y: this._createJitter(this.y - 10, 2),
						scaleX: scaleX - 0.7,
						scaleY: scaleY - 0.7,
						alpha: alpha -= 0.003,
						transition: Sine.easeOut,
						onComplete: m_onFlameComplete,
						requestParam: true
					});
				}
			}
		}
		
		
		/**
		 * Take Flame from inactive return it and add to active list
		 */
		private function m_getFlame():MovieClip {
			if (m_inactive.length > 0) {
				var flame:MovieClip = m_inactive.shift();
				m_active.push(flame);
				
				return flame;
			}
			
			return null;
		}
		
		
		/**
		 * Remove tween when it's completed
		 */
		private function m_onFlameComplete(tween:Tween, target:MovieClip):void {
			m_returnFlame(target);
			Session.tweener.remove(tween);
			tween = null;
		}
		
		
		/**
		 * Return Flame to inactive list and remove from view
		 */
		private function m_returnFlame(flame:MovieClip):void {
			var a:int = m_active.indexOf(flame);
			var b:int = m_inactive.indexOf(flame);
			
			if (a > -1 && b == -1) {
				m_active.splice(a, 1);
				m_inactive.push(flame);
				
				if (flame.parent != null) {
					flame.parent.removeChild(flame);
				}
			}
		}
	}
}
