package se.lnu.stickossdk.component.screenkeyboard
{
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import se.lnu.stickossdk.component.screenkeyboard.command.ScreenKeyboardKeyCommand;
	import se.lnu.stickossdk.component.screenkeyboard.command.ScreenKeyboardKeyDownCommand;
	import se.lnu.stickossdk.component.screenkeyboard.command.ScreenKeyboardKeyLeftCommand;
	import se.lnu.stickossdk.component.screenkeyboard.command.ScreenKeyboardKeyRightCommand;
	import se.lnu.stickossdk.component.screenkeyboard.command.ScreenKeyboardKeyUpCommand;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Handles all keyboard keys for the screen keyboard.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2013.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2013-01-15
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class ScreenKeyboardKeys extends Sprite {
		
		//-------------------------------------------------------
		// Public properties
		//-------------------------------------------------------

		/**
		 *	Reference to the method to be called every time a key 
		 *	is activated (pressed). When the method is activated, 
		 *	the key"s value is returned as the first argument to 
		 *	the callback method. 
		 * 
		 *	@default null
		 */
		public var callback:Function = null;
		
		//-------------------------------------------------------
		// Public getter and setter methods
		//-------------------------------------------------------
		
		/**
		 *	De kontroller som skärmtangentbordets tangenter är 
		 *	kopplade till.
		 */
		public function get controls():EvertronControls {
			return _controls;
		}
		
		/**
		 *	Contains the position of the active keyboard key. 
		 *	The position refers to a place in a two-dimensional 
		 *	vector containing all the keyboard keys for the 
		 *	on-screen keyboard.
		 * 
		 *	@default Point
		 */
		public function get selectedKey():Point {
			return _selectedKey;
		}
		
		/**
		 *	Contains the position of the active keyboard key. 
		 *	The position refers to a place in a two-dimensional 
		 *	vector containing all the keyboard keys for the 
		 *	on-screen keyboard.
		 * 
		 *	@default Point
		 */
		public function set selectedKey(value:Point):void {
			_selectedKey = value;
		}
		
		/**
		 *	Tvådimensionell lista innehållande samtliga tangenter 
		 *	för skärmtangentbordet.
		 * 
		 *	@default Vector.<Vector.<ScreenKeyboardKey>>
		 */
		public function get keys():Vector.<Vector.<ScreenKeyboardKey>> {
			return _keys;
		}
		
		//-------------------------------------------------------
		// Private properties
		//-------------------------------------------------------
		
		/**
		 *	De kontroller som skärmtangentbordets tangenter är 
		 *	kopplade till.
		 * 
		 *	@default EvertronControls
		 */
		private var _controls:EvertronControls = new EvertronControls();
		
		/**
		 *	Contains the position of the active keyboard key. 
		 *	The position refers to a place in a two-dimensional 
		 *	vector containing all the keyboard keys for the 
		 *	on-screen keyboard.
		 * 
		 *	@default Point
		 */
		private var _selectedKey:Point = new Point();
		
		/**
		 *	Tvådimensionell lista innehållande samtliga tangenter 
		 *	för skärmtangentbordet.
		 * 
		 *	@default Vector.<Vector.<ScreenKeyboardKey>>
		 */
		private var _keys:Vector.<Vector.<ScreenKeyboardKey>> = new Vector.<Vector.<ScreenKeyboardKey>>(5, true);
		
		/**
		 *	Ljudobjektet för att spela upp ett ljud när 
		 *	användaren förflyttar markören från en tangent till 
		 *	en annan.
		 * 
		 *	@default null
		 */
		private var _soundMove:SoundObject;
		
		/**
		 *	Ljudobjektet för att spela upp ett ljud när 
		 *	användaren väljer en tangent.
		 * 
		 *	@default null
		 */
		private var _soundSelect:SoundObject;
		
		//-------------------------------------------------------
		// Private constants
		//-------------------------------------------------------
		
		/**
		 *	The space between each keyboard key in the x and y 
		 *	direction.
		 * 
		 *	@default 0,0
		 */
		private const KEY_MARGIN:Point = new Point();
		
		/**
		 *	...
		 * 
		 *	@default 42,42
		 */
		private const KEY_SIZE:Point = new Point(42, 42);
		
		//-------------------------------------------------------
		// Private static embeded constants
		//-------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/1.png")]
		private static const ONE:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/2.png")]
		private static const TWO:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/3.png")]
		private static const THREE:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/4.png")]
		private static const FOUR:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/5.png")]
		private static const FIVE:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/6.png")]
		private static const SIX:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/7.png")]
		private static const SEVEN:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/8.png")]
		private static const EIGHT:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/9.png")]
		private static const NINE:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/0.png")]
		private static const ZERO:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/q.png")]
		private static const Q:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/w.png")]
		private static const W:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/e.png")]
		private static const E:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/r.png")]
		private static const R:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/t.png")]
		private static const T:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/y.png")]
		private static const Y:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/u.png")]
		private static const U:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/i.png")]
		private static const I:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/o.png")]
		private static const O:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/p.png")]
		private static const P:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/a.png")]
		private static const A:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/s.png")]
		private static const S:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/d.png")]
		private static const D:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/f.png")]
		private static const F:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/g.png")]
		private static const G:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/h.png")]
		private static const H:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/j.png")]
		private static const J:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/k.png")]
		private static const K:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/l.png")]
		private static const L:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/backspace.png")]
		private static const BACKSPACE:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/z.png")]
		private static const Z:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/x.png")]
		private static const X:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/c.png")]
		private static const C:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/v.png")]
		private static const V:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/b.png")]
		private static const B:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/n.png")]
		private static const N:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/m.png")]
		private static const M:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/slash.png")]
		private static const SLASH:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/enter.png")]
		private static const ENTER:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/at.png")]
		private static const AT:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/hashtag.png")]
		private static const HASHTAG:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/dot.png")]
		private static const DOT:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/dash.png")]
		private static const DASH:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/underscore.png")]
		private static const UNDERSCORE:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/and.png")]
		private static const AND:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/img/screenkeyboard/space.png")]
		private static const SPACE:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/mp3/screenkeyboard/sound_screen_keyboard_move.mp3")]
		private static const SOUND_MOVE:Class;
		
		/**
		 *	...
		 * 
		 *	@default Class
		 */
		[Embed("../../asset/mp3/screenkeyboard/sound_screen_keyboard_select.mp3")]
		private static const SOUND_SELECT:Class;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	...
		 */
		public function ScreenKeyboardKeys() {
			init();
		}
		
		//-------------------------------------------------------
		// Public methods
		//-------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		public function update():void {
			updateKeys();
			updateNavigationPosition();
			updateInput();
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		public function reset():void {
			_selectedKey.x = 0;
			_selectedKey.y = 0;
			updateKeys();
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		public function dispose():void {
			if (parent != null) parent.removeChild(this);
			disposeKeyList();
		}
		
		//-------------------------------------------------------
		// Private methods
		//-------------------------------------------------------
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function init():void {
			initKeysSound();
			initKeysConfig();
			initKeysLayout();
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function initKeysSound():void {
			Session.sound.soundChannel.sources.add("screen_keyboard_move",	 SOUND_MOVE);
			Session.sound.soundChannel.sources.add("screen_keyboard_select", SOUND_SELECT);
			
			_soundMove   = Session.sound.soundChannel.get("screen_keyboard_move",   true, true);
			_soundSelect = Session.sound.soundChannel.get("screen_keyboard_select", true, false);
		}
		
		/**
		 *	Creates and configures the buttons that the screen 
		 *	keyboard will contain. Each key are represented by 
		 *	a ScreenKeyboardKey and contains a value and 
		 *	a graphical representation of the key.
		 * 
		 *	@return void
		 */
		private function initKeysConfig():void {
			_keys[0] = new Vector.<ScreenKeyboardKey>();
			_keys[1] = new Vector.<ScreenKeyboardKey>();
			_keys[2] = new Vector.<ScreenKeyboardKey>();
			_keys[3] = new Vector.<ScreenKeyboardKey>();
			_keys[4] = new Vector.<ScreenKeyboardKey>();
			
			_keys[0].push(new ScreenKeyboardKey("1", ONE));
			_keys[0].push(new ScreenKeyboardKey("2", TWO));
			_keys[0].push(new ScreenKeyboardKey("3", THREE));
			_keys[0].push(new ScreenKeyboardKey("4", FOUR));
			_keys[0].push(new ScreenKeyboardKey("5", FIVE));
			_keys[0].push(new ScreenKeyboardKey("6", SIX));
			_keys[0].push(new ScreenKeyboardKey("7", SEVEN));
			_keys[0].push(new ScreenKeyboardKey("8", EIGHT));
			_keys[0].push(new ScreenKeyboardKey("9", NINE));
			_keys[0].push(new ScreenKeyboardKey("0", ZERO));
			
			_keys[1].push(new ScreenKeyboardKey("Q", Q));
			_keys[1].push(new ScreenKeyboardKey("W", W));
			_keys[1].push(new ScreenKeyboardKey("E", E));
			_keys[1].push(new ScreenKeyboardKey("R", R));
			_keys[1].push(new ScreenKeyboardKey("T", T));
			_keys[1].push(new ScreenKeyboardKey("Y", Y));
			_keys[1].push(new ScreenKeyboardKey("U", U));
			_keys[1].push(new ScreenKeyboardKey("I", I));
			_keys[1].push(new ScreenKeyboardKey("O", O));
			_keys[1].push(new ScreenKeyboardKey("P", P));
			
			_keys[2].push(new ScreenKeyboardKey("A", A));
			_keys[2].push(new ScreenKeyboardKey("S", S));
			_keys[2].push(new ScreenKeyboardKey("D", D));
			_keys[2].push(new ScreenKeyboardKey("F", F));
			_keys[2].push(new ScreenKeyboardKey("G", G));
			_keys[2].push(new ScreenKeyboardKey("H", H));
			_keys[2].push(new ScreenKeyboardKey("J", J));
			_keys[2].push(new ScreenKeyboardKey("K", K));
			_keys[2].push(new ScreenKeyboardKey("L", L));
			_keys[2].push(new ScreenKeyboardKey("BACKSPACE", BACKSPACE));
			
			_keys[3].push(new ScreenKeyboardKey("Z", Z));
			_keys[3].push(new ScreenKeyboardKey("X", X));
			_keys[3].push(new ScreenKeyboardKey("C", C));
			_keys[3].push(new ScreenKeyboardKey("V", V));
			_keys[3].push(new ScreenKeyboardKey("B", B));
			_keys[3].push(new ScreenKeyboardKey("N", N));
			_keys[3].push(new ScreenKeyboardKey("M", M));
			_keys[3].push(new ScreenKeyboardKey("/", SLASH));
			_keys[3].push(new ScreenKeyboardKey("ENTER", ENTER));
			
			_keys[4].push(new ScreenKeyboardKey("@", AT));
			_keys[4].push(new ScreenKeyboardKey("#", HASHTAG));
			_keys[4].push(new ScreenKeyboardKey(".", DOT));
			_keys[4].push(new ScreenKeyboardKey("-", DASH));
			_keys[4].push(new ScreenKeyboardKey("_", UNDERSCORE));
			_keys[4].push(new ScreenKeyboardKey("&", AND));
			_keys[4].push(new ScreenKeyboardKey(" ", SPACE));
		}
		
		/**
		 *	Iterates the list of keys and place them on their 
		 *	respective position on the screen keyboard. The 
		 *	positioning is based on KEY_SIZE, KEY_MARGIN and 
		 *	KEY_INIT_MARGIN.
		 * 
		 *	@return void
		 */
		private function initKeysLayout():void {
			var key:ScreenKeyboardKey;
			var x:int;
			var y:int;
			
			for(y = 0; y < _keys.length; y++) {
				for(x = 0; x < _keys[y].length; x++) {
					key = _keys[y][x];
					key.x = (((x * KEY_SIZE.x) + (x * KEY_MARGIN.x)));
					key.y = (((y * KEY_SIZE.y) + (y * KEY_MARGIN.y)));
					
					addChild(key);
				}
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function updateKeys():void {
			updateAll();
			updateSelected();
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function updateAll():void {
			for(var y:int = 0; y < _keys.length; y++){
				for(var x:int = 0; x < _keys[y].length; x++) {
					var key:ScreenKeyboardKey = _keys[y][x];
						key.active = false;
				}
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function updateSelected():void {
			var key:ScreenKeyboardKey = _keys[_selectedKey.y][_selectedKey.x];
				key.active = true;
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function updateNavigationPosition():void {
			var command:ScreenKeyboardKeyCommand = this.handleInput();
			if (command == null) return;
			command.execute(this);
			_soundMove.play();
		}
		
		/**
		 *	Returns the command to handle the new location of
		 * 	the key.
		 *  
		 * 	@return ScreenKeyboardKeyCommand
		 */
		private function handleInput():ScreenKeyboardKeyCommand {
			if (Input.keyboard.justPressed(_controls.PLAYER_UP)) return new ScreenKeyboardKeyUpCommand();
			if (Input.keyboard.justPressed(_controls.PLAYER_DOWN)) return new ScreenKeyboardKeyDownCommand();
			if (Input.keyboard.justPressed(_controls.PLAYER_RIGHT)) return new ScreenKeyboardKeyRightCommand();
			if (Input.keyboard.justPressed(_controls.PLAYER_LEFT)) return new ScreenKeyboardKeyLeftCommand();
			return null;
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function updateInput():void {
			if (Input.keyboard.justPressed(_controls.PLAYER_BUTTON_1)) {
				_soundSelect.play();
				if (callback !== null) callback(_keys[_selectedKey.y][_selectedKey.x].value);
			}
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function disposeKeyList():void {
			for (var i:int = 0; i < _keys.length; i++) {
				disposeKeys(_keys[i]);
			}
			_keys = null;
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function disposeKeys(keys:Vector.<ScreenKeyboardKey>):void {
			for each (var key:ScreenKeyboardKey in keys) {
				disposeKey(key);
			}
			keys = null;
		}
		
		/**
		 *	...
		 * 
		 *	@return void
		 */
		private function disposeKey(key:ScreenKeyboardKey):void {
			key.bitmapData.dispose();
			key = null;
		}
	}
}