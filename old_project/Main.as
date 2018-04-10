package {
	
	//----------------------------------------------------------------------
	// Imports
	//----------------------------------------------------------------------
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import entity.Plane;
	
	
	public class Main extends MovieClip {
		
		//------------------------------------------------------------------
		// Properties
		//------------------------------------------------------------------
		/*private var plane:MovieClip;
		private var speed:Number = 8;
		private var angle:Number = 0;
		private const gravity:Number = 0.5;
		private var gravityFlag:Boolean = true;*/
		
		//------------------------------------------------------------------
		// Constructor
		//------------------------------------------------------------------
		
		public function Main() {
			/*this.plane = new NewArrow();
			this.plane.scaleX = 0.17;
			this.plane.scaleY = 0.17;
			this.plane.x = 50;
			this.plane.y = 50;
			addChild(this.plane);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, this.keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, this.keyUpHandler);
			addEventListener(Event.ENTER_FRAME, this.onLoop, false, 0, true);*/
			
			this.addChild(new Plane(0, 250));

		}
		
		//------------------------------------------------------------------
		// Methods
		//------------------------------------------------------------------
		
		///**
		// * onLoop
		// */
		//
		//private function onLoop(event:Event):void{
		//	var radians:Number = deg2rad(this.angle);
		//
		//	var xVel:Number = Math.cos(radians) * this.speed;
		//	var yVel:Number = Math.sin(radians) * this.speed;
		//	this.plane.x += xVel;
		//	this.plane.y += yVel;
		//	this.plane.rotation = this.angle;
		//	this.gravityOn();
		//	
		//	// if - Go out left side
		//	// else if - Goes out right side
		//	if(this.plane.x < 0 - (this.plane.width/2)) {
		//		this.plane.x = stage.stageWidth;
		//	} else if (this.plane.x > stage.stageWidth) {
		//		this.plane.x = 0;
		//	}
		//}
		//
		//
		///**
		// * gravityOn
		// */
		//
		//private function gravityOn():void {
		//	if(this.gravityFlag == true) {
		//		this.plane.y += this.gravity;
		//	}
		//}
		//
		//
		///**
		// * gravityOff
		// */
		//
		//private function gravityOff():void {
		//	this.gravityFlag = false;
		//}
		//
		//
		///**
		// * deg2rad
		// */
		//
		//private function deg2rad(deg:Number):Number{
		//	return deg * (Math.PI / 180);
		//}
		//
		//
		///**
		// * keyDownHandler
		// */
		//
		//private function keyDownHandler(event:KeyboardEvent):void{
		//	// W = 87
		//	// A = 65
		//	// S = 83
		//	// D = 68
		//	// Arrow up = 38
		//	// Arrow down = 40
		//	// Arrow left = 37
		//	// Arrow right = 39
		//	
		//	// W
		//	if(event.keyCode == 87) {
		//		angle += 1.5 * (speed/1.5);
		//		trace("W angle:", angle);
		//	}
		//	
		//	// S
		//	if(event.keyCode == 83) {
		//		angle -= 1.5 * (speed/1.5);
		//		trace("S angle:", angle);
		//	}
		//	
		//	// A
		//	if(event.keyCode == 65) {
		//		trace("A:", 'bombdrop');
		//	}
		//	
		//	// D
		//	if(event.keyCode == 68 && speed < 13) {
		//		speed += 1;
		//		trace("D speed:", speed);
		//	}
		//	
		//}
		//
		//
		///**
		// * keyUpHandler
		// */
		//
		//private function keyUpHandler(event:KeyboardEvent):void {
		//	gravityFlag = true;
		//}
	}
}
