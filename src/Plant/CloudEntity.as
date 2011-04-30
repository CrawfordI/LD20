package Plant 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import flash.geom.Point;
	import net.flashpunk.tweens.motion.QuadPath;
	import net.flashpunk.Tween;
	
	
	
	/**
	 * ...
	 * @author Matthew Dalrymple
	 */
	public class CloudEntity extends Entity
	{
		[Embed(source = '../../gfx/plant/plant_cloud.png')]
		private const CLOUD:Class;
		
		private var dest:Point;
		
		private var dx:Number = 1;
		private var dy:Number = 1;
		
		private var path:QuadPath;
		
		public var sprCloud:Spritemap;
		
		public function CloudEntity( start_x:int = 0, start_y:int = 0 )
		{
		/*	path = new QuadPath(null, Tween.LOOPING);
			path.addPoint(x, y);
			path.addPoint(FP.rand( FP.width ), FP.rand( 150 ));
			path.addPoint(FP.rand( FP.width ), FP.rand( 150 ));
			path.addPoint(FP.rand( FP.width ), FP.rand( 150 ));
			path.addPoint(FP.rand( FP.width ), FP.rand( 150 ));
			path.setMotion(100, null);
			path.start();*/
			
			//dest = new Point (50, 50);
			sprCloud = new Spritemap(CLOUD, 75, 50);
			sprCloud.add("default", [0], 1, true);
			sprCloud.play("default");
			
			
			x = 0 - sprCloud.width;
			y = FP.rand( 200 );
			
			if ( start_x > 0 || start_y > 0 ) {
				x = start_x;
				y = start_y;
			}
			
			dx = (0.25) * FP.rand( 2 ) + 0.25;
			
			
			graphic = sprCloud;

		}
		
		public function isOffScreen():Boolean
		{
			if ( x < FP.width ) {
				return false;
			}
			return true;
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
		
		override public function update():void 
		{
			
			x += dx;
			
			sprCloud.update();
			
		}
		
	}

}