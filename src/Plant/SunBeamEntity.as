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
	public class SunBeamEntity extends Entity
	{
		[Embed(source = '../../gfx/plant/plant_sunbeam.png')]
		private const SUNBEAM:Class;
		
		[Embed(source = '../../sfx/plant/plant_sizzle.mp3')]
		private const SFX_SIZZLE:Class;
		
		private var sfxSizzle:Sfx;
		public var sprSunBeam:Spritemap;
		
		private var dx:Number = 0;
		private var dy:Number = 3.75;
		
		private var maxDepth:Number = FP.height;
		
		private var sfxPlayed:Boolean = false;
		
		public function SunBeamEntity( start_x:int = 0, start_y:int = 0 ) 
		{
			sfxSizzle = new Sfx(SFX_SIZZLE);
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
			if ( y >= maxDepth ) {
				if ( !sfxPlayed ) {
					sfxPlayed = true;
					sfxSizzle.play();
				}
				return true;
			}
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