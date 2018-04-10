package se.lnu.stickossdk.media {
	
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.media.Sound;
	
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.util.MathUtils;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Ett ljudobjekt för att hantera en ljudresurs.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class SoundObject {
		
		//-------------------------------------------------------
		// Public getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	...
		 */
		public function get isPlaying():Boolean {
			for (var i:int = 0; i < _soundInstances.length; i++ ) {
				if (_soundInstances[i].complete == false) return true;
			}
			
			return false;
		}
		
		/**
		 *	Om ljudvolymen är avslagen (muted) eller inte.
		 */
		public function get mute():Boolean {
			return _mute;
		}
		
		/**
		 *	@private
		 */
		public function set mute(value:Boolean):void {
			muteSoundInstances(value);
			_mute = value;
		}
		
		/**
		 *	Den aktuella ljudvolymen för ljudobjektet.
		 */
		public function get volume():Number {
			return _volume;
		}
		
		/**
		 *	@private
		 */
		public function set volume(value:Number):void {
			_volume = MathUtils.clamp(value, 0, 1);
			updateSoundInstancesVolume();
		}
		
		/**
		 *	Den aktuella ljudobjektets huvudvolym. Detta är 
		 *	maxvolymen för ljudobjektets underliggande 
		 *	ljudinstanser.
		 */
		public function get volumeMaster():Number {
			return _volumeMaster;
		}
		
		/**
		 *	@private
		 */
		public function set volumeMaster(value:Number):void {
			_volumeMaster = MathUtils.clamp(value, 0, 1);
			updateSoundInstancesVolume();
		}
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Om ljudobjektet ska använda kontinuerlig 
		 *	ljuduppspelning. Detta innebär att ljuduppspelningen 
		 *	enbart fortlöper såvida play-metoden är aktiv. Denna 
		 *	inställning förutsätter att ljudobjektet inte får 
		 *	instansiera mer än en aktiv instans per uppspelning.
		 * 
		 *	@default false
		 */
		public var continuous:Boolean;
		
		/**
		 *	Om den kontinuerlig uppspelningen ska starta om 
		 *	varje gång som den avbryts. Denna inställning 
		 *	förutsätter att ljudobjektet inte får instansiera 
		 *	mer än en aktiv instans per uppspelning.
		 * 
		 *	@default true
		 */
		public var continuousRestarting:Boolean = true;
		
		//-------------------------------------------------------
		// Internal properties
		//-------------------------------------------------------
		
		/**
		 *	Ljudobjektets unika id.
		 * 
		 *	@default ""
		 */
		internal var id:String = "";
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Referens till ljudobjektets ljudresurs.
		 * 
		 *	@default Sound
		 */
		private var _source:Sound;
		
		/**
		 *	Om ljudobjektet kan instansiera flera ljudinstanser 
		 *	eller om det bara får förekomma en unik instans.
		 * 
		 *	@default false
		 */
		private var _unique:Boolean;
		
		/**
		 *	En lista innehållande alla ljudinstanser som 
		 *	instansierats av ljudobjektet. Ljudinstanser som är 
		 *	uppspelade tas automatiskt bort från listan.
		 * 
		 *	@default Vector
		 */
		private var _soundInstances:Vector.<SoundInstance> = new Vector.<SoundInstance>();
		
		/**
		 *	Om ljudvolymen är avslagen (muted) eller inte.
		 * 
		 *	@default false
		 */
		private var _mute:Boolean;
		
		/**
		 *	Den aktuella ljudvolymen för ljudobjektet.
		 * 
		 *	@default 1
		 */
		private var _volume:Number = 1;
		
		/**
		 *	Den aktuella ljudobjektets huvudvolym. Detta är 
		 *	maxvolymen för ljudobjektets underliggande 
		 *	ljudinstanser.
		 * 
		 *	@default 1
		 */
		private var _volumeMaster:Number = 1;
		
		//-------------------------------------------------------
		// Constructor methods
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av SoundObject.
		 * 
		 *	@param	id		Ljudobjektets unika id.
		 *	@param	source	Ljudobjektets ljudresurs.
		 * 	@param	unique	Om ljudobjektet enbart frår instansiera en ljudinstans.
		 */
		public function SoundObject(id:String, source:Class, unique:Boolean = false) {
			this.id = id;
			_source = new source() as Sound;
			_unique = unique;
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Påbörjar en ny ljuduppspelning av ljudobjektet. När 
		 *	en ny ljuduppspelning påbörjas skapas en ljudinstans 
		 *	som referens till ljuduppspelningen. Via denna 
		 *	referens går det att hantera ljudinstanser som 
		 *	instansierats från ljudobjekt.
		 * 
		 *	@param	loops	Antalet gånger ljudinstansen ska återuppspelas.
		 * 
		 *	@return	Referens till den påbörjade ljuduppspelningen.
		 */
		public function play(loops:int = 0):SoundInstance {
			//@TODO: LOOPARNA REDUCERAS INTE VID NY PLAY() 
			if (supportsContinuous()) return resumeContinuousSoundInstances();
			return _unique ? playOldSoundInstance(loops) : playNewSoundInstance(loops);
		}
		
		/**
		 *	Stoppar ljudobjektets uppspelning, detta innefattar 
		 *	alla ljudinstanser som skapats från detta 
		 *	ljudobjekt.
		 * 
		 *	@return	void
		 */
		public function stop():void {
			supportsContinuous() ? stopContinuousSoundInstances() : stopSoundInstances();
		}
		
		/**
		 *	Applicerar en toningseffekt på ljudobjektets 
		 *	uppspelning, detta innefattar alla ljudinstanser som 
		 *	skapats från detta ljudobjekt.
		 * 
		 *	@return	void
		 */
		public function fade(volume:Number, duration:int = 1000, onComplete:Function = null):void {
			Session.tweener.add(this, {
				volume:		volume,
				duration:	duration,
				onComplete:	onComplete
			});
		}
		
		/**
		 *	Tar bort och deallokerar samtliga ljudinstanser som 
		 *	skapats från detta ljudobjekt.
		 * 
		 *	@return	void
		 */
		public function dispose():void {
			for (var i:int = 0; i < _soundInstances.length; i++) {
				disposeSoundInstance(i);
			}
			
			_soundInstances.length = 0;
		}
		
		//-------------------------------------------------------
		// Internal methods
		//-------------------------------------------------------
		
		/**
		 *	Intern metod som uppdaterar samtliga ljudinstanser 
		 *	skapats av detta ljudobjekt.
		 * 
		 *	@return	void
		 */
		internal function update():void {	
			for (var i:int = 0; i < _soundInstances.length; i++) {
				if (_soundInstances[i].complete == false) updateSoundInstance(i);
				else disposeSoundInstance(i);
			}
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar all ljudinstanser så att de synkroniserar 
		 *	sin ljudvolym med ljudobjektet.
		 * 
		 *	@return	void
		 */
		private function updateSoundInstancesVolume():void {	
			for (var i:int = 0; i < _soundInstances.length; i++) {
				updateSoundInstanceVolume(i);
			}
		}
		
		/**
		 *	Uppdaterar en ljudinstans ljudvolym så att den 
		 *	synkroniseras med ljudobjektets ljudvolym.
		 * 
		 * 	@param	index	Index till den ljudinstans som ska synkroniseras.
		 * 
		 *	@return	void
		 */
		private function updateSoundInstanceVolume(index:int):void {	
			_soundInstances[index].volume = _volume * _volumeMaster;
		}
		
		/**
		 *	Skapar och påbörjar uppspelningen av en ny 
		 *	ljudinstans. Samtliga ljudinstanser sparas och 
		 *	hanteras internt av ljudobjektet.
		 * 
		 *	@param	loops	Antal återupprepningar.
		 * 
		 *	@return	void
		 */
		private function playNewSoundInstance(loops:int = 0):SoundInstance {	
			var sound:SoundInstance = new SoundInstance(_source);
				sound.play(loops);
			_soundInstances.push(sound);
			return sound;
		}
		
		/**
		 *	Återanvänder en befintlig ljudinstans för att påbörja 
		 *	en ny uppspelning.
		 * 
		 *	@param	loops	Antal återupprepningar.
		 * 
		 *	@return	void
		 */
		private function playOldSoundInstance(loops:int = 0):SoundInstance {	
			stopSoundInstances();
			return playNewSoundInstance(loops);
		}
		
		/**
		 *	Återuppta uppspelningen av ljudinstanser med 
		 *	kontinuelig uppspelning. Notera att den enbart kan 
		 *	förekomma en ljudinstans då kontinuelig uppspelning 
		 *	används.
		 * 
		 *	@return	void
		 */
		private function resumeContinuousSoundInstances():SoundInstance {	
			//@TODO: UNSAFE REFERENCE
			_soundInstances[0].resume();
			return _soundInstances[0];
		}
		
		/**
		 *	Stoppar ljuduppspelning av ljudinstanser med 
		 *	kontinuelig uppspelning. Notera att den enbart kan 
		 *	förekomma en ljudinstans då kontinuelig uppspelning 
		 *	används.
		 * 
		 *	@return	void
		 */
		private function stopContinuousSoundInstances():void {	
			if (supportsContinuous() && continuousRestarting) _soundInstances[0].pause();
			else if (supportsContinuous()) _soundInstances[0].stop();
		}
		
		/**
		 *	Stoppar samtliga registerade ljudinstanser.
		 * 
		 *	@return	void
		 */
		private function stopSoundInstances():void {	
			for (var i:int = 0; i < _soundInstances.length; i++) {
				stopSoundInstance(i);
			}
		}
		
		/**
		 *	Stoppar en specifik ljudinstans.
		 * 
		 *	@param	index	Index till ljudinstansen.
		 * 
		 *	@return	void
		 */
		private function stopSoundInstance(index:int):void {	
			_soundInstances[index].stop();
		}
		
		/**
		 *	Uppdaterar en specifik ljudinstans.
		 * 
		 *	@param	index	Index till ljudinstansen.
		 * 
		 *	@return	void
		 */
		private function updateSoundInstance(index:int):void {	
			_soundInstances[index].update();
		}
		
		/**
		 *	Stänger av eller aktiverar ljuduppspelningen för 
		 *	samtliga ljuduppspelningar.
		 * 
		 *	@param	mute	Om mute ska aktiveras.
		 * 
		 *	@return	void
		 */
		private function muteSoundInstances(mute:Boolean = true):void {	
			for (var i:int = 0; i < _soundInstances.length; i++) {
				muteSoundInstance(i, mute);
			}
		}
		
		/**
		 *	Stänger av eller aktiverar ljuduppspelningen för en 
		 *	specifik ljudinstans.
		 * 
		 *	@param	index	Index till ljudinstansen.
		 *	@param	mute	Om mute ska aktiveras.
		 * 
		 *	@return	void
		 */
		private function muteSoundInstance(index:int, mute:Boolean = true):void {	
			_soundInstances[index].mute = mute;
		}
		
		/**
		 *	Deallokerar en specifik ljudinstans. Instansen kommer 
		 *	att tas bort från den interna listan över 
		 *	registrerade ljudinstanser och minnet kommer att 
		 *	deallokeras.
		 * 
		 *	@param	index	Index till ljudinstansen.
		 * 
		 *	@return	void
		 */
		private function disposeSoundInstance(index:int):void {	
			_soundInstances[index].dispose();
			_soundInstances[index] = null;
			_soundInstances.splice(index, 1);
		}
		
		/**
		 *	Kontrollerar om ljudobjektet (SoundObject) stödjer 
		 *	kontinuerlig uppspelning. 
		 * 
		 *	@return	void
		 */
		private function supportsContinuous():Boolean {	
			return ((_soundInstances.length > 0) && 
					(_unique == true) && 
					(continuous == true));
		}
	}
}