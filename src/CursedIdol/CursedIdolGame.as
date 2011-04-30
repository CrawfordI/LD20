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
		private var offset:int;
		private var mTimer:int;
		private var mTimer2:int;
		
		[Embed(source = "../../gfx/idol/grass.png")]
		public const GRASS:Class;
		
		public function CursedIdolGame() 		
		{			
			offset = 0;
			
			mTimer = 0;
			
			addGraphic(new Image(GRASS));
			//add(new Meteor());		
			hero = new LittleHero();	
			add(hero);			
		}
		
		override public function update():void {
			super.update();
			mTimer++;
			mTimer2++;
			if (mTimer > 90 && FP.random < .1) {
				mTimer = 0 + offset;
				offset++;
				add(new Meteor(hero.x + FP.rand(128) - 64, hero.y + FP.rand(90) - 45, hero.x, hero.y));
			}			
			if (mTimer > 90) {
				mTimer2 = 0;				
				add(new Meteor(FP.rand(FP.width), FP.rand(FP.height),FP.rand(FP.width), FP.rand(FP.height)));
			}			
			bringToFront(hero);
		}
		
	}

}