package se.lnu.stickossdk.media {
	
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import se.lnu.stickossdk.util.MathUtils;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	SoundInstance representerar en unik ljudinstans.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class SoundInstance {
		
		//-------------------------------------------------------
		// Public getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Om ljudet är aktivt eller inte (mute).
		 */
		public function get mute():Boolean {
			return _mute;
		}
		
		/**
		 *	@private
		 */
		public function set mute(value:Boolean):void {
			_soundChannel.soundTransform = value ? _soundTransformMuted : _soundTransform;
			_mute = value;
		}
		
		/**
		 *	Ljudinstansens individuella ljudvolym.
		 */
		public function get volume():Number {
			return _volume;
		}
		
		/**
		 *	@private
		 */
		public function set volume(value:Number):void {
			_volume = MathUtils.clamp(value, 0, 1);
			updateVolume();
		}
		
		//-------------------------------------------------------
		// Internal properties
		//-------------------------------------------------------
		
		/**
		 *	Om ljudinstansen har nått sin slutpunkt eller inte. 
		 *	När en ljudinstans flaggas som färdig (complete) 
		 *	kommer den att tas bort och deallokeras av instansens 
		 *	överliggande ljudobjekt.
		 * 
		 *	@default false
		 */
		internal var complete:Boolean;
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Referens till det ljudobjekt (Sound) som används för 
		 *	att genomföra uppspelningen.
		 * 
		 *	@default null
		 * 
		 *	@see flash.media.Sound
		 */
		private var _sound:Sound;
		
		/**
		 *	Detta objekt används för att få tillgång till en 
		 *	tillgänglig ljudkanal för uppspelning. Om det inte 
		 *	finns några tillgängliga ljudkanaler är detta objekt 
		 *	null.
		 * 
		 *	@default SoundChannel
		 * 
		 *	@see flash.media.SoundChannel
		 */
		private var _soundChannel:SoundChannel = new SoundChannel();
		
		/**
		 *	Objektet används för att applicera justeringseffekter 
		 *	på en befintlig ljudkanal. Detta objekt är reserverat 
		 *	för den vanliga ljuduppspelningen.
		 * 
		 *	@default SoundTransform
		 * 
		 *	@see flash.media.SoundTransform
		 */
		private var _soundTransform:SoundTransform = new SoundTransform();
		
		/**
		 *	Objektet används för att applicera justeringseffekter 
		 *	på en befintlig ljudkanal. Detta objekt är reserverat 
		 *	för uppspelning av ljudinstanser vars ljud har 
		 *	inaktivares (mute).
		 * 
		 *	@default SoundTransform
		 * 
		 *	@see flash.media.SoundTransform
		 */
		private var _soundTransformMuted:SoundTransform = new SoundTransform(0);
		
		/**
		 *	Om ljudinstansen befinner sig under uppspelning.
		 * 
		 *	@default false
		 */
		private var _isPlaying:Boolean;
		
		/**
		 *	Ljudinstansens nuvarande position i uppspelningen. 
		 *	Positionen beräknas i millisekunder.
		 * 
		 *	@default 0
		 */
		private var _position:Number = 0;
		
		/**
		 *	Om ljudinstansens ljudvolym är inaktiverad eller 
		 *	inte.
		 * 
		 *	@default false
		 */
		private var _mute:Boolean;
		
		/**
		 *	Ljudinstansens aktuella ljudvolym.
		 * 
		 *	@default 1
		 */
		private var _volume:Number = 1;
		
		//-------------------------------------------------------
		// Constructor methods
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av SoundInstance.
		 * 
		 *	@param	sound	Instansens ljudkälla.
		 */
		public function SoundInstance(sound:Sound) {
			_sound = sound;	
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Påbörjar uppspelningen av en ljudinstans. Som 
		 *	standard återupprepas inte uppspelningen. 
		 * 
		 *	@param	loops	Antalet återupprepningar.
		 * 
		 *	@return	void
		 */
		public function play(loops:int = 0):void {
			if (_isPlaying == false) {
				initPlayback(loops);
			}
		}
		
		/**
		 *	Återupptar uppspelningen den aktuella ljudinstansen.
		 * 
		 *	@return	void
		 */
		public function resume():void {
			play();
		}
		
		/**
		 *	Pausar ljuduppspelningen av den aktuella 
		 *	ljudinstansen. 
		 * 
		 *	@return	void
		 */
		public function pause():void {
			if (_soundChannel != null) {
				_position = _soundChannel.position;
				_soundChannel.stop();
			}
			
			_isPlaying = false;
		}
		
		/**
		 *	Stoppar uppspelningen av den aktuella ljudinstansen. 
		 *	När en ljudinstans stoppas kommer den att flaggas som 
		 *	färdig och därmed att tas bort och deallokeras av den 
		 *	överliggande ljudobjektet.
		 * 
		 *	@return	void
		 */
		public function stop():void {
			pause();
			_position = 0;
			complete = true;
		}
			
		//-------------------------------------------------------
		// Internal methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar ljudinstansen.
		 * 
		 *	@return	void
		 */
		internal function update():void {
			
		}
		
		/**
		 *	Deallokerar ljudinstansens underliggande objekt.
		 * 
		 *	@return	void
		 */
		internal function dispose():void {
			disposeSound();
			disposeSoundChannel();
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	Initierar en ny ljuduppspelning. Händelselyssnare 
		 *	används för att avgöra när uppspelningen är klar.
		 * 
		 *	@param	loops	Antalet återupprepningar.
		 * 
		 *	@return	void
		 */
		private function initPlayback(loops:int = 0):void {
			_isPlaying = true;
			_soundChannel = _sound.play(_position, loops);
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		
		/**
		 *	Denna metod uppdaterar ljudinstansens ljudvolym. 
		 *	Metoden bör endast aktiveras när en förändring i 
		 *	ljudnivå har registrerats. Detta för att undvika 
		 *	negativ inverkan på prestandan.
		 * 
		 *	@return	void
		 */
		private function updateVolume():void {
			_soundTransform.volume = _volume;
			_soundChannel.soundTransform = _soundTransform;
		}
		
		/**
		 *	Denna metod aktiveras när ljudinstansens uppspelning 
		 *	är klar. Syfter är att flagga ljudinstansen som 
		 *	"complete" så att den kan tas bort från listan över 
		 *	aktiva ljudinstanser. Listan finns i ljudinstansens 
		 *	överliggande ljudobjekt.
		 * 
		 *	@param	event	Händelsen som aktiverade metoden.
		 * 
		 *	@return	void
		 */
		private function onSoundComplete(event:Event):void {
			stop();
		}
		
		/**
		 *	Denna metod rensar upp minnet som används av 
		 *	ljud-objektet.
		 * 
		 *	@return	void
		 */
		private function disposeSound():void {
			stop();
			closeSoundStream();
			_sound = null;
		}
		
		/**
		 *	Avslutar alla eventuella ljud-strömningar som 
		 *	relaterar till ljud-objektet.
		 * 
		 *	@return	void
		 */
		private function closeSoundStream():void {
			try {_sound.close()}
			catch (error:IOError) {}
		}
		
		/**
		 *	Metoden stoppar och deallokerar allt minne som 
		 *	allokerats av ljudkanalen som används för att spela 
		 *	upp ljud-objektet.
		 * 
		 *	@return	void
		 */
		private function disposeSoundChannel():void {
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			_soundChannel.stop();
			_soundChannel = null;
		}
	}
}