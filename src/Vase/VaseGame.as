package Vase 
{
	import flash.display.Graphics;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.World
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Text;
	import org.flashdevelop.utils.TraceLevel;
	/**
	 * ...
	 * @author ...
	 */
	public class VaseGame extends World
	{
		[Embed(source = "levels/testlevel.oel", mimeType = "application/octet-stream")] private static const DEFAULT_MAP:Class;
		public var portal:Portal;
		public var player:Player;
		private var promptText:Text;
		private var prevWorld:World;
		
		public function VaseGame(pw:World) 
		{
			prevWorld = pw;
			promptText = new Text("Press R to return to menu", FP.halfWidth, FP.halfHeight / 2);
			promptText.centerOO();
		}
		
		override public function begin():void
		{
			var level:Level = Level(add(new Level(DEFAULT_MAP)));
			var LevelData:XML = level.getLevelData();
			var o:XML;
			
			for each (o in LevelData.objects[0].ladder) { add(new Ladder(o.@x, o.@y)); }
			portal = new Portal(new Point(FP.screen.width >> 1, FP.screen.height >> 2));
			player = new Player(new Point(FP.screen.width >> 1, FP.screen.height >> 1));
			add(player);
			add(portal);
	
			var fglevel:FGLevel =  FGLevel(add(new FGLevel(DEFAULT_MAP)));
			fglevel.getLevelData();
			
			super.begin();
		}
		
		override public function update():void
		{
			if (player.hit == true) {
				addGraphic(promptText);
				if (Input.pressed(Key.R)) 
					FP.world = prevWorld;
			} else {
				super.update();
			}
		}
	
		
	}

}