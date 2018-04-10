package se.lnu.stickossdk.fx
{
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Effects är en klass för att hantera StickOS SDK-baserade 
	 *	effekter. 
	 *
	 *	@version	0.8
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-17
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 * 
	 *	@TODO: REMOVE(effect:Effect)
	 */
	public class Effects {
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	En lista innehållande registrerade effekter. 
		 *	Samtliga effekter måste vara baserade på 
		 *	Effect-objektet.
		 * 
		 *	@default Vector
		 * 
		 *	@see se.lnu.stickossdk.fx.Effect
		 */
		private var _effects:Vector.<Effect> = new Vector.<Effect>();
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av Effects.
		 */
		public function Effects() {
			
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Lägger till en ny effekt i effekthanteraren. En 
		 *	effekt utför inte sin funktionalitet om den inte 
		 *	läggs till i en effekthanterare.
		 * 
		 *	@param	effect	Effekten som ska läggas till.
		 * 
		 *	@return Effekten som lagts till i effehanteraren.
		 */
		public function add(effect:Effect):Effect {
			//TODO: HINDA SAMMA REFERENS ATT FÖREKOMMA FLERA GÅNGER I LISTAN
			_effects.push(effect);
			effect.init();
			return effect;
		}
		
		/**
		 *	Uppdaterar samtliga registrerade effekter.
		 * 
		 *	@return void
		 */
		public function update():void {
			updateEffects();
		}
		
		/**
		 *	Förbereder objektet för borttagning. Samtliga 
		 *	registrerade effekter deallokeras.
		 * 
		 *	@return void
		 */
		public function dispose():void {
			disposeEffects();
		}
		
		//-------------------------------------------------------
		// private methods
		//-------------------------------------------------------
		
		/**
		 *	Metoden uppdaterar aktiva effekter och tar bort 
		 *	effekter som har flaggats som slutförda.
		 * 
		 *	@return void
		 */
		private function updateEffects():void {
			for (var i:int = 0; i < _effects.length; i++) {
				if (_effects[i].complete == false) _effects[i].update();
				else disposeEffect(i);
			}
		}
		
		/**
		 *	Tar bort och deallokerar samtliga registrerade 
		 *	effekter.
		 * 
		 *	@param	i	Index till den effekt som ska deallokeras.
		 * 
		 *	@return void
		 */
		private function disposeEffects():void {
			for (var i:int = 0; i < _effects.length; i++) {
				disposeEffect(i);
			}
			
			_effects.length = 0;
		}
		
		/**
		 *	Denna metod tar bort och deallokerar registrerade 
		 *	effekter baserat på effektens index i effektlistan. 
		 *	Effekten får möjlighet att genomföra en intern 
		 *	rensning innan referensen sätts till null. 
		 *	Skräpsamlaren kommer att ta bort effekten från minnet 
		 *	så snart som möjligt. 
		 * 
		 *	@param	i	Index till den effekt som ska deallokeras.
		 * 
		 *	@return void
		 */
		private function disposeEffect(i:int):void {
			_effects[i].dispose();
			_effects[i] = null;
			_effects.splice(i, 1);
		}
	}
}