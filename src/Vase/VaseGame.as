package Vase 
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.World
	import org.flashdevelop.utils.TraceLevel;
	/**
	 * ...
	 * @author ...
	 */
	public class VaseGame extends World
	{
		[Embed(source = "levels/testlevel.oel", mimeType = "application/octet-stream")] private static const DEFAULT_MAP:Class;
		public function VaseGame() 
		{
			
		}
		
		override public function begin():void
		{
			var level:Level = Level(add(new Level(DEFAULT_MAP)));
			add(new Player(new Point(FP.screen.width >> 1, FP.screen.height >> 1)));
			
			super.begin();
		}
		
	}

}