package Vase 
{
	import flash.utils.ByteArray;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Level extends Entity
	{
		private var _tiles:Tilemap;
		private var _objects:Tilemap;
		private var _grid:Grid;
		public var LevelData:XML;
		
		[Embed(source = "../../gfx/vase/bgtiles.png")] public const TILES:Class;
		[Embed(source = "../../gfx/vase/ladder.png")] public const OBJECTS:Class;
		
		public var xmlSrc:Class;
		public function Level(xml:Class)
		{
				_tiles = new Tilemap(TILES, 640, 480, 32, 32);
				_objects = new Tilemap(OBJECTS, 640, 480, 32, 32);
				//addGraphic(_tiles);
				//addGraphic(_objects);
				graphic = _tiles;
				layer = 1;
				
				_grid = new Grid(640, 480, 32, 32, 0, 0);
				mask = _grid;
				
				type = "Solid";
				xmlSrc = xml;
		}
		
		public function getLevelData():XML {
			return loadLevel(xmlSrc);
		}
		
		private function loadLevel(xml:Class):XML
		{
			var data:ByteArray = new xml;
			var dataString:String = data.readUTFBytes( data.length );
			LevelData = new XML(dataString);
			
			var dataList:XMLList;
			var dataElement:XML;
			
			var o:XML;
			
			dataList = LevelData.solid.tile;
			for each(dataElement in dataList)
			{
				_tiles.setTile(int(dataElement.@x) >> 5, int(dataElement.@y) >> 5, int(dataElement.@tx) >> 5);
				_grid.setTile(int(dataElement.@x) >> 5, int(dataElement.@y) >> 5, ((int(dataElement.@tx) >> 5) == 2));
			}
			
			return LevelData;
		}
	}

}