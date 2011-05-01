package Vase 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Image;
	import Plant.CloudEntity;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Player extends Entity
	{
		private var vel:Point;
		private var speed:int;
		[Embed(source = "../../gfx/vase/maindude.png")] public const GUY:Class;
		public function Player(loc:Point) 
		{
			x = loc.x;
			y = loc.y;
			vel = new Point;
			speed = 2;
			var guyImage:Image = new Image(GUY);		
			super(FP.width / 2, FP.height / 2, guyImage);
			setHitbox(guyImage.width, guyImage.height);
		}
		
		override public function update():void
		{
			updateMovement();
			updateCollision();
			super.update();
		}
		
		private function updateMovement():void
		{
			var movement:Point = new Point;
			var vy:int;
			var vx:int;
			vy = (Input.check(Key.DOWN) ? 1 : 0) - (Input.check(Key.UP) ? 1 : 0);
			vx = (Input.check(Key.RIGHT)? 1 : 0) - (Input.check(Key.LEFT)?1 : 0);
			vel.x = vx * speed;
			vel.y = vy * speed;
		}
		
		private function updateCollision():void 
		{
			x += vel.x;
			y += vel.y;
			
			if (collide("level", x, y)) {
				
			}
		}
		
	}

}