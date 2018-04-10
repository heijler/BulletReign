package se.lnu.stickossdk.fx
{
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.DisplayObjectContainer;
	
	import se.lnu.stickossdk.system.Session;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Detta är en abstrakt basklass som ligger till grund för 
	 *	StickOS SDK-baserade effekter. Klassen erbjuder ett 
	 *	programmeringsbart gränssnitt för att skapa effekter som 
	 *	fortlöper över tid.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-17
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Effect {
		
		//-------------------------------------------------------
		// Internal properties
		//-------------------------------------------------------
		
		/**
		 *	Intern flagga som används för att tala om för 
		 *	effekthanteraren när denna effekt är slutförd. När 
		 *	flaggan sätts till <code>true</code> kommer 
		 *	effekthanteraren ta bort och deallokera objektet.
		 * 
		 *	@default false
		 * 
		 *	@see se.lnu.stickos.fx.Effects
		 */
		internal var complete:Boolean;
		
		//-------------------------------------------------------
		// Proteted properties
		//-------------------------------------------------------
		
		/**
		 *	Det grafiska objekt som effekten har applicerats på.
		 * 
		 *	@default DisplayObjectContainer
		 */
		protected var _target:DisplayObjectContainer
		
		/**
		 *	Innehåller effektens livslängd angivet i millisekunder. 
		 *	Objektet kommer att deallokeras när heltalet når noll.
		 * 
		 *	@default 0
		 */
		protected var _duration:int
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av Effect-klassen.
		 * 
		 *	@param	target		Det grafiska objekt som effekten ska appliceras på.
		 *	@param	duration	Effektens livslängd angivet i millisekunder.
		 */
		public function Effect(target:DisplayObjectContainer, duration:int) {
			_target = target;
			_duration = duration;
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Stoppar och avslutar effekten. Effekten kommer att 
		 *	tas bort från effekthanteraren och deallokeras i 
		 *	samband med att denna metod utförs.
		 * 
		 *	@return	void
		 */
		public function stop():void {
			_duration = 0;
			complete = true;
		}
		
		//-------------------------------------------------------
		// Internal methods
		//-------------------------------------------------------
		
		/**
		 *	Intern metod som aktiveras när effekten läggs till i 
		 *	effekthanteraren. Denna metod används för att utföra 
		 *	inställningar innan effekten träder i kraft. 
		 *	Basklassen utför inga beräkningar i denna metod då 
		 *	den inte har något att initiera.
		 * 
		 *	@return	void
		 */
		internal function init():void {
			// ÖVERSKRIV FRÅN SUPERKLASS
		}
		
		/**
		 *	Uppdaterar effektens interna beräkningar så att den 
		 *	kan hålla sig synkroniserad med spel-loopen.
		 * 
		 *	@return	void
		 */
		internal function update():void {
			_duration -= Session.application.time.timeSinceLastFrame;
			if (_duration <= 0) complete = true;
		}
		
		/**
		 *	Metod som används för att deallokera interna resurser 
		 *	som effekten använder. Basklassen utför inga beräkningar 
		 *	i denna metod då den inte har något att deallokera.
		 * 
		 *	@return	void
		 */
		internal function dispose():void {
			// ÖVERSKRIV FRÅN SUPERKLASS
		}
	}
}