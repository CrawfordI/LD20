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
		
		[Embed(source = "../../gfx/idol/grass.png")]
		public const GRASS:Class;
		
		public function CursedIdolGame() 		
		{			
			
			
			mTimer = 0;
			
			addGraphic(new Image(GRASS));
			//add(new Meteor());		
			hero = new LittleHero();	
			add(hero);			
		}
		
		override public function update():void {
			super.update();
			mTimer++;
			if (mTimer > 90 && FP.random < .1) {
				mTimer = 0;
				add(new Meteor(hero.x + FP.rand(128) - 64, hero.y + FP.rand(90) - 45, hero.x, hero.y));
			}			
			bringToFront(hero);
		}
		
	}

}