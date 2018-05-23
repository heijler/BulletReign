package entity.fx {
	
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.geom.Point;
	
	//-----------------------------------------------------------
	// Speckle
	//-----------------------------------------------------------
	
	public class Speckle extends Particle {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------
		
		public function Speckle(pos:Point, angle:Number, alphaDecay:Number=0.03, color:Vector.<uint>=null, gravity:Boolean=true, grow:Boolean=false) {
			super(pos, angle, alphaDecay, color, gravity, grow);
		}
		
		//-----------------------------------------------------------
		// Methods
		//-----------------------------------------------------------
	}
}