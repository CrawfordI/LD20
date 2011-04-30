package  
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author Pseudokai
	 */
	public class MainMenu extends World 
	{
		var gameTitle:Text;
		public function MainMenu() 
		{
			gameTitle = new Text("FUCK YEAH!", 0, 0);
			gameTitle.size = 20;
			addGraphic(gameTitle);
			
		}
		
	}

}