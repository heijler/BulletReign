package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	
	public class Main extends MovieClip {
		
			
		public function Main() {
			var ball:MovieClip = new NewArrow();
			ball.scaleX = 0.5;
			ball.scaleY = 0.5;
			ball.x = ball.y = 50;
			addChild(ball);
			
			var speed:Number = 2;
			var angle:Number = 0;
			var radians:Number;
			var xVel:Number;
			var yVel:Number;
			var gravity:Number = 2;
			var gravityFlag = true;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress_handler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp_handler);
			addEventListener(Event.ENTER_FRAME, onloop, false, 0, true);
			
			function onloop(e:Event):void{
				radians = deg2rad(angle);
			
				xVel = Math.cos(radians) * speed;
				yVel = Math.sin(radians) * speed;
				ball.x += xVel;
				ball.y += yVel;
				ball.rotation = angle;
				gravityOn();
				
				if(ball.x < 0 - ball.width) {
					ball.x = stage.width;
				}
			}
			
			function gravityOn():void {
				if(gravityFlag == true) {
					ball.y += gravity;
				}
			}
			
			function gravityOff():void {
				gravityFlag = false;
			}
			
			function deg2rad(deg:Number):Number{
				return deg * (Math.PI / 180);
			}
			
			function keyPress_handler(event:KeyboardEvent):void{
				
				if(event.keyCode == 87) {
					angle += 1 * speed;
					trace(angle);
				}
				if(event.keyCode == 83) {
					angle -= 1 * speed;
					trace(angle);
				}
				if(event.keyCode == 65) {
					trace('bombdrop');
				}
				if(event.keyCode == 68 && speed < 5) {
					speed += 1;
					trace(speed);
				}
				
			}
			
			function keyUp_handler(event:KeyboardEvent):void {
				gravityFlag = true;
			}
		}
	}
}
