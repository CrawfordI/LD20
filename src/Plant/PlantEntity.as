package Plant 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	/**
	 * ...
	 * @author Matthew Dalrymple
	 */
	public class PlantEntity extends Entity
	{
		
		[Embed(source = '../../gfx/plant/plant_plant.png')]
		private const PLANT:Class;
		
		[Embed(source = '../../sfx/plant/plant_grow.mp3')]
		private const SFX_GROW:Class;
		
		[Embed(source = '../../sfx/plant/plant_hit.mp3')]
		private const SFX_HIT:Class;
		
		public var sprPlant:Spritemap;
		public var sfxHit:Sfx;
		public var sfxGrow:Sfx;
		
		
		private var healthiness:Number = 100;
		private var water:Number = 0;
		private var energy:Number = 0;
		
		private var growthRate:Number = 0.05;
		
		private var sX:Number = 0;
		private var sY:Number = 0;
		
		
		public function PlantEntity( startX:Number, startY:Number )
		{	
			sfxHit = new Sfx(SFX_HIT);
			sfxGrow = new Sfx(SFX_GROW);
			sprPlant = new Spritemap(PLANT, 64, 128);
			sprPlant.add("default", [0, 1, 2, 1], 12, true);
			sprPlant.play("default");
			sprPlant.scale = 0.05;
			graphic = sprPlant;
			
			sX = startX;
			sY = startY;
			x = startX - sprPlant.scaledWidth / 2;
			y = startY - sprPlant.scaledHeight / 2;

		
			setHitbox( sprPlant.scaledWidth, sprPlant.scaledHeight );

			type = "plant";
		}
		
		public function addWater( amount:Number ):void {
			water += amount;
			sfxHit.play();
			//trace("WATER ADDED: " + amount);
		}
		
		public function addEnergy( amount:Number ):void {
			energy += amount;
			sfxHit.play();
		//	trace("ENERGY ADDED: " + amount);
		}
		
		public function plantColor():uint {
			return sprPlant.color;
		}
		
		public function plantSize():int {
			return sprPlant.scale * 100;
		}
		
		public function getHealth():Number {
			return healthiness;
		}
		
		override public function update():void 
		{
			super.update();

			if ( water >= 100 && energy >= 100 ) {
				water -= 100;
				energy -= 100;
				if( healthiness >= 70 ) {
					sprPlant.scale += growthRate;
					x = sX - sprPlant.scaledWidth / 2;
					y = sY - sprPlant.scaledHeight / 2 - (70 * sprPlant.scale);
					setHitbox( sprPlant.scaledWidth, sprPlant.scaledHeight );
					sfxGrow.play();
			//		trace("SCALE IS NOW: " + sprPlant.scale);
				} else {
					healthiness += FP.rand( 30 ) + 1;
					if ( healthiness > 100 )
						healthiness = 100;
				}
			}
			
			if ( water >= 275 ) {
				water -= 150;
				healthiness -= 10 + FP.rand( 5 );
			}
			
			if ( energy >= 250 ) {
				energy -= 125;
				healthiness -= 10 + FP.rand( 3 );
			}

			if ( healthiness < 0 )
				healthiness = 0;
				
			var r:int = 255 - 0.0 * (100 - healthiness) / 100;			
			var g:int = 255 - 232.0 * (100 - healthiness) / 100;
			var b:int = 255 - 232.0 * (100 - healthiness) / 100;			
			
			var pColor:uint = (r << 16) + (g << 8) + b;
			sprPlant.color = pColor;
			
		}
	}

}