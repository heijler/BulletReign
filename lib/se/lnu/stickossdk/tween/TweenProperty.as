package se.lnu.stickossdk.tween {
	
	//-----------------------------------------------------------
	// Internal class
	//-----------------------------------------------------------
	
	/**
	 *	Innehåller information om egenskaper som genomgår 
	 *	interpolering.
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	internal class TweenProperty {
		
		//-------------------------------------------------------
		// Internal properties
		//-------------------------------------------------------
		
		/**
		 *	Egenskapens initiera värde.
		 * 
		 *	@default 0
		 */
		internal var valueStart:Number;
		
		/**
		 *	Egenskapens slutgiltiga värde.
		 * 
		 *	@default 0
		 */
		internal var valueComplete:Number;
		
		/**
		 *	The name of the property to be interpolated.
		 * 
		 *	@default String
		 */
		internal var name:String;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Creates a new class instance.
		 * 
		 *	@param	name			Egenskapens namn.
		 *	@param	valueStart		Egenskapens initiera värde.
		 *	@param	valueComplete	Egenskapens slutgiltiga värde.
		 */
		public function TweenProperty(name:String, valueStart:Number, valueComplete:Number) {
			this.name			= name;
			this.valueStart		= valueStart;
			this.valueComplete	= valueComplete;
		}
		
		//-------------------------------------------------------
		// Internal methods
		//-------------------------------------------------------
		
		/**
		 *	Denna metod är menad att deallokera resurser som 
		 *	objektet allokerat.
		 * 
		 *	@return void
		 */
		public function dispose():void {
			//INGET ATT DEALLOKERA.
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Returnerar en strängrepresentation av objektet. 
		 *	Denna metod är användbar för intern felsökning.
		 *
		 *	@return	String
		 */
		public function toString():String {
			var string:String = "[TweenProperty ";
				string += "name:" + name;
				string += ", ";	
				string += "valueStart:" + String(valueStart);
				string += ", ";
				string += "valueComplete:" + String(valueComplete);
				string += "]";
			
			return string;
		}
	}
}