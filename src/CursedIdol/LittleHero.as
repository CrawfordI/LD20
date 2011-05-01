package  CursedIdol
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Pseudokai
	 */
	public class LittleHero extends Entity {
		private var xVel:Number;
		private	var yVel:Number;
		private var Left:Number;
		private var Right:Number;
		private var Up:Number;
		private var Down:Number;
		private var speed:Number;
		public var dead:Boolean;
		private var walk:Sfx;
			
			[Embed(source = "../../gfx/idol/lildude.png")]
			private const HERO:Class;
			
			[Embed(source = "../../sfx/idol/idol_walking.mp3")]
			private const WALK:Class;
			
			public function LittleHero() {
					var heroImage:Image = new Image(HERO);					
					super(FP.width / 2, FP.height / 2, heroImage);
					
					walk = new Sfx(WALK);
					//walk.loop();
					
					dead = false;
					
					speed = 2;
					xVel = 0;
					yVel = 0;
					Left = Right = Up = Down = 0;
					setHitbox(heroImage.width, heroImage.height);
			}
			
			override public function update():void {
				
				if(!dead){
					Left = Right = Up = Down = 0;
					if (Input.check(Key.UP))
						Up = -speed;
					if (Input.check(Key.DOWN))
						Down = speed;
					if (Input.check(Key.LEFT))
						Left = -speed;
					if (Input.check(Key.RIGHT))
						Right = speed;
					
					var step:Number = 1;
					if ( (Left != 0 && Up != 0) || (Left != 0 && Down != 0) || (Right != 0 && Up != 0) || (Right != 0 && Down != 0) )
						step = 0.7;
					x += step * (Left + Right);
					y += step * (Up + Down);
					
					if ((!Input.check(Key.UP) && !Input.check(Key.DOWN) && !Input.check(Key.LEFT) && !Input.check(Key.RIGHT)))
						walk.stop();
					else if( !walk.playing )
						walk.loop();
					
					clampHorizontal(0, FP.width, 4);
					clampVertical(0, FP.height, 4);
						
					if (collide("impact", x, y))
					{
						dead = true;
					}
					
					if (collide("crater", x, y))
						speed = .3;
						else speed = 2;
				}
			}
		}

}