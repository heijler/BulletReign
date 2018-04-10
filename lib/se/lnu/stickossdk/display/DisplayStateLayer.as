package se.lnu.stickossdk.display {
	
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import se.lnu.stickossdk.state.StateMachine;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Ett renderingslager för DisplayState. Lagret renderar 
	 *	grafik som placerats i lagret med addChild().
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-23
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class DisplayStateLayer extends Sprite {
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av DisplayStateLayer.
		 */
		public function DisplayStateLayer() {
			
		}
		
		//-------------------------------------------------------
		//	Override Public methods
		//-------------------------------------------------------
		
		/**
		 *	Lägger till ett nytt DisplayObjekt i 
		 *	renderingslagret. Om det tillagda objektet är av 
		 *	typen DisplayStateLayerSprite kommer objektet 
		 *	automatiskt att initieras, uppdateras och 
		 *	deallokeras.
		 * 
		 *	@param	child	Objekt som ska läggas till i lagret.
		 * 
		 *	@return DisplayObject
		 */
		override public function addChild(child:DisplayObject):DisplayObject {
			super.addChild(child);
			
			//@TODO: FIX
			if (child is DisplayStateLayerSprite) {
				var c:DisplayStateLayerSprite = child as DisplayStateLayerSprite;
				c.init();
			}
			
			return child;
		}
		
		//-------------------------------------------------------
		//	Public methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar de barn-objekt som är av typen 
		 *	DisplayStateLayerSprite.
		 * 
		 *	@return void
		 */
		public function update():void {
			var child:DisplayStateLayerSprite;
			for (var i:int = 0; i < numChildren; i++) {
				child = getChildAt(i) as DisplayStateLayerSprite;
				if (child is DisplayStateLayerSprite && child.autoUpdate) {
					child.update();
				}
			}
		}
		
		/**
		 *	Metoden tar bort alla DisplayObject-instanser som 
		 *	placerats i lagret. Om en instans är av typen 
		 *	DisplayStateLayerSprite kommer instansen att 
		 *	deallokeras efter att den har tagits bort.
		 * 
		 *	@return void
		 */
		public function dispose():void {
			while (numChildren > 0) {
				var child:DisplayStateLayerSprite = removeChildAt(0) as DisplayStateLayerSprite;
				if (child is DisplayStateLayerSprite) {
					child.dispose();
				}
			}
		}
	}
}