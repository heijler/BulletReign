package se.lnu.stickossdk.system
{
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.component.notice.Notices;
	import se.lnu.stickossdk.component.screenkeyboard.ScreenKeyboardManager;
	import se.lnu.stickossdk.fx.Effects;
	import se.lnu.stickossdk.media.SoundManager;
	import se.lnu.stickossdk.net.Highscore;
	import se.lnu.stickossdk.timer.Timers;
	import se.lnu.stickossdk.tween.Tweener;

	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Session är en statisk klass som är menad att innehålla 
	 *	referenser till objekt som behöver finnas tillgängliga 
	 *	överallt i applikationen.
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-17
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Session {
		
		//-------------------------------------------------------
		// Public static getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Referens till den aktuella applikationen.
		 */
		public static function get application():Engine {
			return _application;
		}
		
		/**
		 *	Denna referens är reserverad för internet bruk av StickOS SDK. 
		 *	Externa utvecklare skall inte använda denna referens!
		 */
		public static function get core():Core {
			return _core;
		}
		
		/**
		 *	Referens till StickOS SDKs sessionsregister. 
		 *	Registret används för att spara information som 
		 *	behöver finnas tillgängligt globalt i applikationen.
		 */
		public static function get data():Data {
			return _data;
		}
		
		/**
		 *	Referens till StickOS SDKs ljudhanterare. 
		 *	Ljudhanteraren erbjuder ljudkanaler för effekt- och 
		 *	musikuppspelning.
		 */
		public static function get sound():SoundManager {
			return _soundManager;
		}
		
		/**
		 *	Referens till StickOS SDKs highscore-hanterare. 
		 *	Detta objekt erbjuder ett gränssnitt för att 
		 *	kommunicera med StickOS Highscore API.
		 */
		public static function get highscore():Highscore {
			return _highscore;
		}
		
		/**
		 *	Referens till StickOS SDKs skärmtangentbord. 
		 *	Skärmtangentbordet erbjuder ett gränssnitt för att 
		 *	mata in textbaserad information med arkadmaskinens 
		 *	spakar.
		 */
		public static function get screenKeyboard():ScreenKeyboardManager {
			return _screenKeyboard;
		}
		
		/**
		 *	Referens till StickOS SDKs tween-motor. Detta objekt 
		 *	kan användas för att skapa tween-baserade animationer 
		 *	i StickOS SDK-baserade spel.
		 */
		public static function get tweener():Tweener {
			return _tweener;
		}
		
		/**
		 *	Referens till StickOS SDKs timerhanterare. Detta 
		 *	objekt används för att skapa och hantera timers i 
		 *	StickOS SDK-baserade spel.
		 */
		public static function get timer():Timers {
			return _timerManager;
		}
		
		/**
		 *	Referens till StickOS SDKs effekthanterare. Objektet 
		 *	används för att skapa och hantera visuella effekter 
		 *	i StickOS SDK-baserade spel.
		 */
		public static function get effects():Effects {
			return _effects;
		}
		
		//-------------------------------------------------------
		// Private static properties
		//-------------------------------------------------------
		
		/**
		 *	Referens till den aktuella applikationen. Egenskapen 
		 *	får sitt värde tilldelat via init-metoden.
		 * 
		 *	@default null
		 */
		private static var _application:Engine;
		
		/**
		 *	...
		 * 
		 *	@default null
		 */
		private static var _core:Core;
		
		/**
		 *	Referens till StickOS SDKs ljudhanterare. Egenskapen 
		 *	får sitt värde via init-metoden.
		 * 
		 *	@default null
		 */
		private static var _soundManager:SoundManager;
		
		/**
		 *	Referens till StickOS SDKs highscore-hanterare. 
		 *	Egenskapen får sitt värde via init-metoden.
		 * 
		 *	@default null
		 */
		private static var _highscore:Highscore;
		
		/**
		 *	Referens till StickOS SDKs skärmtangentbord. 
		 *	Egenskapen får sitt värde via init-metoden.
		 * 
		 *	@default null
		 */
		private static var _screenKeyboard:ScreenKeyboardManager;
		
		/**
		 *	Referens till StickOS SDKs tween-hanterare. 
		 *	Egenskapen får sitt värde via init-metoden.
		 * 
		 *	@default null
		 */
		private static var _tweener:Tweener;
		
		/**
		 *	Referens till StickOS SDKs timer-hanterare. 
		 *	Egenskapen får sitt värde via init-metoden.
		 * 
		 *	@default null
		 */
		private static var _timerManager:Timers;
		
		/**
		 *	Referens till StickOS SDKs effekthanterare. 
		 *	Egenskapen får sitt värde via init-metoden.
		 * 
		 *	@default null
		 */
		private static var _effects:Effects;
		
		/**
		 *	Referens till StickOS SDKs sessionsregister. 
		 *	Egenskapen får sitt värde via init-metoden.
		 * 
		 *	@default null
		 */
		private static var _data:Data;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av Session. Denna metod ska inte 
		 *	användas då Session är en statisk klass.
		 */
		public function Session() {
			throw new Error("Session is a static class and should not be instantiated.");
		}
		
		//-------------------------------------------------------
		// Internal static functions
		//-------------------------------------------------------
		
		/**
		 *	Denna metod fungerar som en statisk konstruktor för 
		 *	klassen. När denna metod aktiveras instansieras 
		 *	klassens underliggande objekt. Sessionsklassen kommer 
		 *	inte att vara funktionsduglig innan denna metod har 
		 *	aktiverats. Aktiveringen sker automatiskt av motorn.
		 * 
		 *	@param	application	Referens till motorn.
		 * 
		 *	@return void
		 */
		internal static function init(application:Engine):void {
			_application  	= application;
			_data			= new Data();
			_soundManager 	= new SoundManager();
			_timerManager	= new Timers();
			_highscore 	  	= new Highscore(_application.id);
			_screenKeyboard = new ScreenKeyboardManager(_application.overlay);
			_tweener		= new Tweener();
			_effects		= new Effects();
			_core			= new Core();
		}
		
		/**
		 *	Uppdaterar de underliggande objekt som är i behov att 
		 *	uppdateras en gång per bildruta.
		 * 
		 *	@return void
		 */
		internal static function update():void {
			_screenKeyboard.update();
			_soundManager.update();
			_tweener.update();
			_timerManager.update();
			_effects.update();
			_core.update();
		}
		
		/**
		 *	Tar bort och deallokerar objekt som allokerats av 
		 *	klassen. Denna metod aktiveras när StickOS avslutar 
		 *	spelet.
		 * 
		 *	@return void
		 */
		internal static function dispose():void {
			disposeData();
			disposeTimerManager();
			disposeEffects();
			disposeSoundManager();
			disposeScreenKeyboard();
			disposeCore();
			
			_application = null;
		}
		
		/**
		 *	Återställer objekt till deras initiala tillstånd.
		 * 
		 *	@return void
		 */
		internal static function reset():void {
			_data.reset();
			_timerManager.dispose();
			_tweener.dispose();
			_effects.dispose();
			_screenKeyboard.reset();
			_soundManager.reset();
		}
		
		//-------------------------------------------------------
		// Private static functions
		//-------------------------------------------------------
		
		/**
		 *	Deallokerar minnet för data-objektet.
		 * 
		 *	@return void
		 */
		private static function disposeData():void {
			_data.dispose();
			_data = null;
		}
		
		/**
		 *	Deallokerar minnet för timer-objektet.
		 * 
		 *	@return void
		 */
		private static function disposeTimerManager():void {
			_timerManager.dispose();
			_timerManager = null;
		}
		
		/**
		 *	Deallokerar minnet för tweener-objektet.
		 * 
		 *	@return void
		 */
		private static function disposeTweener():void {
			_tweener.dispose();
			_tweener = null;
		}
		
		/**
		 *	Deallokerar minnet för effekt-objektet.
		 * 
		 *	@return void
		 */
		private static function disposeEffects():void {
			_effects.dispose();
			_effects = null;
		}
		
		/**
		 *	Deallokerar minnet för ljud-objektet.
		 * 
		 *	@return void
		 */
		private static function disposeSoundManager():void {
			_soundManager.dispose();
			_soundManager = null;
		}
		
		/**
		 *	Deallokerar minnet för skärmtangentbords-objektet.
		 * 
		 *	@return void
		 */
		private static function disposeScreenKeyboard():void {
			_screenKeyboard.dispose();
			_screenKeyboard = null;
		}
		
		/**
		 *	Deallokerar minnet för skärmtangentbords-objektet.
		 * 
		 *	@return void
		 */
		private static function disposeCore():void {
			_core.dispose();
			_core = null;
		}
	}
}