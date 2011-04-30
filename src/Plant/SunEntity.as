package Plant 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Matthew Dalrymple
	 */
	public class SunEntity extends Entity
	{

		private var dx:Number = 0.75;
		private var dy:Number = 0;
		
		[Embed(source = '../../gfx/plant/plant_sun.png')]
		private const SUN:Class;
		
		public var sprSun:Spritemap;
	
		public function SunEntity() 
		{
			sprSun = new Spritemap(SUN, 64, 64);
			y = 20;
			sprSun.add("default", [0, 1, 2, 1], 12, true);
			sprSun.play("default");
			graphic = sprSun;

		}
		
		override public function update():void 
		{
			sprSun.update();
			
			x += dx;
			y += dy;
			
			if ( x <= 0 )
				dx = 2;
			if ( x + sprSun.width >= FP.width )
				dx = -2;
			
		}
		
	}

}