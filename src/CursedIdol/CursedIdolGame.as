package CursedIdol
{
	import flash.display.Graphics;
	import flash.events.TextEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
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
		
		private var lost:Boolean;
		
		private var lostText:Text;
		private var promptText:Text;
		private var scoreText:Text;
		
		private var prevWorld:World;
		
		private var mFringe:Array;
		private var score:int;
		private var scoreTextH:Entity;
		
		[Embed(source = "../../gfx/idol/grass.png")]
		public const GRASS:Class;
		
		public function CursedIdolGame(pw:World) 		
		{	
			mFringe = new Array();
			
			score = 0;
			
			offset = 0;
			
			mTimer = 0;
			
			lost = false;
			
			prevWorld = pw;
			
			addGraphic(new Image(GRASS));
			
			hero = new LittleHero();	
			add(hero);	
			
			Text.size = 30;
		    lostText = new Text("You lose!", FP.halfWidth, FP.halfHeight);
			Text.size = 14;
			promptText = new Text("Press any key to return to menu", FP.halfWidth, FP.halfHeight + lostText.height / 2);
			scoreText = new Text("Score: 0000000000", 10, 20);
			scoreText.text = "Score: " + score;
			
			scoreTextH = addGraphic(scoreText);			
			
			lostText.centerOO();
			promptText.centerOO();
			//scoreText.centerOO();
		}
		
		override public function update():void {
			super.update();			
			if(!lost){
				mTimer++;
				mTimer2++;
				if (mTimer > 90 && FP.random < .1) {
					var mt:Meteor = new Meteor(hero.x + FP.rand(128) - 64, hero.y + FP.rand(90) - 45, hero.x, hero.y);
					mTimer = 0 + offset;
					offset++;
					add(mt);
					mFringe.push(mt);
				}			
				if (mTimer2 > 90) {
					var mt2:Meteor = new Meteor(FP.rand(FP.width), FP.rand(FP.height), FP.rand(FP.width), FP.rand(FP.height));
					mTimer2 = 0;				
					add(mt2);
					mFringe.push(mt2);
				}			
				bringToFront(hero);
				
				var mFl:int = mFringe.length;
				for (var i:int = 0; i < mFl; i++) {
					var m:Meteor = mFringe.shift();
					if (m.type == "crater"){
						score += m.scale * 100;
					}
					else {
						mFringe.push(m);
					}
					
					//trace(score);
					scoreText.text = "Score: " + score;
					remove(scoreTextH);
					scoreTextH = addGraphic(scoreText);
				}
				
				if (hero.dead){
					lost = true;				
					addGraphic(lostText);
					addGraphic(promptText);
				}
			}
			else {
				if (Input.pressed(Key.ANY))
					FP.world = prevWorld;
			}
		}
		
	}

}