package Plant 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Matthew Dalrymple
	 */
	public class CloudEntity extends Entity
	{
		[Embed(source = '../../gfx/plant/plant_cloud.png')]
		private const CLOUD:Class;
		
		private var dest:Point;
		
		private var dx:int = 1;
		private var dy:int = 1;
		
		public var sprCloud:Spritemap;
		
		public function CloudEntity() 
		{
			dest = new Point (50, 50);
			sprCloud = new Spritemap(CLOUD, 75, 50);
			sprCloud.add("default", [0], 1, true);
			sprCloud.play("default");
			graphic = sprCloud;

		}
		
		private function generateNewDestination():void
		{
			dest.x = FP.rand( FP.width );
			dest.y = FP.rand( 150 );
		}
		
		private function generateNewSpeed():void
		{
			dx = FP.rand( 5 ) + 1;
			dy = FP.rand( 5 ) + 1;
		}
		
		override public function update():void 
		{
			sprCloud.update();
			
			var r:int = FP.rand(3) + 1;
			switch (r) {
				case 1:
					x += dx;
					y += dy;
					break;
				case 2:
					x += dx;
					break;
				case 3:
					y += dy;
					break;
			}
			
			if ( FP.rand( 10 ) == 0 ) {
				generateNewSpeed();
			}
			
			if ( x == dest.x && y == dest.y )
				generateNewDestination();
			
		}
		
	}

}