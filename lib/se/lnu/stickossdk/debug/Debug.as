package se.lnu.stickossdk.debug
{
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.Sprite;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Debug-verktyg för att underlätta utveckling och 
	 *	felsökning i StickOS SDK-baserad miljö.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-22
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Debug extends Sprite {
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@default null
		 */
		private var _version:Version; //TODO: XXX
		
		/**
		 *	Referens till debugg-verktygets FPS-räknare 
		 *	(Frames per second). Egenskapen tilldelas ett värde 
		 *	via konstruktorn. StickOS SDKs standard-FPS är 60, 
		 * 	dvs ca 16 millisekunder mellan varje bildruta.
		 * 
		 *	@default null
		 */
		private var _FPSCounter:FPSCounter;
		
		/**
		 *	Referens till Referens till debugg-verktygets 
		 *	FPS-histogram. Histogrammet för FPS statistik över 
		 *	de senaste 100 sekunderna. Syftet är att kunna 
		 *	övervaka perioder då prestandan försämras. Egenskapen 
		 *	tilldelas ett värde via konstruktorn.
		 * 
		 *	@default null
		 */
		private var _FPSHistogram:FPSHistogram;
		
		/**
		 *	Referens till StickOS SDKs RAM-mätare. Objektet 
		 *	används för att visa hur mycket RAM-minne 
		 *	applikationen allokerar. Använd verktyget för att 
		 *	undvika minnesläckor.
		 * 
		 *	@default null
		 */
		private var _RAMCounter:RAMCounter;
		
		/**
		 *	Debug-verktyg som används för att räkna antalet 
		 *	ljudobjekt som registrerats och används i 
		 *	applikationen. Objektet räknar effekt-ljud.
		 * 
		 *	@default null
		 */
		private var _soundCounter:SoundCounter;
		
		/**
		 *	Debug-verktyg som används för att räkna antalet 
		 *	ljudobjekt som registrerats och används i 
		 *	applikationen. Objektet räknar musik-ljud.
		 * 
		 *	@default null
		 */
		private var _musicCounter:MusicCounter;
		
		/**
		 *	Debug-verktyg som används för att räkna antalet 
		 *	lager som används i det aktuella tillståndet 
		 *	(DisplayState).
		 * 
		 *	@default null
		 */
		private var _layerCounter:LayerCounter;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av Debug.
		 */
		public function Debug() {
			init();
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar debugg-verktygets underliggande 
		 *	komponenter. Alla komponenter ska uppdateras via 
		 *	denna metod.
		 * 
		 *	@return void
		 */
		public function update():void {
			updateFPSCounter();
			updateRAMCounter();
			updateFPSHistogram();
			updateSoundCounter();
			updateMusicCounter();
			updateLayerCounter();
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		public function dispose():void {
			disposeVersion();
			disposeFPSCounter();
			disposeRAMCounter();
			disposeFPSHistogram();
			disposeSoundCounter();
			disposeMusicCounter();
			disposeLayerCounter();
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	Initierar debug-verktygets underliggande komponenter.
		 * 
		 *	@return void
		 */
		private function init():void {
			initVersion();
			initFPSCounter();
			initRAMCounter();
			initFPSHistogram();
			initSoundCounter();
			initMusicCounter();
			initLayerCounter();
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function initVersion():void {
			//TODO: KOMMENTERA
			_version = new Version();
			addChild(_version);
		}
		
		/**
		 *	Initierar debugg-verktygets FPS-räknare.
		 * 
		 *	@return void
		 */
		private function initFPSCounter():void {
			_FPSCounter = new FPSCounter();
			_FPSCounter.x = _version.x + _version.width + 10;
			addChild(_FPSCounter);
		}
		
		/**
		 *	Initierar debugg-verktygets RAM-räknare.
		 * 
		 *	@return void
		 */
		private function initRAMCounter():void {
			_RAMCounter = new  RAMCounter();
			_RAMCounter.x = _FPSCounter.x + _FPSCounter.width + 10;
			addChild(_RAMCounter);
		}
		
		/**
		 *	Initierar debugg-verktygets FPS-histogram.
		 * 
		 *	@return void
		 */
		private function initFPSHistogram():void {
			_FPSHistogram = new FPSHistogram();
			_FPSHistogram.x = _RAMCounter.x + _RAMCounter.width + 10;
			addChild(_FPSHistogram);
		}
		
		/**
		 *	Initierar debugg-verktygets ljud-räknare (effekter).
		 * 
		 *	@return void
		 */
		private function initSoundCounter():void {
			_soundCounter = new SoundCounter();
			_soundCounter.x = _FPSHistogram.x + _FPSHistogram.width + 10;
			addChild(_soundCounter);
		}
		
		/**
		 *	Initierar debugg-verktygets ljud-räknare (musik).
		 * 
		 *	@return void
		 */
		private function initMusicCounter():void {
			_musicCounter = new MusicCounter();
			_musicCounter.x = _soundCounter.x + _soundCounter.width + 10;
			addChild(_musicCounter);
			
		}
		
		/**
		 *	Initierar debugg-verktygets lager-räknare.
		 * 
		 *	@return void
		 */
		private function initLayerCounter():void {
			_layerCounter = new LayerCounter();
			_layerCounter.x = _musicCounter.x + _musicCounter.width + 10;
			addChild(_layerCounter);
			
		}
		
		/**
		 *	Uppdaterar debugg-verktygets FPS-räknare.
		 * 
		 *	@return void
		 */
		private function updateFPSCounter():void {
			_FPSCounter.update();
		}
		
		/**
		 *	Uppdaterar debugg-verktygets RAM-räknare.
		 * 
		 *	@return void
		 */
		private function updateRAMCounter():void {
			_RAMCounter.update();
		}
		
		/**
		 *	Uppdaterar debugg-verktygets FPS-histogram.
		 * 
		 *	@return void
		 */
		private function updateFPSHistogram():void {
			_FPSHistogram.update();
		}
		
		/**
		 *	Uppdaterar debugg-verktygets ljudräknare (effekter).
		 * 
		 *	@return void
		 */
		private function updateSoundCounter():void {
			_soundCounter.update();
		}
		
		/**
		 *	Uppdaterar debugg-verktygets ljudräknare (musik).
		 * 
		 *	@return void
		 */
		private function updateMusicCounter():void {
			_musicCounter.update();
		}
		
		/**
		 *	Uppdaterar debugg-verktygets lagerräknare.
		 * 
		 *	@return void
		 */
		private function updateLayerCounter():void {
			_layerCounter.update();
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function disposeVersion():void {//TODO: XXX
			removeChild(_version);
			_version.dispose();
			_version = null;
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function disposeFPSCounter():void {
			removeChild(_FPSCounter);
			_FPSCounter.dispose();
			_FPSCounter = null;
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function disposeRAMCounter():void {
			removeChild(_RAMCounter);
			_RAMCounter.dispose();
			_RAMCounter = null;
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function disposeFPSHistogram():void {
			removeChild(_FPSHistogram);
			_FPSHistogram.dispose();
			_FPSHistogram = null;
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function disposeSoundCounter():void {
			removeChild(_soundCounter);
			_soundCounter.dispose();
			_soundCounter = null;
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function disposeMusicCounter():void {
			removeChild(_musicCounter);
			_musicCounter.dispose();
			_musicCounter = null;
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function disposeLayerCounter():void {
			removeChild(_layerCounter);
			_layerCounter.dispose();
			_layerCounter = null;
		}
	}
}