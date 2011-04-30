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
	
	
	 

		
	public class CursedIdol extends World 
	{				
		var hero:LittleHero;
		public function CursedIdol() 
		{
			hero = new LittleHero();
			add(hero);
		}
		
	}

}