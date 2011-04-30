package Plant 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author Matthew Dalrymple
	 */
	public class SunEntity extends Entity
	{

		private var dx:Number = 0.75;
		private var dy:Number = 0;
		
		private var selected:Boolean = false;
		
		[Embed(source = '../../gfx/plant/plant_sun.png')]
		private const SUN:Class;
		
		public var sprSun:Spritemap;
	
		public function SunEntity() 
		{
			sprSun = new Spritemap(SUN, 64, 64);
			setHitbox(64, 64);

			width = 64;
			height = 64;

			y = 20;
			sprSun.add("default", [0, 1, 2, 1], 12, true);
			sprSun.play("default");
			graphic = sprSun;

		}
		
		public function wasSelected():Boolean {
			if ( selected ) {
				selected = false;
				return true;
			}
			return false;
		}
		
		override public function update():void 
		{
			super.update();
			
			x += dx;
			y += dy;
			
			// Switch directions
			if ( x <= 0 || x + sprSun.width >= FP.width )
				dx = dx * -1;

			if ( Input.mouseReleased ) {
				// Did the user press and release on this entity?
				if ( selected && collidePoint(x, y, Input.mouseX, Input.mouseY)  ) {
					trace("PRESSED AND RELEASED ON THE SUN!");
					selected = true;
				}
				//selected = false;
			} else if (!Input.mouseDown) {
				// Not holding mouse down anymore
				selected = false;
			} else if (Input.mousePressed) {
				// The mouse button was just pressed this frame.
				selected = true;
			}
			
			
		}

		
	}

}