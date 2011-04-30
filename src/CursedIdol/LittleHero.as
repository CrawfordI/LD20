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
			
			[Embed(source = "../../gfx/idol/lildude.png")]
			private const HERO:Class;
			
			public function LittleHero() {
					super(FP.width / 2, FP.height / 2, new Image(HERO));
					xVel = 0;
					yVel = 0;
					//graphic = new Image(HERO);					
			}
			
			override public function update():void {
				if (Input.pressed(Key.UP))
					yVel = -3;
				if (Input.pressed(Key.DOWN))
					yVel = 3;
				if (Input.pressed(Key.LEFT))
					xVel = -3;
				if (Input.pressed(Key.RIGHT))
					xVel = 3;					
				if (Input.released(Key.UP) || Input.released(Key.DOWN))
					yVel = 0;
				if (Input.released(Key.LEFT) || Input.released(Key.RIGHT))
					xVel = 0;
					
				x += xVel;
				y += yVel;
					
			}
		}

}