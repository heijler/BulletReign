package entity {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Bullet extends Sprite {
		private var angle:Number;
		private var velocity:Number = 10;

		public function Bullet(x:Number, y:Number, angle:Number) {
			this.angle = angle;
			var rect:Shape = new Shape();
			rect.graphics.beginFill(0xFF0000);
			rect.graphics.drawRect(x, y, 5, 5);
			rect.graphics.endFill();
			this.addChild(rect);
			this.addEventListener(Event.ENTER_FRAME, move);
		}
		
		private function move(event:Event):void {
			this.x += Math.cos(this.angle * (Math.PI/180)) * velocity;
			this.y += Math.sin(this.angle * (Math.PI/180)) * velocity;
		}
	}
	
}
