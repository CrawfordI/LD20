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
		private var healthiness:Number = 100;
		private var water:Number = 0;
		private var excessWater:Number;
		private var energy:Number = 0;
		private var excessEnergy:Number;
		
		private var growthRate:Number = 0.05;
		
		private var sX:Number = 0;
		private var sY:Number = 0;
		
		private var score:int = 0;
		private var time:int = 0;
		
		public function PlantEntity( startX:Number, startY:Number )
		{	
			sprPlant = new Spritemap(PLANT, 64, 128);
			sprPlant.add("default", [0, 1, 2, 1], 12, true);
			sprPlant.play("default");
			sprPlant.scale = 0.05;
			graphic = sprPlant;
			
			sX = startX;
			sY = startY;
			x = startX - sprPlant.scaledWidth / 2;
			y = startY - sprPlant.scaledHeight / 2;
			//sprPlant.color = 0xAAAABB;  // looks like its wilting
			//sprPlant.color = 0xAAAAAA;  // wilting less
		//	if ( sprPlant.scaledHeight < 12 || sprPlant.scaledWidth / 2 < 12 ) {
		
				setHitbox( sprPlant.scaledWidth, sprPlant.scaledHeight );

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
		
		public function plantColor():uint {
			return sprPlant.color;
		}
		
		override public function update():void 
		{
			super.update();
			//sprPlant.update();
			if ( water >= 100 && energy >= 100 ) {
				water -= 100;
				energy -= 100;
				sprPlant.scale += growthRate;
				x = sX - sprPlant.scaledWidth / 2;
				y = sY - sprPlant.scaledHeight / 2 - (70 * sprPlant.scale);
		
					setHitbox( sprPlant.scaledWidth, sprPlant.scaledHeight );
		
				trace("SCALE IS NOW: " + sprPlant.scale);
			}
			
			if ( water >= 100 ) {
				water -= 100;
				healthiness -= 10;
			}
			
			if ( energy >= 100 ) {
				energy -= 100;
				healthiness -= 10;
			}
			
			if ( healthiness >= 80 && healthiness < 90 ) {
				sprPlant.color = 0xAAAAAA;
			} else if ( healthiness >= 70 && healthiness < 80 ) {
				sprPlant.color 0xAAAABB;
			} else if ( healthiness >= 60 && healthiness < 70 ) {
				sprPlant.color 0xAAAACC;
			} else if ( healthiness >= 50 && healthiness < 60 ) {
				sprPlant.color 0xAAAADD;
			} else if ( healthiness >= 40 && healthiness < 50 ) {
				sprPlant.color 0xAAAAEE;
			} else if ( healthiness >= 30 && healthiness < 40 ) {
				sprPlant.color 0xAAAAFF;
			} else if ( healthiness >= 20 && healthiness < 30 ) {
				sprPlant.color 0xAABBBB;
			} else if ( healthiness >= 0 && healthiness < 20 ) {
				sprPlant.color 0xFF0000;
			} else {
				sprPlant.color = 0xFFFFFF;
			}
			
			time++;
			
		//	x += dx;
		//	y += dy;
			
			// Switch directions
			//if ( x <= 0 || x + sprSun.width >= FP.width )
		//		dx = dx * -1;
			
		}
	}

}