package entity.fx {
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	import se.lnu.stickossdk.tween.Tween;
	import se.lnu.stickossdk.tween.easing.Sine;
	import se.lnu.stickossdk.util.MathUtils;
	
	public class Smoke extends Effect {
		
		public var active:Boolean = false;
		
		private var m_active:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var m_inactive:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var m_timer:Timer;
		private var m_target:DisplayObjectContainer;
		private var m_durabilityFactor:Number = 10.0;
		
		private var m_color:Vector.<uint> = new <uint>[0x797979, 0x000000, 0xA2A2A2];		
		
		
		public function Smoke(target:DisplayObjectContainer) {
			super();
			this.m_target = target;
			this.init();
		}
		
		
		public function start(dur:Number):void {
			m_durabilityFactor = dur;
			this.active = true;
		}
		
		
		
		public function stop():void {
			this.active = false;
		}
	
			
		override public function init():void {
			for (var i:int = 0; i < 10; i++) {
				var smoke:MovieClip = new MovieClip();
					smoke.graphics.beginFill(this.m_getRandomColor());
					smoke.graphics.drawRect(this._createJitter(this.x, 2), this._createJitter(this.y, 2), 7, 7);
					smoke.graphics.endFill();
				m_inactive.push(smoke);
			}
			m_initTimer();
			m_createPuff();
			
		}
		
		
		/**
		 * 
		 */
		private function m_getRandomColor():uint {
			var color:uint = m_color[Math.floor(Math.random() * m_color.length)];
			return color;
		}
		
		
		private function m_initTimer():void {
			m_timer = Session.timer.create(MathUtils.randomRange(10 * (this.m_durabilityFactor * 0.8), 20 * (this.m_durabilityFactor * 0.8)), m_onTimerComplete);
		}
		
		
		
		private function m_onTimerComplete():void {
			m_initTimer();
			m_createPuff();
		}
		
		
		
		private function m_createPuff():void {
			if (active == true) {
				var puff:MovieClip = m_getPuff();
				if (puff != null) {
					var s:Number = MathUtils.randomRange(1.0 - (this.m_durabilityFactor / 10), 2.0 - (this.m_durabilityFactor / 10));
					puff.cacheAsBitmap = true;
					puff.alpha = 1.0 / this.m_durabilityFactor;
					puff.scaleX = 0.43;
					puff.scaleY = 0.43;
					puff.x = this.x;
					puff.y = this.y;
					m_target.addChild(puff);
					Session.tweener.add(puff, {
						duration: 300,
						alpha: 0.0,
						x: this.x,
						y: this.y - 50 + (this.m_durabilityFactor * 2),
						scaleX: s,
						scaleY: s,
						rotation: MathUtils.randomRange(0, 45),
						transition: Sine.easeOut,
						onComplete: m_onPuffComplete,
						requestParam: true
					});
				}
			}
		}
		
		
		
		private function m_getPuff():MovieClip {
			if (m_inactive.length > 0) {
				var puff:MovieClip = m_inactive.shift();
				m_active.push(puff);
				
				return puff;
			}
			
			return null;
		}
		
		
		
		private function m_onPuffComplete(tween:Tween, target:MovieClip):void {
			m_returnPuff(target);
			Session.tweener.remove(tween);
			tween = null;
		}
		
		
		private function m_returnPuff(puff:MovieClip):void {
			var a:int = m_active.indexOf(puff);
			var b:int = m_inactive.indexOf(puff);
			
			if (a > -1 && b == -1) {
				m_active.splice(a, 1);
				m_inactive.push(puff);
				
				if (puff.parent != null) {
					puff.parent.removeChild(puff);
				}
			}
		}
		
		
		override public function dispose():void {
			trace("Smoke dispose");
			for (var i:int = 0; i < this.m_active.length; i++) {
				if (this.m_active[i].parent != null) {
					this.m_target.removeChild(this.m_active[i]);
					var puff:Vector.<MovieClip> = this.m_active.splice(this.m_active.indexOf(this.m_active[i]), 1);					
					puff.length = 0;
					puff = null;
				}
			}
			
			for (var j:int = 0; j < this.m_inactive.length; j++) {
				if (this.m_inactive[j].parent != null) {
					this.m_target.removeChild(this.m_inactive[j]);
					var inactivePuff:Vector.<MovieClip> = this.m_inactive.splice(this.m_inactive.indexOf(this.m_inactive[j]), 1);					
					inactivePuff.length = 0;
					inactivePuff = null;
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
			this.m_durabilityFactor = 0;
			this.m_color.length = 0;
			this.m_color = null;
		}
	}
}