package entity {
	
	//----------------------------------------------------------------------
	// Imports
	//----------------------------------------------------------------------
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.Sprite;
	
	public class Plane extends Sprite {
		
		//------------------------------------------------------------------
		// Properties
		//------------------------------------------------------------------
		private   var plane:MovieClip;
		private   var bullet:Sprite;
		private   var velocity:Number  = 4;
		private   var angle:Number     = 0;
		private const gravity:Number   = 0.04;
		private   var change:Number    = 0;
		private   var direction:String;
		private   var forward:Boolean  = false;
		
		//------------------------------------------------------------------
		// Constructor
		//------------------------------------------------------------------
		public function Plane(x:Number, y:Number) {
			
			this.plane = new TestPlane();
			
			this.plane.scaleX = 0.2;
			this.plane.scaleY = 0.2;
			this.plane.x = x;
			this.plane.y = y;
			
			this.addChild(this.plane);
			
			this.initPlane();
		}
		
		//------------------------------------------------------------------
		// Methods
		//------------------------------------------------------------------
		
		
		/**
		 * initPlane
		 * When this sprite is added to stage, initialize the eventlisteners
		 */
		
		private function initPlane():void {
			this.addEventListener(Event.ADDED_TO_STAGE, this.initEventListeners);
		}
		
		
		/**
		 * initEventListeners
		 * 
		 */
		
		private function initEventListeners(event:Event):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, this.keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, this.keyUp);
			stage.addEventListener(Event.ENTER_FRAME, this.gameLoop);
		}
		
		
		/**
		 * gameLoop
		 * 
		 */
		
		private function gameLoop(event:Event):void {
			this.applyGravity();
			this.movePlane();
		}
		
		// Accelerate/throttle
		private function movePlane():void {
			this.plane.x += Math.cos(this.angle * (Math.PI / 180)) * this.velocity;
			this.plane.y += Math.sin(this.angle * (Math.PI / 180)) * this.velocity;
			this.plane.rotation = this.angle;
			if (this.direction == "up") {
				this.angle += 1.5 * (this.velocity/1.5);
			} else if (this.direction == "down") {
				this.angle -= 1.5 * (this.velocity/1.5);
			}
			
			if (this.forward && this.velocity < 10) {
				this.velocity += 0.5;
			}
			// if - Go out left side
			// else if - Goes out right side
			if(this.plane.x < 0 - (this.plane.width/2)) {
				this.plane.x = stage.stageWidth;
			} else if (this.plane.x > stage.stageWidth) {
				this.plane.x = 0;
			}
		}
		
		private function baseSpeedForward():void {
			this.plane.x += Math.cos(this.angle * (Math.PI / 180)) * this.velocity;
			this.plane.rotation = this.angle;
		}
		
		private function applyGravity():void {
			if (this.plane.y < (stage.stageHeight - this.plane.height + 20)) {
				this.change = (this.gravity * 0.2) + (this.change);
				this.plane.y += change;
			} else if (this.plane.y >= (stage.stageHeight - this.plane.height + 10)) {
				this.velocity = 0;
				this.change = 0;
			}
			this.plane.rotation = this.angle;
		}
		
		/**
		 * keyDown
		 * 
		 */
		
		private function keyDown(event:KeyboardEvent):void {
			//trace("keyDown");
			// W = 87
			// A = 65
			// S = 83
			// D = 68
			// Arrow up = 38
			// Arrow down = 40
			// Arrow left = 37
			// Arrow right = 39

			if(event.keyCode == 87) {
				this.direction = "up";
			}
			
			if(event.keyCode == 83) {
				this.direction = "down";
			}
			
			if(event.keyCode == 38) {
				this.forward = true;
			}
			
			if(event.keyCode == 39) {
				this.bullet = new Bullet(this.plane.x, this.plane.y, this.angle);
				this.addChild(this.bullet);
			}
		}
		
		
		/**
		 * keyUp
		 * 
		 */
		
		private function keyUp(event:KeyboardEvent):void {
			this.direction = null;
			if (event.keyCode == 38) {
				this.forward = false;
				this.velocity = 8;
			}
			
		}
	}
}
