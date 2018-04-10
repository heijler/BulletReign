package se.lnu.stickossdk.tween 
{
	//-------------------------------------------------------------------------
	// Imports
	//-------------------------------------------------------------------------
	
	import flash.geom.Point;
	import se.lnu.stickossdk.tween.easing.BezierQuadratic;
	
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.tween.easing.BezierCubic;
	import se.lnu.stickossdk.util.ObjectUtils;
	
	//-------------------------------------------------------------------------
	// Public class
	//-------------------------------------------------------------------------
	
	/**
	 *	BezierTween-klassen representerar ett objekt som interpoleras. 
	 *  Klassen kan enbart interpolera ett objekts x- och y-egenskaper.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-15
	 *	@author		Jesper Hansson <jesper.hansson.86@gmail.com>
	 */
	public class BezierTween extends Tween 
	{
		//-------------------------------------------------------
		// Private getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	Tidstämpel för den tidpunkt då interpoleringen 
		 *	påbörjades. Starttiden är relativ till 
		 *	interpoleringens aktiva tid.
		 */
		private function get _tweenStart():Number {
			return Session.application.time.timeOfCurrentFrame - _activeTimeElapsed;
		}
		
		/**
		 *	Tidstämpel för den tidpunkt då interpoleringen 
		 *	beräknas vara färdig. Sluttiden är relativt till 
		 *	interpoleringens aktiva tid.
		 */
		private function get _tweenEnd():Number {
			return Session.application.time.timeOfCurrentFrame + (_duration - _activeTimeElapsed);
		}
		
		//---------------------------------------------------------------------
		// Private properties
		//---------------------------------------------------------------------
		
		/**
		 *	Referens till en "Ease-metod". Metoden används för att påverka 
		 *  interpoleringens hastighet och acceleration. 
		 * 
		 *	@default null
		 */
		private var _transition:Class;
		
		/**
		 *	Point to end the tween at.
		 * 
		 *	@default null
		 */
		private var _endPoint:Point;
		
		/**
		 *	Point to ease towards before heading to endPoint:Point.
		 * 
		 *	@default null
		 */
		private var _controlPoint1:Point;
		
		/**
		 *	Point to ease from when heading to endPoint:Point.
		 * 
		 *	@default null
		 */
		private var _controlPoint2:Point;
		
		//---------------------------------------------------------------------
		// Constructor method
		//---------------------------------------------------------------------
		
		/**
		 *	Skapar en ny instans av BezierTween.
		 * 
		 *	@param	object			...
		 *	@param	transition		The transition to use (BezierCubic, BezierQuadratic)
		 *	@param	duration		Time in milliseconds to tween (1000 = 1 second).
		 *	@param	endPoint		The point you want to tween to.
		 *	@param	controlPoint1	Point to ease towards before heading to endPoint:Point.
		 *	@param	controlPoint2	Point to ease from when heading to endPoint:Point.
		 *	@param	onComplete		Function to run when tween is completed.
		 *	@param	onInit			Function to run when tween is started.
		 */
		public function BezierTween(object:Object, transition:*, duration:Number, endPoint:Point, controlPoint1:Point, controlPoint2:Point = null, onComplete:Function = null, onInit:Function = null) {
			super(null, {}, true);
			_objectCurrent 	= object;
			_objectInitial	= ObjectUtils.clone(object);
			_transition 	= transition;
			_duration 		= duration;
			_onComplete    	= onComplete;
			_onInit   	 	= onInit;
			_endPoint		= endPoint;
			_controlPoint1	= controlPoint1;
			_controlPoint2	= controlPoint2;
			
			triggerCallback(_onInit);
			_propertyList.push(new TweenProperty("x", 0, 0));
		}
		
		//---------------------------------------------------------------------
		// Private methods
		//---------------------------------------------------------------------
		
		/**
		 *	Aktiverar en återuppringningsmetod (callback), förutsatt att 
		 *  metoden finns tillgänglig.
		 * 
		 *	@param	callback	Återuppringningsmetoden.
		 * 
		 *	@return void
		 */
		private function triggerCallback(callback:Function):void {
			if (callback is Function) {
				callback();
			}
		}
		
		//---------------------------------------------------------------------
		// Public methods
		//---------------------------------------------------------------------
		
		/**
		 *	Uppdaterar den aktuella interpoleringens 
		 *	underliggande objekt.
		 * 
		 *	@return void
		 */
		override public function update():void {
			if (paused == false) {
				_activeTimeElapsed += Session.application.time.timeSinceLastFrame;
				updateTweens();
			}
		}
		
		/**
		 *	Tar bort objekt och deallokerar minne som allokerats av objektet.
		 * 
		 *	@return void
		 */
		override public function dispose():void {
			_objectCurrent = null;
			_objectInitial = null;
		}
		
		//---------------------------------------------------------------------
		// Private methods
		//---------------------------------------------------------------------
		
		/**
		 *	Decides if Tween is complete or if it should keep going.
		 * 
		 *	@return void
		 */
		private function updateTweens():void {
			if (Session.application.time.timeOfCurrentFrame < _tweenEnd) {
				updateTweenProperties();
			}
			else {
				completeTweenProperties();
				disposeTweenProperties();
				triggerCallback(_onComplete);
			}
		}
		
		/**
		 *	Genomför beräkningarna för interpoleringen. Metoden beräknar 
		 *  förflyttningen för en specifik egenskap. Resultatet anges alltid 
		 *  som ett decimaltal (Number).
		 * 
		 *	TODO: Lägg BezierQuadratic, den är nog mer användbar för våra fåglar än BezierCubic, färre uträkningar i den dessutom.
		 * 
		 *	@return void
		 */
		private function updateTweenProperties():void {
			// TODO: Lägg BezierQuadratic, den är nog mer användbar för våra fåglar än BezierCubic, färre uträkningar i den dessutom.
			
			var timePassed:Number = _activeTimeElapsed / (_tweenEnd - _tweenStart);
			var anchor1:Point = new Point(_objectInitial.x, _objectInitial.y);
			var anchor2:Point = _endPoint;
			var control1:Point;
			var control2:Point;
			
			switch (_transition) {
				case BezierQuadratic:
					control1 = _controlPoint1;
					_objectCurrent.x = BezierQuadratic.easeX(timePassed, anchor1, anchor2, control1);
					_objectCurrent.y = BezierQuadratic.easeY(timePassed, anchor1, anchor2, control1);
					break;
				case BezierCubic:
					control1 = _controlPoint1;
					control2 = _controlPoint2;
					
					_objectCurrent.x = BezierCubic.easeX(timePassed, anchor1, anchor2, control1, control2);
					_objectCurrent.y = BezierCubic.easeY(timePassed, anchor1, anchor2, control1, control2);
					break;
				default:
					_duration = 0;
					trace("BezierTween completed without tweening: transition chosen is not a valid Bezier Tween.");
					break;
			}
		}
		
		/**
		 *	Färdigställer interpoleringsprocessen hos en egenskap. Metoden 
		 *  aktiverar återupprigningsmetoden, om den finns tillgänglig.
		 * 
		 *	@return void
		 */
		private function completeTweenProperties():void {
			_objectCurrent.x = _endPoint.x;
			_objectCurrent.y = _endPoint.y;
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function disposeTweenProperties():void 
		{
			_propertyList[0].dispose();
			_propertyList[0] = null;
			_propertyList.splice(0, 1);
			_propertyList.length = 0;
		}
	}
}