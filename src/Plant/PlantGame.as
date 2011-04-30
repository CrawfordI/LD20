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
		private var Sun:SunEntity;
		private var Cloud:CloudEntity;
		
		[Embed(source = '../../gfx/Plant/plant_bg.png')]
		private const BACKGROUND:Class;

		public function PlantGame() 
		{	
			Background = new Image(BACKGROUND);
			Sun = new SunEntity();
			Cloud = new CloudEntity();
			
			var gameTitle:Text;
			Text.size = 20;
			gameTitle = new Text("PLANT GAME!!!!!!", 640/2, 480/2);

			addGraphic(Background);
			addGraphic(gameTitle);
			add(Sun);
			add(Cloud);
			
		}
		
		override public function update():void 
		{
			Sun.update();
			Cloud.update();
		}	
	}

	
}

