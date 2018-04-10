package se.lnu.stickossdk.display {
	
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import se.lnu.stickossdk.fx.Flash;
	import se.lnu.stickossdk.fx.Flicker;
	import se.lnu.stickossdk.fx.Shake;
	import se.lnu.stickossdk.state.StateMachine;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.tween.easing.Quad;

	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	DisplayState representerar ett grafiskt tillstånd i en 
	 *	StickOS SDK-applikation. Ett DisplayState används för att 
	 *	dela upp applikationen och innehåller enbart programkod 
	 *	som är relevant för det aktuella tillståndet. Exempel på 
	 *	DisplayState kan vara GameState och MenuState där 
	 *	GameState innehåller programkod för spelmekaniken och 
	 *	MenuState innehåller programkod för spelmenyn. Det är 
	 *	inte möjligt att köra flera DisplayStates samtidigt.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-23
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class DisplayState {
		
		//-------------------------------------------------------
		// Public getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Tillståndets lagerhanterare. Grafiska objekt som ska 
		 *	renderas till skärmen måste placeras i ett lager.
		 */
		public function get layers():DisplayStateLayers {
			return _displayStateLayers;
		}
		
		/**
		 *	En StateMachine för att hantera underliggande 
		 *	tillstånd för detta DisplayState.
		 */
		public function get stateMachine():StateMachine {
			return _stateMachine;
		}
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Klassens fördefinierade lagerhanterare. Används för 
		 *	att rendera grafiska objekt. 
		 * 
		 *	@default DisplayStateLayers
		 */
		private var _displayStateLayers:DisplayStateLayers = new DisplayStateLayers();
		
		/**
		 *	Klassens fördefinierade StateMachine. Används för att 
		 *	hantera underliggande tillstånd.
		 * 
		 *	@default StateMachine
		 */
		private var _stateMachine:StateMachine = new StateMachine();
		
		/**
		 *	Effekt-objekt som används för att applicera en 
		 *	skakeffekt på tillståndet. Använd metoden shake() för 
		 *	att skapa en skakning.
		 * 
		 *	@default null
		 */
		private var _shake:Shake;
		
		/**
		 *	Effekt-objekt som används för att applicera en 
		 *	blixteffekt på tillståndet. Använd metoden flash() 
		 *	för att skapa en skakning.
		 * 
		 *	@default null
		 */
		private var _flash:Flash;
		
		/**
		 *	Effekt-objekt som används för att applicera en 
		 *	flimmereffekt på tillståndet. Använd metoden 
		 *	flicker() för att skapa en skakning.
		 * 
		 *	@default null
		 */
		private var _flicker:Flicker;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av DisplayState.
		 */
		public function DisplayState() {
			
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Metoden använder StickOS SDKs inbyggda 
		 *	effekthanterare för att skapa och applicera en 
		 *	skakeffekt på detta tillstånd.
		 * 
		 *	@param	duration	Fortlöpningstid.
		 *	@param	ammount		Hur kraftiga skakningarna är.
		 *	@param	unique		Om effekten är unik.
		 * 
		 *	@return void
		 */
		public function shake(duration:int, ammount:Point, unique:Boolean = true):void {
			if (_shake && unique) _shake.stop();
			_shake = new Shake(_displayStateLayers.container, duration, ammount);
			Session.effects.add(_shake);
		}
		
		/**
		 *	Metoden använder StickOS SDKs inbyggda 
		 *	effekthanterare för att skapa och applicera en 
		 *	blixteffekt på detta tillstånd.
		 * 
		 *	@param	duration	Fortlöpningstid.
		 *	@param	color		Blixteffektens färg.
		 *	@param	unique		Om effekten är unik.
		 * 
		 *	@return void
		 */
		public function flash(duration:int, color:uint = 0xFFFFFF, unique:Boolean = true):void {
			if (_flash && unique) _flash.stop();
			
			var width:Number  = Session.application.size.x;
			var height:Number = Session.application.size.y;
			
			_flash = new Flash(_displayStateLayers.container, duration, color, new Rectangle(0, 0, width, height));
			Session.effects.add(_flash);
		}
		
		/**
		 *	Metoden använder StickOS SDKs inbyggda 
		 *	effekthanterare för att skapa och applicera en 
		 *	flimmereffekt på detta tillstånd.
		 * 
		 *	@param	duration	Fortlöpningstid.
		 *	@param	interval	Fördröjning.
		 *	@param	unique		Om effekten är unik.
		 * 
		 *	@return void
		 */
		public function flicker(duration:int, interval:int = 36, unique:Boolean = true):void {
			if (_flicker && unique) _flicker.stop();
			_flicker = new Flicker(_displayStateLayers.container, duration, interval);
			Session.effects.add(_flicker);
		}
		
		/**
		 *	@TODO: ...
		 * 
		 *	@param	target		...
		 *	@param	duration	...
		 *	@param	onComplete	...
		 * 
		 *	@return void
		 */
		public function fadeIn(target:DisplayObject, duration:int = 1000, onComplete:Function = null):void {
			Session.tweener.add(target, {
				duration: duration,
				transition: Quad.easeOut,
				alpha: 1.0,
				onComplete: onComplete
			});
		}
		
		/**
		 *	@TODO: ...
		 * 
		 *	@param	target		...
		 *  @param	duration	...
		 *	@param	onComplete	...
		 * 
		 *	@return void
		 */
		public function fadeOut(target:DisplayObject, duration:int = 1000, onComplete:Function = null):void {
			Session.tweener.add(target, {
				duration: duration,
				transition: Quad.easeOut,
				alpha: 0.0,
				onComplete: onComplete
			});
		}
		
		/**
		 *	Metod som aktiveras precis innan init(). Metoden är 
		 *	främst menad att användas internt av motorn. Denna 
		 *	metod bör inte överskrivas från super-klassen.
		 * 
		 *	@return void
		 */
		public function preInit():void {
			//ANVÄNDS AV MOTORN
		}
		
		/**
		 *	Metoden aktiveras när tillståndet initieras av 
		 *	spelmotorn.
		 * 
		 *	@return void
		 */
		public function init():void {
			//ÖVERSKRIV AV SUPER
		}
		
		/**
		 *	Metod som aktiveras precis efter init(). Metoden är 
		 *	främst menad att användas internt av motorn. Denna 
		 *	metod bör inte överskrivas från super-klassen.
		 * 
		 *	@return void
		 */
		public function postInit():void {
			//ANVÄNDS AV MOTORN
		}
		
		/**
		 *	Metod som aktiveras precis innan update(). Metoden är 
		 *	främst menad att användas internt av motorn. Denna 
		 *	metod bör inte överskrivas från super-klassen.
		 * 
		 *	@return void
		 */
		public function preUpdate():void {
			//@TODO: FIX
			_displayStateLayers.update();
			_stateMachine.update();
		}
		
		/**
		 *	Metod som aktiveras en gång per bildruta (frame). 
		 *	Använd metoden för att konstruera tillståndets logik.
		 * 
		 *	@return void
		 */
		public function update():void {
			//ÖVERSKRIV AV SUPER
		}
		
		/**
		 *	Metod som aktiveras precis efter update(). Metoden är 
		 *	främst menad att användas internt av motorn. Denna 
		 *	metod bör inte överskrivas från super-klassen.
		 * 
		 *	@return void
		 */
		public function postUpdate():void {
			//ANVÄNDS AV MOTORN
		}
		
		/**
		 *	Metod som aktiveras precis innan dispose(). Metoden 
		 *	är främst menad att användas internt av motorn. Denna 
		 *	metod bör inte överskrivas från super-klassen.
		 * 
		 *	@return void
		 */
		public function preDispose():void {
			//ANVÄNDS AV MOTORN
		}
		
		/**
		 *	Metoden aktiveras när tillståndet deallokeras av 
		 *	spelmotorn.
		 * 
		 *	@return void
		 */
		public function dispose():void {
			
		}
		
		/**
		 *	Metod som aktiveras precis efter dispose(). Metoden 
		 *	är främst menad att användas internt av motorn. Denna 
		 *	metod bör inte överskrivas från super-klassen.
		 * 
		 *	@return void
		 */
		public function postDispose():void {
			//@TODO: FIX
			_displayStateLayers.dispose();
			_stateMachine.dispose();
		}
	}
}