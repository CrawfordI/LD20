package CursedIdol
{
	import flash.display.Graphics;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Image;
	import CursedIdol.LittleHero;
	
	/**
	 * ...
	 * @author Pseudokai
	 */		
	
	
	 

		
	public class CursedIdolGame extends World 
	{			
		[Embed(source = "../../gfx/idol/crater.png")]
		public const crater:Class;	
		private var hero:LittleHero;
		public function CursedIdolGame() 
		{
			hero = new LittleHero();
			add(hero);
			add(new Entity(0, 0, new Image(crater)));
		}
		
	}

}