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
	public class FGLevel extends Entity
	{
		private var _tiles:Tilemap;
		public var LevelData:XML;
		
		[Embed(source = "../../gfx/vase/fgtiles.png")] public const TILES:Class;
		
		public var xmlSrc:Class;
		
		public function FGLevel(xml:Class) 
		{
	
				_tiles = new Tilemap(TILES, 640, 480, 32, 32);
				graphic = _tiles;
				layer = 0;
				type = "ForeGround";
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
			
			dataList = LevelData.foreGround.tile;
			for each(dataElement in dataList)
			{
				_tiles.setTile(int(dataElement.@x) >> 5, int(dataElement.@y) >> 5, int(dataElement.@tx) >> 5);
			}		
			return LevelData;
		}
		
	}

}