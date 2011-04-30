package  CursedIdol
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
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
			
			[Embed(source = "../../gfx/idol/lildude.png")]
			private const HERO:Class;
			
			public function LittleHero() {
					var heroImage:Image = new Image(HERO);					
					super(FP.width / 2, FP.height / 2, heroImage);
					xVel = 0;
					yVel = 0;
					Left = Right = Up = Down = 0;
					setHitbox(heroImage.width, heroImage.height);
			}
			
			override public function update():void {
				//if (Input.pressed(Key.UP))
					//yVel = -3;
				//if (Input.pressed(Key.DOWN))
					//yVel = 3;
				//if (Input.pressed(Key.LEFT))
					//xVel = -3;
				//if (Input.pressed(Key.RIGHT))
					//xVel = 3;					
				//if (Input.released(Key.UP) || Input.released(Key.DOWN)){
					//if (Input.check(Key.UP)){
						//yVel = -2;
					//}
					//else if (Input.check(Key.DOWN) ){						
						//yVel = 2;
					//}					
					//else{
						//yVel = 0;
					//}
				//}
				//if (Input.released(Key.LEFT) || Input.released(Key.RIGHT)){
					//if (Input.check(Key.LEFT)){
						//xVel = -2;
					//}
					//else if (Input.check(Key.RIGHT)){
						//xVel = 2;
					//}
					//else{
						//xVel = 0;
					//}
				//}
					
		/*		yVel = 0;
				if (Input.check(Key.UP))
					yVel -= 2;
				if (Input.check(Key.DOWN))
					yVel += 2;
				xVel = 0;
				if (Input.check(Key.LEFT))
					xVel -= 2;
				if (Input.check(Key.RIGHT))
					xVel += 2;
				
				
				x += xVel;
				y += yVel;
					*/
				
				Left = Right = Up = Down = 0;
				if (Input.check(Key.UP))
					Up = -2;
				if (Input.check(Key.DOWN))
					Down = 2;
				if (Input.check(Key.LEFT))
					Left = -2;
				if (Input.check(Key.RIGHT))
					Right = 2;
				
				var step:Number = 1;
				if ( (Left != 0 && Up != 0) || (Left != 0 && Down != 0) || (Right != 0 && Up != 0) || (Right != 0 && Down != 0) )
					step = 0.5
				x += step * (Left + Right);
				y += step * (Up + Down);
					
				if (collide("impact", x, y))
				{
					trace("I is dead");
				}
			}
		}

}