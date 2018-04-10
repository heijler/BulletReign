package se.lnu.stickossdk.fx
{
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	import se.lnu.stickossdk.util.MathUtils;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	En skakeffekt som kan appliceras på 
	 *	DisplayObjectContainers. Effekten hanteras och uppdateras 
	 *	internt av StickOS SDKs inbyggda effekthanterare. 
	 * 
	 *	<p>StickOS SDK erbjuder en fördefinierad effekthanterar 
	 *	som finns tillgänglig via <code>Session.effects</code>. 
	 *	Använd metoden <code>add</code> för att lägga till 
	 *	effekten i effekthanteraren.</p>
	 * 
	 * 	@see se.lnu.stickossdk.fx.Effects
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-17
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Shake extends Effect {
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Innehåller inställningar för hur kraftik skakeffekten 
		 *	ska vara. Egenskapen får sitt värde i konstruktorn.
		 * 
		 *	@default null
		 */
		private var _ammount:Point;
		
		/**
		 *	Innehåller en potentiell slutposition dit objektet 
		 *	ska förflyttas efter att skakeffekten är färdig.
		 * 
		 *	@default null
		 */
		private var _endPosition:Point;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny skakeffekt som förflyttar ett objekt i 
		 *	x- och y-led under en specifik tid. Förflyttningen 
		 *	sker delvis slumpmässigt men alltid utefter ett 
		 *	maximum- och minimumvärde. 
		 * 
		 *	@param	target		Objektet som ska skakas.
		 *	@param	duration	Under hur lång tid objektet ska skakas.
		 *	@param	ammount		Skaktid angivet i millisekunder.
		 *	@param	endPosition	Position att placera objektet när effekten är färdig.
		 */
		public function Shake(target:DisplayObjectContainer, duration:int, ammount:Point = null, endPosition:Point = null) {
			super(target, duration);
			_ammount = ammount || new Point(3, 3);
			_endPosition = endPosition;
		}
		
		//-------------------------------------------------------
		// Override internal methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar skakeffekten och kör den programkod som 
		 *	utgör effekten.
		 * 
		 *	@default void
		 */
		override internal function update():void {
			super.update();
			updatePosition();
		}
		
		/**
		 *	Förbereder objektet för borttagning av skräpsamlaren. 
		 *	Syftet är att deallokera de resurser som objektet 
		 *	använder.
		 * 
		 *	@default void
		 */
		override internal function dispose():void {
			setEndPosition();
			_ammount = null;
			_endPosition = null;
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	Genererar en slumpmässig position på det objekt som 
		 *	skakeffekten är applicerad på. Den slumpmässiga 
		 *	positionen är baserad på _ammount som innehåller 
		 *	information om hur kraftig en skakning får vara.
		 * 
		 *	@default void
		 */
		private function updatePosition():void {
			_target.x = MathUtils.absltx(_ammount.x);
			_target.y = MathUtils.absltx(_ammount.y);
		}
		
		/**
		 *	När en skakeffekt är avslutat återställs objektet 
		 *	till den slutposition, detta förutsätter att en 
		 *	slutposition har angivits i konstruktorn.
		 * 
		 *	@default void
		 */
		private function setEndPosition():void {
			if (_endPosition !== null) {
				_target.x = _endPosition.x;
				_target.y = _endPosition.y;
			}
		}
	}
}