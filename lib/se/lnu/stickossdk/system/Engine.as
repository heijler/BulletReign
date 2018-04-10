package se.lnu.stickossdk.system
{
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.ui.Mouse;
	
	import se.lnu.stickossdk.component.notice.Notices;
	import se.lnu.stickossdk.debug.Debug;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.input.Input;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Engine är StickOS SDKs basklass och ansvarar för att 
	 *	systemet fungerar enligt förväntningarna.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-22
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Engine extends Sprite {
		
		//-------------------------------------------------------
		// Public static constants
		//-------------------------------------------------------
		
		/**
		 *	Versionsnummer för denna version av StickOS SDK.
		 */
		public static const VERSION:String = "1.6.8";
		
		//-------------------------------------------------------
		// Public getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Referens till applikationens nuvarande tillstånd 
		 *	(DisplayState).
		 */
		public function get displayState():DisplayState {
			return _displayState;
		}
		
		/**
		 *	@private
		 */
		public function set displayState(state:DisplayState):void {
			_swapState = state;
		}
		
		/**
		 *	StickOS SDKs notis-hanterare
		 */
		public function get notices():Notices {
			return _notices;
		}
		
		/**
		 *	Applikationens storlek i x- och y-led. Storleken är 
		 *	angiven i pixlar.
		 */
		public function get size():Point {
			return initSize;
		}
		
		/**
		 *	Applikationens skala i x- och y-led.
		 */
		public function get scale():Point {
			return initScale;
		}
		
		/**
		 *	Objekt som används för att beräkna förfluten tid i 
		 *	applikationen.
		 */
		public function get time():Time {
			return _time;
		}
		
		/**
		 *	Applikationens id, även kallat spel-id.
		 */
		public function get id():int {
			return initId;
		}
		
		//-------------------------------------------------------
		// Internal properties
		//-------------------------------------------------------
		
		/**
		 *	Referens till ett överdragslager. Detta lager används 
		 *	för att rendera grafiska objekt ovanpå spelet. 
		 *	Exempel på funktionalitet som använder detta lager är 
		 *	StickOS  SDKs inbyggda skärmtangentbord som finns 
		 *	tillgängligt via Session.
		 */
		internal function get overlay():Sprite {
			return _overlay;
		}
		
		//-------------------------------------------------------
		// Public properties
		//-------------------------------------------------------
		
		/**
		 *	Adress till extern databas om spelet skall exporteras till mobil, PC eller mac
		 * 
		 *	@default DisplayState
		 */
		public var initExternalDatabaseLocation:String = null;
		
		//-------------------------------------------------------
		// Protected properties
		//-------------------------------------------------------
		
		/**
		 *	Applikationens unika id. Detta id benämns även som 
		 *	spel-id.
		 * 
		 *	@default 0
		 */
		protected var initId:int = 0;
		
		/**
		 *	Applikationens skärupplösning i x- och y-led. 
		 *	Standardupplösningen är 800x600 pixlar, vilket 
		 *	motsvarar Evertrons maxupplösning. 
		 * 
		 *	@default Point(800, 600)
		 */
		protected var initSize:Point = new Point(800, 600);
		
		/**
		 *	Applikationens skala i x- och y-led.
		 * 
		 *	@default Point(1, 1)
		 */
		protected var initScale:Point = new Point(1, 1);
		
		/**
		 *	Applikationens bakgrundsfärg. Bakgrundsfärgen består 
		 *	av en solid RGB-färg och har inte möjlighet att 
		 *	använda ARGB-formatet för transparens.
		 * 
		 *	@default 0x000000
		 */
		protected var initBackgroundColor:uint = 0x000000;
		
		/**
		 *	Det tillstånd (DisplayState) som ska användas vid 
		 *	applikationsuppstarten.
		 * 
		 *	@default DisplayState
		 */
		protected var initDisplayState:Class = DisplayState;
		
		/**
		 *	Om applikationen ska starta med debugg-verktyget 
		 *	aktivt eller inte.
		 * 
		 *	@default false
		 */
		protected var initDebugger:Boolean;
		
		/**
		 *	Vilken sorts renderingsteknik som applikationen skall använda
		 * 
		 *	@default StageQuality.LOW
		 */
		protected var initRenderQuality:String = StageQuality.LOW;
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Deta aktuella visningstillståndet.
		 * 
		 *	@default DisplayState
		 */
		private var _displayState:DisplayState = new DisplayState();
		
		/**
		 *	Objekt för att beräkna tid.
		 * 
		 *	@default Time
		 */
		private var _time:Time = new Time();
		
		/**
		 *	Objekt för att hantera debugg-verktyg.
		 * 
		 *	@default null
		 */
		private var _debug:Debug;
		
		/**
		 *	...
		 * 
		 *	@default null
		 */
		private var _notices:Notices;
		
		/**
		 *	Överdragslager som används för att presentera 
		 *	information ovanpå spel.
		 * 
		 *	@default null
		 */
		private var _overlay:Sprite;
		
		/**
		 *	...
		 * 
		 *	@default null
		 */
		private var _swapState:DisplayState;
		
		//-------------------------------------------------------
		// Private constants
		//-------------------------------------------------------
		
		/**
		 *	Tangent som används som bastangent för att utföra 
		 *	tangentbordskommandon. Exempel på 
		 *	tangentbordskommandon är SHIFT + F 
		 *	(aktivera/avaktivera helskärmsläget).
		 * 
		 *	@default "SHIFT"
		 */
		private const DEFAULT_COMMAND_KEY:String = "SHIFT";
		
		/**
		 *	Tangenten som används för att växla mellan fönster- 
		 *	och helskärmsläge.
		 * 
		 *	@default "F"
		 */
		private const DEFAULT_FULLSCREEN_KEY:String = "F";
		
		/**
		 *	Tangent som används för att aktivera/avaktivera 
		 *	debugg-läget.
		 * 
		 *	@default "F"
		 */
		private const DEFAULT_DEBUG_KEY:String = "D";
		
		/**
		 *	TODO
		 * 
		 *	@default "K"
		 */
		private const DEFAULT_KILL_SWITCH_KEY:String = "K";
		
		/**
		 *	Meddelande för saknat spel-id vid kompilering.
		 * 
		 *	@default String
		 */
		private const ERROR_MISSING_GAME_ID:String = "Valid game id is missing. StickOS SDK does not allow compilation without valid game id.";
		
		//-------------------------------------------------------
		// private embeded constants
		//-------------------------------------------------------
		
		/**
		 *	Inkluderar ett standardtypsnitt för StickOS SDK. 
		 *	Typsnittet består av ett MineCraft-inspirerat 
		 *	typsnitt. Typsnittets ursprungsstorlek är 8px.
		 * 
		 *	@default Class
		 */
		[Embed(source = "/se/lnu/stickossdk/asset/ttf/pixel.ttf", fontFamily = "system", mimeType = "application/x-font", embedAsCFF="false")] 
		private static const DEFAULT_TEXT:Class;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av Engine. Klassen representerar 
		 *	spelmotorn och hanterar all grundläggande 
		 *	funktionalitet.
		 */
		public function Engine() {
			setup();
			validateSetup();
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Denna metod ska överskrivas av superklassen. 
		 *	Metoden används för att ge spelmotorn sina initiala 
		 *	värden.
		 * 
		 *	@return void
		 */
		public function setup():void {
			
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		public function presets():void {
			
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		public function kill():void {
			
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	Kontrollerar att applikationen har konfigurerats 
		 *	korrekt innan kompileringen påbörjas. Syftet är att 
		 *	undvika spel som kompileras med fel spel-id.
		 * 
		 *	@return void
		 */
		private function validateSetup():void {
			if (initId < 1) throw new Error(ERROR_MISSING_GAME_ID);
		}
		
		/**
		 *	Denna metod aktiveras när applikationen placeras på 
		 *	scenen, dvs när Adobe AIR / Adobe Flash Player har 
		 *	laddat in applikationen. Metoden startar motorn och 
		 *	initierar de grundläggande komponenterna.
		 * 
		 *	@param	event	Händelsen som aktiverade metoden.
		 * 
		 *	@return void
		 */
		private function init(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			initOverlay();
			initSession();
			initNotices();
			initDebug();
			initStage();
			initResolution();
			initInput();
			initPresets();
			initState();
			initEvent();
		}
		
		/**
		 *	Initierar StickOS SDKs statiska sessionsklass. 
		 *	Klassen innehåller information som behöver vara 
		 *	tillgängligt överallt i applikationen.
		 * 
		 *	@return void
		 */
		private function initSession():void {
			Session.init(this);
		}
		
		/**
		 *	Skapar och initierar ett överdragslager som placeras 
		 *	ovanpå spellagret. Lagrets syfte är att innehålla 
		 *	information som måste presenteras ovanpå spelet. 
		 *	Exempel på objekt som använder detta lager är StickOs 
		 *	SDKs inbyggda skärmtangentbord.
		 * 
		 *	@return void
		 */
		private function initOverlay():void {
			_overlay = new Sprite();
			addChild(_overlay);
		}
		
		/**
		 *	Skapar och initierar StickOS SDKs debugg-verktyg. 
		 *	Verktyget aktiveras automatiskt om egenskapen 
		 *	initDebugger har satts till true i setup-metoden.
		 * 
		 *	@return void
		 */
		private function initNotices():void {
			_notices = new Notices(size.x, size.y);
			_overlay.addChild(_notices);
		}
		
		/**
		 *	Skapar och initierar StickOS SDKs debugg-verktyg. 
		 *	Verktyget aktiveras automatiskt om egenskapen 
		 *	initDebugger har satts till true i setup-metoden.
		 * 
		 *	@return void
		 */
		private function initDebug():void {
			_debug = new Debug();
			if (initDebugger) addChild(_debug);
		}
		
		/**
		 *	Aktiverar helskärmsläget. Detta förutsätter att 
		 *	applikationen körs som en AIR-applikation. Om 
		 *	applikationen körs i Adobe Flash Player kommer denna 
		 *	åtgärden att nekas (webb).
		 * 
		 *	@return void
		 */
		private function initStage():void {
			try {
				setupFullscreen();
			} catch (error:SecurityError) {
				trace("STICKOS SDK: FULLSCREEN IS NOT AVAILABLE.");			
			}
		}
		
		/**
		 *	Förbereder och ställer in applikationens 
		 *	skärmupplösning. Spel som är mindre än 
		 *	standardupplösningen på 800x600 pixlar kommer att 
		 *	centreras.
		 * 
		 *	@return void
		 */
		private function initResolution():void {
			this.graphics.beginFill(initBackgroundColor);
			this.graphics.drawRect(0, 0, initSize.x, initSize.y);
			this.graphics.endFill();
			
			/*
			// OSX RETINA FIX
			this.width  = initSize.x;
			this.height = initSize.y;
			this.scaleX = initScale.x;
			this.scaleY = initScale.y;
			this.x = (stage.stageWidth  >> 1) - (width  >> 1);
			this.y = (stage.stageHeight >> 1) - (height >> 1);
			*/
			
			this.opaqueBackground = true;
		}
		
		/**
		 *	Initierar StickOS SDKs inputenheter (tangentbord).
		 * 
		 *	@return void
		 */
		private function initInput():void {
			Input.init(stage);
			Input.enableKeyboard = true;
			Mouse.hide();
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function initPresets():void {
			presets();
		}
		
		/**
		 *	Initierar applikationens start-tillstånd. Tillståndet 
		 *	består av ett DisplayState som tilldelats i 
		 *	setup-metoden.
		 * 
		 *	@return void
		 */
		private function initState():void {
			displayState = new initDisplayState();
		}
		
		/**
		 *	Aktiverar StickOS SDKs händelselyssnare. 
		 *	Applikationer som skapas bör inte registrera egna 
		 *	händelselyssnare.
		 * 
		 *	@return void
		 */
		private function initEvent():void {
			stage.addEventListener(Event.ENTER_FRAME, update);
			this.addEventListener(Event.REMOVED_FROM_STAGE, dispose);
		}
		
		/**
		 *	Den globala update-loopen. Detta är hjärtat i varje 
		 *	StickOS SDK-applikation.
		 * 
		 *	@param	event	Händelsen som aktiverade metoden.
		 * 
		 *	@return void
		 */
		private function update(event:Event):void {
			updateSwap();
			updateTime();
			updateDebug();
			updateInput();
			updateSession();
			updateState();
			updateEngine();
		}
		
		/**
		 *	Uppdaterar motorns interna tidräknare. Objektet 
		 *	används för att synkronisera motorns tidsbaserade 
		 *	händelser.
		 * 
		 *	@return void
		 */
		private function updateSwap():void {
			if (_swapState != null) {
				swapDisplayState(_swapState);
				_swapState = null;
			}
		}
		
		/**
		 *	Uppdaterar motorns interna tidräknare. Objektet 
		 *	används för att synkronisera motorns tidsbaserade 
		 *	händelser.
		 * 
		 *	@return void
		 */
		private function updateTime():void {
			_time.update();
		}
		
		/**
		 *	Uppdaterar StickOS SDKs debugg-verktyg, om det är 
		 *	aktiverat. Systemet kommer att uppleva en viss 
		 *	prestandaförsämring när debugg-verktyget är 
		 *	aktiverat.
		 * 
		 *	@return void
		 */
		private function updateDebug():void {
			if (_debug.stage) {
				_debug.update();
			}
		}
		
		/**
		 *	Uppdaterar StickOS SDKs inmatningsenheter.
		 * 
		 *	@return void
		 */
		private function updateInput():void {
			Input.update();
		}
		
		/**
		 *	Uppdaterar StickOS SDKs statiska sessions-klass.
		 * 
		 *	@return void
		 */
		private function updateSession():void {
			Session.update();
		}
		
		/**
		 *	Uppdaterar applikationens aktuella tillstånd.
		 * 
		 *	@return void
		 */
		private function updateState():void {
			if (displayState != null) {
				displayState.preUpdate();
				displayState.update();
				displayState.postUpdate();
			}
		}
		
		/**
		 *	Uppdaterar interna objekt som används av motorn.
		 * 
		 *	@return void
		 */
		private function updateEngine():void {
			updateFullscreenMode();
			updateDebugMode();
			updateKillSwitch();
		}
		
		/**
		 *	Kontrollerar om applikationen ska befinna sig i 
		 *	helskärms- eller fönsterläge.
		 * 
		 *	@return void
		 */
		private function updateFullscreenMode():void {
			if (Input.keyboard.pressed(DEFAULT_COMMAND_KEY) && Input.keyboard.justPressed(DEFAULT_FULLSCREEN_KEY)) {
				toggleFullscreen();
			}
		}
		
		/**
		 *	Kontrollerar om applikationen ska använda StickOS 
		 *	SDKs debugg-verktyg eller inte.
		 * 
		 *	@return void
		 */
		private function updateDebugMode():void {
			if (Input.keyboard.pressed(DEFAULT_COMMAND_KEY) && Input.keyboard.justPressed(DEFAULT_DEBUG_KEY)) {
				toggleDebugMode();
			}
		}
		
		/**
		 *	TODO
		 * 
		 *	@return void
		 */
		private function updateKillSwitch():void {
			if (Input.keyboard.pressed(DEFAULT_COMMAND_KEY) && Input.keyboard.justPressed(DEFAULT_KILL_SWITCH_KEY)) {
				if (parent) parent.removeChild(this);
			}
		}
		
		/**
		 *	Tar bort och deallokerar objekt som allokerats av 
		 *	motorn.
		 * 
		 *	@return void
		 */
		private function dispose(event:Event):void {
			disposeEvent();
			disposeResolution();
			disposeState();
			disposeInput();
			disposeSession();
			disposeNotices();
			disposeOverlay();
			disposeMemory();
			kill();
		}
		
		/**
		 *	Tar bort aktiva händelselyssnare.
		 * 
		 *	@return void
		 */
		private function disposeEvent():void {
			stage.removeEventListener(Event.ENTER_FRAME, update);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, dispose);
		}
		
		/**
		 *	Tar bort all bakgrundsgrafik som används för att 
		 *	ställa in applikationens standardupplösning.
		 * 
		 *	@return void
		 */
		private function disposeResolution():void {
			this.graphics.clear();
		}
		
		/**
		 *	Avslutar och dellokerar det aktuella 
		 *	applikationstillståndet.
		 * 
		 *	@return void
		 */
		private function disposeState():void {
			if (displayState != null) {
				disposeCurrentDisplayState();
			}
		}
		
		/**
		 *	Deallokerar minne som allokerats av 
		 *	inmatningsenheterna.
		 * 
		 *	@return void
		 */
		private function disposeInput():void {
			Input.dispose();
		}
		
		/**
		 *	Tar bort och deallokerar StickOS SDKs debugg-verktyg.
		 * 
		 *	@return void
		 */
		private function disposeDebug():void {
			removeChild(_debug);
			_debug.dispose();
			_debug = null;
		}
		
		/**
		 *	Avslutar och deallokerar funktionaliteten i StickOS 
		 *	SDKs statiska sessions-klass.
		 * 
		 *	@return void
		 */
		private function disposeSession():void {
			Session.dispose();
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function disposeNotices():void {
			if (_notices != null && _notices.parent != null) {
				_notices.parent.removeChild(_notices);
				_notices.dispose();
				_notices = null;
			}
		}
		
		/**
		 *	Tar bort och deallokerar objekt som placerats i 
		 *	applikationens överdragslager.
		 * 
		 *	@return void
		 */
		private function disposeOverlay():void {
			while (_overlay.numChildren > 0) {
				_overlay.removeChildAt(0);
			}
			
			removeChild(_overlay);
			_overlay = null;
		}
		
		/**
		 *	Tvingar skräpsamlaren att gör en kontroll. 
		 *	Förhoppningsvis ska denna metod ta bort eventuella 
		 *	minnesläckor i systemet.
		 * 
		 *	@return void
		 */
		private function disposeMemory():void {
			System.gc();
		}
		
		//-------------------------------------------------------
		// Private utility methods
		//-------------------------------------------------------
		
		/**
		 *	Övergår från ett DisplayState till ett annat.
		 * 
		 *	@param	state	Nytt DisplayState.
		 * 
		 *	@return void
		 */
		private function swapDisplayState(state:DisplayState):void {
			Input.reset();
			Session.reset();
			disposeCurrentDisplayState();
			appendNewDisplayState(state);
		}
		
		/**
		 *	Tar bort och deallokerar det aktuella 
		 *	applikationstillståndet.
		 * 
		 *	@return void
		 */
		private function disposeCurrentDisplayState():void {
			if (_displayState.layers.container.stage != null) {
				removeChild(_displayState.layers.container);
			}
			
			if (_displayState != null) {
				_displayState.preDispose();
				_displayState.dispose();
				_displayState.postDispose();
				_displayState = null;
			}
			
			disposeMemory();
		}
		
		/**
		 *	Initierar det nya applikationstillståndet.
		 * 
		 *	@param	state	Nytt DisplayState.
		 * 
		 *	@return void
		 */
		private function appendNewDisplayState(state:DisplayState):void {
			_displayState = state;
			addChildAt(_displayState.layers.container, 0);
			_displayState.init();
		}
		
		//-------------------------------------------------------
		// Private final methods
		//-------------------------------------------------------
		
		/**
		 *	Konfigurerar applikationens fullskärmsläge.
		 * 
		 *	@return void
		 */
		private final function setupFullscreen():void {
			var screenRectangle:Rectangle = new Rectangle(0, 0, size.x, size.y);
			
			stage.align 				= StageAlign.TOP_LEFT;
			stage.scaleMode 			= StageScaleMode.NO_SCALE;
			stage.displayState			= StageDisplayState.NORMAL;
			stage.quality				= initRenderQuality;
			stage.focus					= stage;
			stage.fullScreenSourceRect	= screenRectangle;
			
			toggleFullscreen();
		}
		
		/**
		 *	Växlar mellan fullskärmsläget och fönsterläget.
		 * 
		 *	@return void
		 */
		private final function toggleFullscreen():void {
			if (stage.displayState == StageDisplayState.NORMAL)
				stage.displayState  = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			else
				stage.displayState  = StageDisplayState.NORMAL;
		}
		
		/**
		 *	Växlar mellan debugg- och release-läget.
		 * 
		 *	@return void
		 */
		private final function toggleDebugMode():void {
			if (_debug.stage !== null) {
				removeChild(_debug);
				Mouse.hide();
			} else {
				addChild(_debug);
				Mouse.show();
			}
		}
	}
}