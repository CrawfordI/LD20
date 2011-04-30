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
			trace( "NEW DEST! (" + dest.x + ", " + dest.y + ")" );
		}
		
		private function generateNewSpeed():void
		{
			//dx = FP.rand( 5 ) + 1;
			//dy = FP.rand( 5 ) + 1;
			dx = 1;
			dy = 1;
		}
		
		override public function update():void 
		{
			sprCloud.update();
			
			if ( dest.y < y && dy >= 0 )
				dy = -1 * dy;
			if ( dest.y > y && dy < 0 )
				dy = -1 * dy;
			if ( dest.x < x && dx >= 0 )
				dx = -1 * dy;
			if ( dest.x > x && dx < 0 )
				dx = -1 * dx;
			
			
			var r:int = FP.rand(3) + 1;
			switch (r) {
				case 1:
					if( x != dest.x )
						x += dx;
					if( y != dest.y )
						y += dy;
					break;
				case 2:
					if( x != dest.x )
						x += dx;
					break;
				case 3:
					if( y != dest.y )
						y += dy;
					break;
			}
			
			if ( FP.rand( 10 ) == 0 ) {
				generateNewSpeed();
			}
			
			if (collideRect(x, y, dest.x, dest.y, 10, 10)) {
				generateNewDestination();
			}
			
		/*	if ( x <= dest.x + 5 && x >= dest.x - 5 && y >= dest.y - 5 && y <= dest.y + 5 ) {
				trace( "NEW DEST" );
				generateNewDestination();
			}*/
			
		}
		
	}

}