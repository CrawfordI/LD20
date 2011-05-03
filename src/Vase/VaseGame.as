package Vase 
{
	import flash.display.Graphics;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
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
			var LevelData:XML = level.getLevelData();
			var o:XML;
			
			for each (o in LevelData.objects[0].ladder) { add(new Ladder(o.@x, o.@y)); }
			
			add(new Player(new Point(FP.screen.width >> 1, FP.screen.height >> 1)));
			add(new Portal(new Point(FP.screen.width >> 1, FP.screen.height >> 2)));
	
			var fglevel:FGLevel =  FGLevel(add(new FGLevel(DEFAULT_MAP)));
			fglevel.getLevelData();
			
			super.begin();
		}
		
		
	
		
	}

}