package Plant 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Matthew Dalrymple
	 */
	public class SunBeamEntity extends Entity
	{
		[Embed(source = '../../gfx/plant/plant_sunbeam.png')]
		private const SUNBEAM:Class;
		
		public var sprSunBeam:Spritemap;
		
		private var dx:Number = 0;
		private var dy:Number = 3.75;
		
		private var maxDepth:Number = FP.height;
		
		public function SunBeamEntity( start_x:int = 0, start_y:int = 0 ) 
		{
			sprSunBeam = new Spritemap(SUNBEAM, 16, 16);
			setHitbox(16, 16);
			width = 16;
			height = 16;

			x = start_x;
			y = start_y;
			
			sprSunBeam.add("default", [0, 1, 2, 1], 12, true);
			sprSunBeam.play("default");
			graphic = sprSunBeam;
		}
		
		public function setMaxDepth( depth:Number ):void {
			maxDepth = depth;
		}
		
		public function atMaxDepth():Boolean {
			if ( y >= maxDepth )
				return true;
			return false;
		}
		
		override public function update():void 
		{
			super.update();
			
			y += dy;
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
	}

}