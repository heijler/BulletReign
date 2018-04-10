package se.lnu.stickossdk.display {
	
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.Sprite;
	
	import se.lnu.stickossdk.util.ObjectUtils;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Basklass för grafiska objekt i StickOS SDK. Alla grafiska 
	 *	objekt som har behov av att initieras, uppdateras och 
	 *	deallokeras kan använda denna basklass.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-23
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class DisplayStateLayerSprite extends Sprite {
		
		//-------------------------------------------------------
		// Public properties
		//-------------------------------------------------------
		
		/**
		 *	Om objektet automatiskt ska uppdateras av sitt lager. 
		 *	Om denna egenskap sätts till <code>true</code> kommer 
		 *	objektets update-metod att aktiveras en gång per 
		 *	bildruta (frame). Som standard är denna egenskap satt 
		 *	till <code>true</code>.
		 * 
		 *	@default true
		 */
		public var autoUpdate:Boolean = true;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av DisplayStateLayers.
		 */
		public function DisplayStateLayerSprite() {
			super();
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Denna metod aktiveras automatiskt när objektet läggs 
		 *	till i ett lager. Metoden är tänkt att överskrivas av 
		 *	sin super-klass.
		 * 
		 *	@return void
		 */
		public function init():void {
			//ÖVERSKRIV FRÅN SUPER
		}
		
		/**
		 *	Denna metod aktiveras automatiskt en gång per 
		 *	bildruta (frame) när objektet finns tillgängligt i 
		 *	ett lager. En förutsättning för att update-metoden 
		 *	ska aktiveras är att egenskapen autoUpdate är satt 
		 *	till <code>true<code>. Metoden är tänkt att 
		 *	överskrivas av sin super-klass.
		 * 
		 *	@return void
		 */
		public function update():void {
			//ÖVERSKRIV FRÅN SUPER
		}
		
		/**
		 *	Denna metod aktiveras automatiskt när ett lager 
		 *	(DisplayStateLayer) begär att ta bort och deallokera 
		 *	ett objekt (DisplayStateLayerSprite). Denna metod ska 
		 *	överskrivas av super-klassen och innehålla 
		 *	deallokeringskod för objektet.
		 * 
		 *	@return void
		 */
		public function dispose():void {
			//ÖVERSKRIV FRÅN SUPER
			trace("[STICKOS SDK: <<WARNING>> NO DESPOSE CODE FOR: " + ObjectUtils.getClass(this)+"]");
		}
	}
}