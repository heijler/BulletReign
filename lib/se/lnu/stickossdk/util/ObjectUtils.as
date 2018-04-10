package se.lnu.stickossdk.util
{
	//-----------------------------------------------------------
	// Imports
	//-----------------------------------------------------------
	
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	En samling statiska metoder för att underlätta hantering 
	 *	av objekt i ActionScript 3.0.
	 *
	 *	@version	1.0
	 * 	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-17
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class ObjectUtils {
		
		//-------------------------------------------------------
		// Public static methods
		//-------------------------------------------------------
		
		/**
		 *	Klonar ett objekt och returnerar klonen. Ett klonat 
		 *	objekt delar inte minnesreferens med sitt 
		 *	orginalobjekt utan är helt självständigt.
		 * 
		 *	@param	source	Objektet som ska klonas.
		 * 
		 *	@return	Det klonade objektet.
		 */
		public static function clone(source:Object):Object {
			if (source is MovieClip) return cloneMovieClip(source as MovieClip);
			
			var copier:ByteArray = new ByteArray();
				copier.writeObject(source);
				copier.position = 0;
			
			return(copier.readObject());
		}
		
		/**
		 *	...
		 * 
		 *	@return MovieClip
		 */
		public static function cloneMovieClip(source:MovieClip):MovieClip {
			var sourceClass:Class = Object(source).constructor;
			var duplicate:MovieClip = new sourceClass();
			
			duplicate.transform = source.transform;
			duplicate.filters = source.filters;
			duplicate.cacheAsBitmap = source.cacheAsBitmap;
			duplicate.opaqueBackground = source.opaqueBackground;
			
			if (source.scale9Grid) {
				var rect:Rectangle = source.scale9Grid;
				duplicate.scale9Grid = rect;
			}
			
			return duplicate;
		}
		
		/**
		 *	Denna metod kombinerar flera objekt till ett och 
		 *	samma. Om ett objekt innehåller nyckelvärden om 
		 *	är null kommer de inte att inkluderas i det 
		 *	slutgiltiga objektet.
		 * 
		 *	@param	...args	 Objekten som ska kombineras.
		 * 
		 *	@return Det slutgiltiga objektet.
		 */
		public static function concat(...args):Object {
			var finalObject:Object = {};
			var currentObject:Object;
			
			for (var i:int = 0; i < args.length; i++) {
				currentObject = args[i];
				for (var prop:String in currentObject) {
					if (currentObject[prop] == null) {
						delete finalObject[prop];
					} else {
						finalObject[prop] = currentObject[prop];
					}
				}
			}
			
			return finalObject;
		}
		
		/**
		 *	Returnerar klassen som ligger till grund för ett 
		 *	instansierat objekt.
		 * 
		 *	@param	obj	Objektet vars klass är okänd.
		 * 
		 *	@return Objektets klass.
		 */
		public static function getClass(obj:Object):Class {
			return Class(getDefinitionByName(getQualifiedClassName(obj)));
		}
	}
}