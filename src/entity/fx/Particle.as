package entity.fx {
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	//-----------------------------------------------------------
	// Particle
	//-----------------------------------------------------------
	
	public class Particle extends Effect {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		private const PARTICLE_SIZE:int = 4;
		private var m_alphaDecay:Number = 0.03;
		private var m_skin:Sprite;
		private var m_color:Vector.<uint> = new <uint>[0x797979, 0x000000, 0xA2A2A2];
		private var m_gravity:Boolean = true;
		private var m_grow:Boolean = false;
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		public function Particle(pos:Point, angle:Number, alphaDecay:Number = 0.03, color:Vector.<uint> = null, gravity:Boolean = true, grow:Boolean = false) {
			super();
			this.m_pos = pos;
			this._angle = angle;
			this.m_alphaDecay = alphaDecay;
			this.m_gravity = gravity;
			this.m_grow = grow;
			if (color != null) {
				this.m_color = color;
			}
			
			
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
		
		/**
		 * 
		 * 
		 */
		override public function init():void {
			this.m_initSkin();
			this.m_setSpawnPosition();
		}
		
		
		/**
		 * 
		 */
		private function m_initSkin():void {
			this.m_skin = new Sprite();
			this.m_skin.graphics.beginFill(this.m_getRandomColor());
			this.m_skin.graphics.drawRect(-this.PARTICLE_SIZE * 0.5, -this.PARTICLE_SIZE * 0.5, this.PARTICLE_SIZE, this.PARTICLE_SIZE);
			this.m_skin.graphics.endFill();
			this._setScale(this.m_skin);
			this.addChild(this.m_skin);
			this.alpha = 0.7; // Starting alpha
		}
		
		
		/**
		 * 
		 */
		private function m_getRandomColor():uint {
			var color:uint = m_color[Math.floor(Math.random() * m_color.length)];
			return color;
		}
		
		
		/**
		 * 
		 */
		override public function update():void {
			this.applyGravity(m_gravity);
			this.alpha -= this.m_alphaDecay;
			if (m_grow) {
				this.width += 0.1; // 0.2
				this.height += 0.1; // 0.3
			} else {
				this.width -= 0.3; // @TODO: magic numbers
				this.height -= 0.3; // @TODO: magic numbers
			}
//			this.y -= 0.2;
			this.x += Math.random();
			this.y += Math.random();
		}
		
		
		/**
		 * 
		 */
		private function m_setSpawnPosition():void {
			this.x = this._createJitter(this.m_pos.x, 2);
			this.y = this._createJitter(this.m_pos.y, 2);
			this.rotation = this._angle;
		}
		
		
		/**
		 * 
		 */
		override public function dispose():void {
			trace("Dispose Particle! REMOVE ME WHEN ACTUALLY DISPOSING.");
		}
	}
}