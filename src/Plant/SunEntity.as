package Plant 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Matthew Dalrymple
	 */
	public class SunEntity extends Entity
	{

		[Embed(source = '../../gfx/plant/plant_sun.png')]
		private const SUN:Class;
		
		public var sprSun:Spritemap;
	
		public function SunEntity() 
		{
			sprSun = new Spritemap(SUN, 64, 64);
			sprSun.add("default", [0, 1, 2, 1], 10, true);
			sprSun.play("default");
			graphic = sprSun;

		}
		
		override public function update():void 
		{
			sprSun.update();
		}
		
	}

}