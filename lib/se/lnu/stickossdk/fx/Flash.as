package se.lnu.stickossdk.fx
{
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.tween.Tween;
	import se.lnu.stickossdk.tween.easing.Quad;
	import se.lnu.stickossdk.tween.easing.Sine;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	En blixteffekt som kan appliceras på 
	 *	DisplayObjectContainers. Effekten hanteras och uppdateras 
	 *	internt av StickOS SDKs inbyggda effekthanterare.
	 * 
	 *	<p>StickOS SDK erbjuder en fördefinierad effekthanterar 
	 *	som finns tillgänglig via <code>Session.effects</code>. 
	 *	Använd metoden <code>add</code> för att lägga till 
	 *	effekten i effekthanteraren.</p>
	 * 
	 *	@see se.lnu.stickossdk.fx.Effects
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-17
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Flash extends Effect {
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	Utgör ytan som blixteffekten har till sitt förfogande. 
		 *	Som standard deklareras denna yta till samma som 
		 *	objektet som blixteffekten har applicerats på.
		 * 
		 *	@default null
		 */
		private var _area:Rectangle;
		
		/**
		 *	Färgen som blixteffekten ska använda. Standardfärgen 
		 *	är vit och tilldelas i konstruktorn.
		 * 
		 *	@default null
		 */
		private var _color:uint;
		
		/**
		 *	Ett Bitmap-objekt som representerar blixteffektens 
		 *	rektangulära färgade yta. 
		 * 
		 *	@default null
		 */
		private var _flash:Bitmap;
		
		/**
		 *	Referens till det Tween-objekt som används för att 
		 *	animera uttoningen av blixteffekten. Blixteffekten 
		 *	använder StickOS SDKs egna Tween-motor.
		 * 
		 *	@default null
		 */
		private var _tween:Tween;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	Skapar en ny blixt-effekt. Effekten gör att ett objekt 
		 *	kan blixtra till i en utvald färg. Denna effekt kan 
		 *	exempelvis vara användbar då man vill förmedla att en 
		 *	spelare tagit skada.
		 * 
		 *	@param	target		Det objekt som effekten ska appliceras på.
		 *	@param	duration	Tiden det tar för effekten att slutföras.
		 *	@param	color		Färgen på effekten.
		 *	@param	area		Inställningar för effektens position och storlek.
		 */
		public function Flash(target:DisplayObjectContainer, duration:int, color:uint = 0xFFFFFF, area:Rectangle = null) {
			//@TODO: KAN DENNA SNYGGAS TILL?
			super(target, duration);
			_area = area;
			_color = color;
		}
		
		//-------------------------------------------------------
		// Override internal methods
		//-------------------------------------------------------
		
		/**
		 *	Skapar och aktiverar blixteffektens grundläggande 
		 *	beståndsdelar.
		 * 
		 *	@default void
		 */
		override internal function init():void {
			initArea();
			initFlash();
			initTween();
		}
		
		/**
		 *	Denna metod är menad att uppdatera blixteffekten men då 
		 *	den använder en tween för att genomföra uppdateringar 
		 *	är denna metod inte längre nödvändig. Metoden kan 
		 *	användas då det innebär två möjligheter att få _duration 
		 *	satt till 0. Tillsvidare blockeras denna metod tills 
		 *	den har utvärderats.
		 * 
		 *	@default void
		 */
		override internal function update():void {
			// @TODO: UTVÄRDERA HUVIDA DENNA METOD SKA ANVÄNDAS ELLER INTE
			// HINDRAR DEN VANLIGA UPPDATERINGEN SÅ ATT _DURATION INTE KAN BLI 0.
		}
		
		/**
		 *	Förbereder objektet på borttagning. Syftet med metoden 
		 *	är att frigöra så mycket allokerat minne som möjligt. 
		 *	Detta för att underlätta för skräpuppsammlaren.
		 * 
		 *	@default void
		 */
		override internal function dispose():void {
			onFlashComplete();
			disposeTween();
			disposeFlash();
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	Definierar ytan som blixteffekten ska täcka. Som 
		 *	standard deklareras ytan till storleken av det objekt 
		 *	som blixteffekten ska appliceras på.
		 * 
		 *	@return void
		 */
		private function initArea():void {
			if (_area == null) {
				_area  = new Rectangle();
				_area.width  = _target.width;
				_area.height = _target.height;
			}
		}
		
		/**
		 *	Skapar det bitmap-objekt som används för att skapa 
		 *	blixteffekten. Objektet består av en rektangulär 
		 *	bitmap med fyllnadsfärg.
		 * 
		 *	@return void
		 */
		private function initFlash():void {
			//@TODO: KAN METODNAMNET FÖRTYDLIGAS?
			//@TODO: KAN INNEHÅLLET SNYGGAS TILL?
			_flash = new Bitmap(new BitmapData(_area.width, _area.height, false, _color));
			_flash.x = _area.x;
			_flash.y = _area.y;
			_target.addChildAt(_flash, _target.numChildren);
		}
		
		/**
		 *	Skapar det tween-objekt som används för att tona ut 
		 *	den bild som representerar blixteffekten.
		 * 
		 *	@default void
		 * 
		 *	@see se.lnu.stickos.tween.Tweener
		 */
		private function initTween():void {
			_tween = Session.tweener.add(_flash, {
				duration	: _duration,
				onComplete	: onFlashComplete,
				transition	: Sine.easeIn,
				alpha		: 0
			});
		}
		
		/**
		 *	Genomför en säker borttagning av den bild som används 
		 *	för att skapa blixteffekten. När denna metod 
		 *	slutförts klassas objektets uppgift som utförd, detta 
		 *	innebär att objektet kommer att tas bort av 
		 *	effekthanteraren och påbörja deallokeringsprocessen.
		 * 
		 *	@return void
		 * 
		 *	@see se.lnu.stickos.fx.Effect
		 */
		private function onFlashComplete():void {
			if (_target && _flash && _flash.parent) {
				_flash.parent.removeChild(_flash);
			}
			
			complete = true;
		}
		
		/**
		 *	Genomför en säker borttagningen av det tween-objekt 
		 *	som använts för att tona ut blixteffekten. 
		 *	Borttagningen sker via den globala tween-hanteraren.
		 * 
		 *	@return void
		 * 
		 *	@see se.lnu.stickos.tween.Tweener
		 */
		private function disposeTween():void {
			if (_tween) Session.tweener.remove(_tween);
		}
		
		/**
		 *	Förstör bild-objektet som använts för att skapa 
		 *	blixteffekten. Notera att bild-objektet inte kommer 
		 *	att vara funktionellt efter att denna metod har 
		 *	kallats.
		 * 
		 *	@return void
		 */
		private function disposeFlash():void {
			_flash.bitmapData.dispose();
			_flash = null;
		}
	}
}