package CursedIdol
{
	import flash.display.Graphics;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Draw;
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
		private var mTimer:int;
		
		public function CursedIdolGame() 		
		{
			hero = new LittleHero();
			add(hero);
			mTimer = 0;
			//add(new Meteor());						
		}
		
		override public function update():void {
			super.update();
			mTimer++;
			if (mTimer > 90 && FP.random < .1) {
				mTimer = 0;
				add(new Meteor(hero.x + FP.rand(128) - 64, hero.y + FP.rand(90) - 45));
			}
		}
		
	}

}