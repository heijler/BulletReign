package entity
{
	import flash.display.MovieClip;
	import asset.Plane1GFX;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	
	public class Plane extends Entity
	{
		private var m_skin:MovieClip;
		private var m_controls:EvertronControls = new EvertronControls(0);

		public function Plane()
		{
			super();
		}
		
		/**	
		 * init
		 * override
		 */
		override public function init():void 
		{
			this.m_initSkin();
		}
		
		/**	
		 * m_initSkin
		 * Initialize skin
		 */
		private function m_initSkin():void 
		{
			this.m_skin = new Plane1GFX;
			this.m_skin.scaleX = 2;
			this.m_skin.scaleY = 2;
			this.addChild(this.m_skin);
		}
		
		/**	
		 * update
		 * override, gameloop
		 */
		override public function update():void 
		{
			this.m_updateControls();
		}
		
		/**	
		 * m_updateControls
		 * Update the planes position.
		 */
		private function m_updateControls():void 
		{
			if (this.m_controls != null) {
				if (Input.keyboard.pressed(this.m_controls.PLAYER_RIGHT)) {
					this.x += 5;
				}
			}
		}
	}
}