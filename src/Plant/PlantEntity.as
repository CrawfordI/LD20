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
		private var water:Number = 0;
		private var excessWater:Number;
		private var energy:Number = 0;
		private var excessEnergy:Number;
		
		private var growthRate:Number = 0.05;
		
		public function PlantEntity() 
		{	
			sprPlant = new Spritemap(PLANT, 64, 128);
			sprPlant.add("default", [0, 1, 2, 1], 12, true);
			sprPlant.play("default");
			sprPlant.scale = 0.05;
			graphic = sprPlant;
			
			x = 200 - sprPlant.scaledWidth / 2;
			y = 300 - sprPlant.scaledHeight / 2;
			//sprPlant.color = 0xAAAABB;  // looks like its wilting
			//sprPlant.color = 0xAAAAAA;  // wilting less
			setHitbox( sprPlant.scaledWidth, sprPlant.scaledHeight / 2, 0, -20 );
			type = "plant";
		}
		
		public function addWater( amount:Number ):void {
			water += amount;
			trace("WATER ADDED: " + amount);
		}
		
		public function addEnergy( amount:Number ):void {
			energy += amount;
			trace("ENERGY ADDED: " + amount);
		}
		
		override public function update():void 
		{
			super.update();
			sprPlant.update();
			if ( water >= 100 && energy >= 100 ) {
				water -= 100;
				energy -= 100;
				sprPlant.scale += growthRate;
				x = 200 - sprPlant.scaledWidth / 2;
				y = 300 - sprPlant.scaledHeight / 2;
				setHitbox( sprPlant.scaledWidth, sprPlant.scaledHeight / 2, 0, -20 );
				trace("SCALE IS NOW: " + sprPlant.scale);
			}
			
		//	x += dx;
		//	y += dy;
			
			// Switch directions
			//if ( x <= 0 || x + sprSun.width >= FP.width )
		//		dx = dx * -1;
			
		}
	}

}