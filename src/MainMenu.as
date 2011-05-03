package  
{
	import flash.geom.Point;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import Vase.VaseGame;
	
	import CursedIdol.CursedIdolGame
	import Plant.PlantGame;
	
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
		
		private const GAME_PLANT:int = 0;
		private const GAME_IDOL:int = 1;
		private const GAME_VASE:int = 2;
		
		private var bgMusic:Sfx;
		
		[Embed(source = "../bgm/temp.mp3")]
		public const MUSIC:Class;		
			
		public function MainMenu() 
		{
			bgMusic = new Sfx(MUSIC);
			//hellaMusic.play();
			
			
			menuOptions = new Array();
			menuOrigin = new Point (50, 50);
			
			
			cursor = 0;			
			
			Text.size = 16;
			gameTitle = new Text("It's dangerious to go alone, take one of these items:", menuOrigin.x, menuOrigin.y);
			Text.size = 14;
			for (var i:int = 0; i < 3; i++) {								
				var opt:Text;
				if ( i == GAME_PLANT )
					opt = new Text("--- Healing Plant Seed",  menuOrigin.x + 15, menuOrigin.y +(50 * (i + 1)));
				else if ( i == GAME_IDOL )
					opt = new Text("--- Meteor Spell?",  menuOrigin.x + 15, menuOrigin.y +(50 * (i + 1)));
				else if ( i == GAME_VASE )
					opt = new Text("--- Vase", menuOrigin.x + 15, menuOrigin.y + (50 * (i + 1)));
				else
					opt = new Text("Option " + i, menuOrigin.x + 15, menuOrigin.y +(50 * (i + 1)));
				menuOptions.push(opt);
				addGraphic(menuOptions[i]);
			}						
			
			addGraphic(gameTitle);
			
		}
		
		override public function begin():void {
			super.begin();
			bgMusic.loop();
			
		}
		
		override public function end():void {
			super.end();
			bgMusic.stop();
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
			
			if (Input.pressed(Key.ENTER)) {
				switch (cursor) {
					case GAME_PLANT:
						bgMusic.stop();
						FP.world = new PlantGame(this);
						break;
					case GAME_IDOL:
						bgMusic.stop();
						FP.world = new CursedIdolGame(this);
						break;
					case GAME_VASE:
						bgMusic.stop();
						FP.world = new VaseGame();
						break;
				}
			}
		}
		
	}

}