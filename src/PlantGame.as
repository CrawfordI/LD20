package 
{
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author Matthew Dalrymple
	 */
	public class PlantGame extends World
	{
		
		
		public function PlantGame() 
		{	
			var gameTitle:Text;
			Text.size = 20;
			gameTitle = new Text("PLANT GAME!!!!!!", 100, 100);

			addGraphic(gameTitle);
			
		}
		
		override public function update():void 
		{
			
		}	
	}
	
}