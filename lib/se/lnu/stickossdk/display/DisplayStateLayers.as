package se.lnu.stickossdk.display
{
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	En klass för att hantera tillståndslager 
	 *	(DisplayStateLayer).
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-23
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class DisplayStateLayers {
		
		//-------------------------------------------------------
		// Public getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Sprite-objekt som omsluter alla underliggande lager. 
		 *	Detta objekt kan användas vid spelutveckling, men det 
		 *	är främst menat att användas internt av spelmotorn.
		 */
		public function get container():Sprite {
			return _container;
		}
		
		/**
		 *	Antalet lager som registrerats i detta tillstånd.
		 */
		public function get numLayers():int {
			return _layers.length;
		}
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Ett Sprite-objekt som omsluter alla underliggande 
		 *	lager (DisplayStateLayer).
		 * 
		 *	@default Sprite
		 */
		private var _container:Sprite = new Sprite();
		
		/**
		 *	Lista innehållande samtliga lager som registrerats i 
		 *	lagerhanteraren.
		 * 
		 *	@default Vector
		 */
		private var _layers:Vector.<DisplayStateLayer> = new Vector.<DisplayStateLayer>();
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av DisplayStateLayers.
		 */
		public function DisplayStateLayers() {
			
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	Skapar och lägger till ett nytt lager i 
		 *	lagerhanteraren. Varje lager identifieras med ett 
		 *	unikt namn.
		 * 
		 *	@param	name	Det tilltänkta lagrets namn.
		 * 
		 *	@return Referens till det nya lagret.
		 */
		public function add(name:String):DisplayStateLayer {
			var layer:DisplayStateLayer = new DisplayStateLayer();
				layer.name = name;
				
			_layers.push(layer);
			return _container.addChild(layer) as DisplayStateLayer;
		}
		
		/**
		 *	Tar bort ett befintligt lager från lagerhanteraren. 
		 *	Denna metod genomför en säker borttagning där lagret 
		 *	inte deallokeras under borttagningsprocessen.
		 * 
		 *	@param	name	Lagret som ska tas bort.
		 * 
		 *	@return Det borttagna lagret.
		 */
		public function remove(name:String):DisplayStateLayer {
			//@TODO: DENNA METOD ÄR ÖVERAMBITIÖS.
			var layer:DisplayStateLayer = null;
			for (var i:int = 0; i < _layers.length; i++) {
				if (_layers[i].name == name) {
					_container.removeChildAt(i);
					layer = _layers.splice(i, 1)[0];
					break;
				}
			}
			
			return layer;
		}
		
		/**
		 *	Tar bort och deallokerar ett lager. När denna metod 
		 *	är genomförd är lagret inte längre brukligt.
		 * 
		 *	@param	name	Lagret som ska tas bort.
		 * 
		 *	@return void
		 */
		public function removeAndDispose(name:String):void {
			var layer:DisplayStateLayer = remove(name);
			if (layer !== null) {
				layer.dispose();
				layer = null;
			}
		}
		
		//-------------------------------------------------------
		// Internal methods
		//-------------------------------------------------------
		
		/**
		 *	Uppdaterar samtliga lager som registrerats i 
		 *	lagerhanteraren.
		 * 
		 *	@return void
		 */
		internal function update():void {
			for (var i:int = 0; i < _layers.length; i++) {
				_layers[i].update();
			}
		}
		
		/**
		 *	Tar bort och deallokerar de lager som registrerats i 
		 *	lagerhanteraren.
		 * 
		 *	@return void
		 */
		internal function dispose():void {
			//@TODO: DENNA METOD ÄR ÖVERAMBITIÖS.
			while (_container.numChildren > 0) {
				_container.removeChildAt(0);
			}
			
			for (var i:int = 0; i < _layers.length; i++) {
				_layers[i].dispose();
				_layers[i] = null;
			}
			
			_layers.length = 0;
		}
	}
}