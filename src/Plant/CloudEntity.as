package Plant 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Matthew Dalrymple
	 */
	public class CloudEntity extends Entity
	{
		[Embed(source = '../../gfx/plant/plant_cloud.png')]
		private const CLOUD:Class;
		
		public var sprCloud:Spritemap;
		
		public function CloudEntity() 
		{

			sprCloud = new Spritemap(CLOUD, 75, 50);
			sprCloud.add("default", [0], 1, true);
			sprCloud.play("default");
			graphic = sprCloud;

		}
		
		override public function update():void 
		{
			sprCloud.update();
		}
		
	}

}