package Plant 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Matthew Dalrymple
	 */
	public class SunEntity extends Entity
	{

		[Embed(source = '../../gfx/plant/plant_sun.png')]
		private const SUN:Class;
		
		private var sprSun:Spritemap = new Spritemap(SUN, 64, 64);
	
		public function SunEntity() 
		{
			sprSun.add("default", [0, 1, 2], 20, true);
			graphic = sprSun;
			sprSun.play("default");
		}
		
	}

}