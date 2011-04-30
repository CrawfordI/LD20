package CursedIdol
{
	import net.flashpunk.Entity;
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
		private var hero:LittleHero;
		public function CursedIdolGame() 
		{
			hero = new LittleHero();
			add(hero);
		}
		
	}

}