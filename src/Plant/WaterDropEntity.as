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
	public class WaterDropEntity extends Entity
	{
		
		[Embed(source = '../../gfx/plant/plant_waterdrop.png')]
		private const WATERDROP:Class;
		
		[Embed(source = "../../sfx/plant/plant_splash.mp3")]
		public const SFX_SPLASH:Class;
		
		private var sfxSplash:Sfx;
		
		public var sprWaterDrop:Spritemap;
		
		private var dx:Number = 0;
		private var dy:Number = 2.5;
		private var value:Number = 100;
		private var maxDepth:Number = FP.height;
		
		private var splashed:Boolean = false;
		private var sfxPlayed:Boolean = false;
		
		private const SPLASH_OVER_FRAME:int = 6;
		
		public function doneSplashing():Boolean {
			if ( splashed && sprWaterDrop.frame == SPLASH_OVER_FRAME ) {
				return true;
			}
			return false;
		}
		
		public function WaterDropEntity( depth:Number, drop_value:Number, start_x:Number = 0, start_y:Number = 0, deltaX:Number = 0 ) 
		{
			sfxSplash = new Sfx(SFX_SPLASH);
			sprWaterDrop = new Spritemap(WATERDROP, 16, 16);
			sprWaterDrop.scale = drop_value / 100;
			setHitbox(16, 16);
			width = 16;
			height = 16;

			x = start_x;
			y = start_y;
			dx = deltaX;
			setMaxDepth( depth );
			value = drop_value;
			
			sprWaterDrop.add("default", [0, 1, 2, 1], 12, true);
			sprWaterDrop.add("splash", [3, 4, 5, 6], 12, false);
			sprWaterDrop.play("default");
			graphic = sprWaterDrop;
		}
		
		public function setMaxDepth( depth:Number ):void {
			maxDepth = depth;
		}
		
		public function atMaxDepth():Boolean {
			if ( y >= maxDepth ) {
				if ( !sfxPlayed ) {
					sfxSplash.play();
					sfxPlayed = true;
				}
				return true;
			}
			return false;
		}
		
		override public function update():void 
		{
			super.update();
			
			var plant:PlantEntity = null;
			if ( (atMaxDepth() && !doneSplashing()) || (!splashed && (plant = collide("plant", x, y) as PlantEntity)) ) {
				if( plant != null ) {
					plant.addWater( value );
				}
				// Play drop sfx here:
				
				splashed = true;
				sprWaterDrop.play("splash");
			} else  {
				y += dy;
			}
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
	}

}