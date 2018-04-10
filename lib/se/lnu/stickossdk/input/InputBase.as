package se.lnu.stickossdk.input
{
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.events.Event;
	
	//-----------------------------------------------------------
	// Abstract class
	//-----------------------------------------------------------
	
	/**
	 *	Hanterar grundläggande funktionalitet för samtliga 
	 *	input-enheter, exempelvis tangentbord och mus.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-23
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class InputBase {
		
		//-------------------------------------------------------
		// Protected properties
		//-------------------------------------------------------
		
		/**
		 *	Antal knappar som enheten tillgång till.
		 * 
		 *	@default 0
		 */
		protected var numButtons:int;
		
		/**
		 *	Innehåller en referens till den aktiva 
		 *	input-tangenten. Denna tangent kan representeras av 
		 *	en tangentbordstangent eller en musknapp. Denna 
		 *	egenskap är främst menad att reducera 
		 *	minnesförbrukningen vid intern användning.
		 * 
		 *	@default null
		 */
		protected var currentKey:InputKey;
		
		/**
		 *	Lista innehållande samtliga registrerade tangenter. 
		 *	Längden på denna lista varierar beroende på hur många 
		 *	tangenter/knappar enheten har.
		 * 
		 *	@default null
		 */
		protected var map:Vector.<InputKey>;
		
		/**
		 *	Innehåller information om möjliga tangenter och deras 
		 *	tangentkod (key code).
		 * 
		 *	@default Array
		 */
		protected var lookup:Array = new Array();
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av InputBase.
		 */
		public function InputBase() {
			initKeys();
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Aktiveras när en tangent trycks ner.
		 * 
		 *	@param	event	Händelsen som aktiverade metoden.
		 * 
		 *	@return void
		 */
		public function handleButtonDown(event:Event):void {
			//ÖVERSKRIV FRÅN SUPER
		}
		
		/**
		 *	Aktiveras när en tangent släpps.
		 * 
		 *	@param	event	Händelsen som aktiverade metoden.
		 * 
		 *	@return void
		 */
		public function handleButtonUp(event:Event):void {
			//ÖVERSKRIV FRÅN SUPER
		}
		
		//-------------------------------------------------------
		// Public final methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar enhetens samtliga tangenter.
		 * 
		 *	@return void
		 */
		public final function update():void {
			var i:int;
			
			while (i < numButtons) {
				currentKey = map[i++];
				
				if (currentKey == null) {
					continue;
				}
				
				currentKey.update();
			}
		}
		
		/**
		 *	Nollställer enhetens samtliga tangenter.
		 * 
		 *	@return void
		 */
		public final function reset():void {
			var i:int;
			
			while (i < numButtons) {
				currentKey = map[i++];
				
				if (currentKey == null) {
					continue;
				}
				
				this[currentKey.name] = false;
				currentKey.reset();
			}
		}
		
		/**
		 *	Tar bort och deallokerar objekt som allokerats av 
		 *	klassen.
		 * 
		 *	@return void
		 */
		public final function dispose():void {
			//TODO: FÖRBÄTTRA; GÖR EN RIKTIG TÖMMNING AV LISTORNA
			disposeLookup();
			disposeMap();
			currentKey = null;
		}
		
		/**
		 *	Kontrollerar om en tangent är nertryckt.
		 * 
		 *	@param	key	Tangenten som ska kontrolleras.
		 * 
		 *	@return Om tangenten är nedtryckt eller inte.
		 */
		public final function pressed(key:String):Boolean {
			return this[key];
		}
		
		/**
		 *	Kontrollerar om en tangent har tryckts ner en gång. 
		 *	Metoden används då man inte vill registrera en input 
		 *	vid varje aktiv bildruta.
		 * 
		 *	@param	key	Tangenten som ska kontrolleras.
		 * 
		 *	@return Om tangenten är nedtryckt eller inte.
		 */
		public final function justPressed(key:String):Boolean {
			return map[lookup[key]].current == InputKey.JUST_PRESSED;
		}
		
		/**
		 *	Kontrollera om tangenten släpptes (blev inaktiv).
		 * 
		 *	@param	key	Tangenten som ska kontrolleras.
		 * 
		 *	@return Om tangenten släpptes eller inte.
		 */
		public final function justReleased(key:String):Boolean {
			return map[lookup[key]].current == InputKey.RELEASED;
		}
		
		/**
		 *	Om någon tangent är nertryckt.
		 * 
		 *	@return Boolean
		 */
		public final function anyPressed():Boolean {
			var i:int;
			
			while (i < numButtons) {
				currentKey = map[i++];
				
				if (currentKey != null && currentKey.current > InputKey.INACTIVE) {
					return true;
				}
			}
			
			currentKey = null;
			return false;
		}
		
		//-------------------------------------------------------
		// Protected methods
		//-------------------------------------------------------
		
		/**
		 *	Används för att initiera enhetens tillgängliga 
		 *	tangenter.
		 * 
		 *	@return void
		 */
		protected function initKeys():void {
			// ÖVERSKRIV FRÅN SUPER
		}
		
		//-------------------------------------------------------
		// Protected final methods
		//-------------------------------------------------------
		
		/**
		 *	Lägger till en ny tangent.
		 * 
		 *	@param	name	Tangentens namn.
		 *	@param	code	Tangentens tangentkod.
		 * 
		 *	@return void
		 */
		protected final function addKey(name:String, code:uint):void {
			lookup[name] = code;
			map[code] = new InputKey(name);
		}
		
		/**
		 *	Tilldelar en tangent ett aktuellt tillstånd.
		 * 
		 *	@param	pressed	Om tangenten är nedtryckt.
		 * 
		 *	@return void
		 */
		protected final function setButtonState(pressed:Boolean):void {
			if (currentKey == null) {
				return;
			}
			
			if (currentKey.current > InputKey.INACTIVE) {
				currentKey.current = pressed ? InputKey.PRESSED : InputKey.RELEASED;
			} else {
				currentKey.current = pressed ? InputKey.JUST_PRESSED : InputKey.INACTIVE;
			}
			
			this[currentKey.name] = pressed;
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function disposeLookup():void {
			var i:int = 0;
			for (i = 0; i < lookup.length; i++) {
				lookup[i] = null;
				lookup.splice(i, 1);
			}
			
			i = 0;
			lookup.length = 0;
			lookup = null;
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function disposeMap():void {
			var i:int = 0;
			for (i = 0; i < map.length; i++) {
				map[i] = null;
				map.splice(i, 1);
			}
			
			i = 0;
			map.length = 0;
			map = null;
		}
	}
}