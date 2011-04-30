package Plant
{
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Matthew Dalrymple
	 */
	public class PlantGame extends World
	{
		
		private var Background:Image;
		private var BD:Backdrop;
		
		[Embed(source = '../../gfx/Plant/plant_bg.png')]
		private const BACKGROUND:Class;

		public function PlantGame() 
		{	
			Background = new Image(BACKGROUND);
		//	BD = new Backdrop(Background, false, false);
			var gameTitle:Text;
			Text.size = 20;
			gameTitle = new Text("PLANT GAME!!!!!!", 100, 100);

			addGraphic(Background);
			addGraphic(gameTitle);
			
		}
		
		override public function update():void 
		{
			
		}	
	}

	
}

