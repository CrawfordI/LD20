package Plant 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Matthew Dalrymple
	 */
	public class PlantEntity extends Entity
	{
		
		[Embed(source = '../../gfx/plant/plant_plant.png')]
		private const PLANT:Class;
		
		public var sprPlant:Spritemap;
		private var healthiness:Number = 1000;
		private var water:Number;
		private var excessWater:Number;
		private var energy:Number;
		private var excessEnergy:Number;
		
		public function PlantEntity() 
		{	
			sprPlant = new Spritemap(PLANT, 64, 128);
			sprPlant.add("default", [0, 1, 2, 1], 12, true);
			sprPlant.play("default");
			sprPlant.scale = 1;
			graphic = sprPlant;
			
			x = 200 - sprPlant.scaledWidth / 2;
			y = 300 - sprPlant.scaledHeight / 2;
			//sprPlant.color = 0xAAAABB;  // looks like its wilting
			//sprPlant.color = 0xAAAAAA;  // wilting less
			setHitbox( sprPlant.scaledWidth, sprPlant.scaledHeight / 2, 0, -20 );
			type = "plant";
		}
		
		
		override public function update():void 
		{
			super.update();
			
		//	x += dx;
		//	y += dy;
			
			// Switch directions
			//if ( x <= 0 || x + sprSun.width >= FP.width )
		//		dx = dx * -1;
			
		}
	}

}