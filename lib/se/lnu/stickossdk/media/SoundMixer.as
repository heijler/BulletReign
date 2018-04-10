package se.lnu.stickossdk.media
{
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import se.lnu.stickossdk.util.MathUtils;

	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	SoundMixer är en klass som simulerar en ljudkanal. Syftet 
	 *	är att hantera och spela upp ljud.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class SoundMixer {
		
		//-------------------------------------------------------
		// Public getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Register innehållande registrerade ljudresurser. En 
		 *	ljudresurs är inte ett uppspelningsbart objekt utan 
		 *	enbart rådata.
		 */
		public function get sources():SoundSources {
			return _soundSources;
		}
		
		/**
		 *	Antalet ljud-objekt som registrerats i denna 
		 *	ljudmixer.
		 */
		public function get numSoundObjects():int {
			return _soundObjects.length;
		}
		
		/**
		 *	Antalet ljudresurser som registrerats i denna 
		 *	ljudmixer.
		 */
		public function get numSoundSources():int {
			return _soundSources.length;
		}
		
		/**
		 *	Den aktuella volymen.
		 */
		public function get volume():Number {
			return _volume;
		}
		
		/**
		 *	@private
		 */
		public function set volume(value:Number):void {
			_volume = MathUtils.clamp(value, 0, 1);
			updateSoundObjectsVolume();
		}
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	En lista innehållande samtliga ljud-objekt som 
		 *	registrerats i denna ljudmixer. Varje förekomst kan 
		 *	vara en referens till en unik eller befintlig 
		 *	ljudresurs.
		 * 
		 *	@default Vector
		 */
		private var _soundObjects:Vector.<SoundObject> = new Vector.<SoundObject>();
		
		/**
		 *	Innehåller ett register över ljudresurser. Ljud som 
		 *	används via denna ljudmixer måste registreras i detta 
		 *	register.
		 * 
		 *	@default SoundSources
		 */
		private var _soundSources:SoundSources = new SoundSources();
		
		/**
		 *	Den aktuella ljudvolymen som består av ett decimaltal 
		 *	mellan 0 och 1.
		 * 
		 *	@default 1
		 */
		private var _volume:Number = 1;
		
		//-------------------------------------------------------
		// Constructor methods
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av SoundMixer.
		 */
		public function SoundMixer() {
			
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Hämtar ett ljudobjekt för uppspelning. För att hämta 
		 *	ett ljudobjekt används samma id som när ljudresursen 
		 *	registrerades.
		 * 
		 *	@param	id		Id till den ljudresurs som objektet ska använda.
		 *	@param	reuse	Huruvida objektet får förekomma i flera instanser.
		 *	@param	unique	Om objektet kan skapa fler än en aktiv ljudinstans.
		 * 
		 *	@return	SoundObject
		 */
		public function get(id:String, reuse:Boolean = true, unique:Boolean = true):SoundObject {	
			var index:int = soundObjectExists(id);
			if (reuse && (index != -1)) return _soundObjects[index];
			else return createSoundObject(id, unique);
		}
		
		/**
		 *	Stoppar alla ljuduppspelningar som registrerats i 
		 *	ljudmixern.
		 * 
		 *	@return	void
		 */
		public function stop():void {
			for (var i:int = 0; i < _soundObjects.length; i++) {
				_soundObjects[i].stop();
			}
		}
		
		//-------------------------------------------------------
		// Internal methods
		//-------------------------------------------------------
		
		/**
		 *	Intern metod för att uppdatera alla ljudobjekt som 
		 *	registrerats i ljudmixern.
		 * 
		 *	@return	void
		 */
		internal function update():void {
			for (var i:int = 0; i < _soundObjects.length; i++) {
				_soundObjects[i].update();
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return	void
		 */
		internal function reset():void {
			for (var i:int = 0; i < _soundObjects.length; i++) {
				_soundObjects[i].stop();
				_soundObjects[i].dispose();
				_soundObjects[i] = null;
				_soundObjects.splice(i, 1);
			}
			
			_soundObjects.length = 0;
		}
		
		/**
		 *	Tar bort och deallokerar alla ljudobjekt som 
		 *	registrerats i ljudmixern.
		 * 
		 *	@return	void
		 */
		internal function dispose():void {
			disposeSoundObjects();
			disposeSoundSources();
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar volymen för samtliga registrerade 
		 *	ljudobjekt.
		 * 
		 *	@return	void
		 */
		private function updateSoundObjectsVolume():void {
			for (var i:int = 0; i < _soundObjects.length; i++) {
				updateSoundObjectVolume(i);
			}
		}
		
		/**
		 *	Uppdaterar volymen för ett specifikt ljudobjekt.
		 * 
		 *	@param	index	Index till det ljudobjekt som ska uppdateras.
		 * 
		 *	@return	void
		 */
		private function updateSoundObjectVolume(index:int):void {
			_soundObjects[index].volumeMaster = _volume;
		}
		
		/**
		 *	Kontrollerar om ett ljudobjekt existerar i listan 
		 *	över registrerade ljudobjekt.
		 * 
		 *	@param	id	Id till det objekt som undersöks.
		 * 
		 *	@return	Objektets index, returnerar -1 om objektet inte hittades.
		 */
		private function soundObjectExists(id:String):int {
			var index:int = -1;
			for (var i:int = 0; i < _soundObjects.length; i++) {
				if (_soundObjects[i].id == id) {
					index = i;
					break;
				}
			}
			
			return index;
		}
		
		/**
		 *	Skapar ett nytt ljudobjekt och lägger till det i 
		 *	listan över tillgängliga ljudobjekt.
		 * 
		 *	@param	id		Objektets tilltänkta id.
		 *	@param	unique	Om det endast får förekomma en ljudinstans.
		 * 
		 *	@return	Referens till det nya ljudobjektet.
		 */
		private function createSoundObject(id:String, unique:Boolean = false):SoundObject {
			var sound:SoundObject = new SoundObject(id, sources.get(id), unique);
			_soundObjects.push(sound);
			return sound;
		}
		
		/**
		 *	Tar bort och deallokerar samtliga registrerade 
		 *	ljudobjekt.
		 * 
		 *	@return	void
		 */
		private function disposeSoundObjects():void {
			for (var i:int = 0; i < _soundObjects.length; i++) {
				disposeSoundObject(i);
			}
			
			_soundObjects.length = 0;
		}
		
		/**
		 *	Tar bort och deallokerar ett specifikt ljudobjekt.
		 * 
		 *	@param	index	Ljudobjektets index.
		 * 
		 *	@return	void
		 */
		private function disposeSoundObject(index:int):void {
			_soundObjects[index].dispose();
			_soundObjects[index] = null;
			_soundObjects.splice(index, 1);
		}
		
		/**
		 *	Tar bort och deallokerar de ljudresurser som 
		 *	allokerats i ljudkanalen (SoundMixer).
		 * 
		 *	@return	void
		 */
		private function disposeSoundSources():void {
			_soundSources.dispose();
			_soundObjects = null;
		}
	}
}