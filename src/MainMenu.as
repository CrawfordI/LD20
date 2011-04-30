package  
{
	import flash.geom.Point;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Pseudokai
	 */
	public class MainMenu extends World 
	{
		private var gameTitle:Text;
		private var menuOptions:Array;
		private var menuOrigin:Point;
		private var cursor:int;
		
		public function MainMenu() 
		{
			menuOptions = new Array();
			menuOrigin = new Point (50, 50);
			
			cursor = 0;
			
			Text.size = 20;
			gameTitle = new Text("FUCK YEAH!", menuOrigin.x, menuOrigin.y);
			Text.size = 12;
			for (var i:int = 0; i < 5; i++) {
				var opt:Text = new Text("Option " + i, menuOrigin.x, menuOrigin.y +(20 * (i + 1)));
				menuOptions.push(opt);
				addGraphic(menuOptions[i]);
			}						
			
			addGraphic(gameTitle);
			
		}
		
		override public function update():void 
		{
			if (Input.pressed(Key.DOWN)) {
				cursor++;
				if (cursor >= menuOptions.length)
					cursor = 0;
			}
			if (Input.pressed(Key.UP)) {
				cursor--;
				if (cursor < 0)
					cursor = menuOptions.length - 1;
			}
			
			for (var i:int = 0; i < menuOptions.length; i++) {
				if (cursor == i)
					menuOptions[i].color = 0xFF6103;
				else
					menuOptions[i].color = 0xFFFFFF;
			}
		}
		
	}

}