package se.lnu.stickossdk.fx {
	
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.DisplayObjectContainer;
	
	import se.lnu.stickossdk.system.Session;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	En Flimmereffekt som kan appliceras på 
	 *	DisplayObjectContainer-objekt. Effekten hanteras och 
	 *	uppdateras internt av StickOS SDKs inbyggda 
	 *	effekthanterare.
	 * 
	 *	<p>StickOS SDK erbjuder en fördefinierad effekthanterar 
	 *	som finns tillgänglig via <code>Session.effects</code>. 
	 *	Använd metoden <code>add</code> för att lägga till 
	 *	effekten i effekthanteraren.</p>
	 * 
	 *	@see se.lnu.stickossdk.fx.Effects
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-17
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Flicker extends Effect {
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Den tid det grafiska objektet är synligt respektive 
		 *	dolt. Tiden anges i millisekunder. Standardtiden för 
		 *	ett anrop är 36 millisekunder, vilket ungefär 
		 *	motsvarar två bildrutor då 
		 *	bilduppdateringshastigheten är 60 bildrutor per 
		 *	sekund. Standardvärdet tilldelas i konstruktorn.
		 * 
		 *	@default 0
		 */
		private var _interval:int;
		
		/**
		 *	Används för att beräkna tiden som förflutit mellan 
		 *	synlig och osynlig (flimmer).
		 * 
		 *	@default null
		 */
		private var _intervalElapsed:int = 0;
		
		/**
		 *	Innehåller det grafiska objektets standardtillstånd, 
		 *	dvs om objektet var synligt eller osynligt när 
		 *	effekten påbörjades. Standardvärdet sätts i 
		 *	konstruktorn.
		 * 
		 *	@default false
		 */
		private var _originalState:Boolean;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny flimmereffekt. Effekten gör att ett 
		 *	grafiskt objekt flimrar under en förbestämd tid. 
		 *	Effekten kan exempelvis användas för att indikera 
		 *	att en spelare är odödlig.
		 * 
		 *	@param	target		Objektet som ska skakas.
		 *	@param	duration	Under hur lång tid objektet ska skakas.
		 *	@param	interval	Intervall för flimmer.
		 *	@param	isVisible	Objektet är ett synligt objekt.
		 */
		public function Flicker(target:DisplayObjectContainer, duration:int, interval:int = 36, isVisible:Boolean = true) {
			super(target, duration);
			_interval = interval;
			_originalState = isVisible;
		}
		
		//-------------------------------------------------------
		// Override internal methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar effekten.
		 * 
		 *	@default void
		 */
		override internal function update():void {
			//TODO: DENNA KAN KOMMENTERAS BÄTTRE.
			super.update();
			updateInterval();
		}
		
		/**
		 *	Återställer det grafiska objektets tillstånd till 
		 *	vad det var när flimmereffekten först påbörjades.
		 * 
		 *	@default void
		 */
		override internal function dispose():void {
			_target.visible = _originalState;
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar intervallet för flimmereffekten och 
		 *	döljer/visar objektet beroende på hur mycket tid som 
		 *	har förflutit.
		 * 
		 *	@default void
		 */
		private function updateInterval():void {
			_intervalElapsed += Session.application.time.timeSinceLastFrame;
			if (_intervalElapsed > _interval) {
				_intervalElapsed = 0;
				_target.visible = !_target.visible;
			}
		}
	}
}