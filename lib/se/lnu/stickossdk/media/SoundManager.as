package se.lnu.stickossdk.media {
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	SoundManager är StickOS SDKs klass för att hantera ljud 
	 *	och musik. Klassen erbjuder två fördefinierade 
	 *	ljudkanaler; en för effekter och en för ljud.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-19
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class SoundManager {
		
		//-------------------------------------------------------
		// Public getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Ljudkanal för musikuppspelning.
		 */
		public function get musicChannel():SoundMixer {
			return _music;
		}
		
		/**
		 *	Ljudkanal för ljudeffektsuppspelning.
		 */
		public function get soundChannel():SoundMixer {
			return _sound;
		}
		
		/**
		 *	...
		 */
		public function get masterChannel():SoundMixer {
			return _master;
		}
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Ljudkanal för musikuppspelning.
		 * 
		 *	@default SoundMixer
		 */
		private var _music:SoundMixer = new SoundMixer();
		
		/**
		 *	Ljudkanal för ljudeffektsuppspelning.
		 * 
		 *	@default SoundMixer
		 */
		private var _sound:SoundMixer = new SoundMixer();
		
		/**
		 *	...
		 * 
		 *	@default SoundMixer
		 */
		private var _master:SoundMixer = new SoundMixer();
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av SoundManager.
		 */
		public function SoundManager() {
			
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar ljudhanterarens ljudkanaler.
		 * 
		 *	@return	void
		 */
		public function update():void {	
			_music.update();
			_sound.update();
			_master.update();
		}
		
		/**
		 *	...
		 * 
		 *	@return	void
		 */
		public function reset():void {	
			_music.stop();
			_sound.stop();
		}
		
		/**
		 *	Avslutar all ljud- och musikuppspelning. Alla 
		 *	ljudresurser som lagrats i ljudkanalerna kommer att 
		 *	deallokeras och rensas bort.
		 * 
		 *	@return	void
		 */
		public function dispose():void {	
			_music.dispose();
			_sound.dispose();
			_master.dispose();
		}
	}
}