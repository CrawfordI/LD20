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
		private var accel:Number;
		private var vy:int;
		private	var vx:int;
		private var jumping:Boolean;
		
		[Embed(source = "../../gfx/vase/maindude.png")] public const GUY:Class;
		public function Player(loc:Point) 
		{
			x = loc.x;
			y = loc.y;
			vel = new Point;
			speed = 2;
			accel = 3;
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
			
			vx = (Input.check(Key.RIGHT) ? 1 : 0) - (Input.check(Key.LEFT) ? 1 : 0);
			if (Input.check(Key.UP) && Math.abs(vel.y) < 1) {
				vel.y = -6;
			}
			vel.x = vx * speed;
			vel.y += accel * FP.elapsed * FP.elapsed;
		}
		
		private function updateCollision():void 
		{
			y += vel.y;		
			if (collide("level", x, y)) {
				if (vel.y > 0) {
					vel.y = 0;
					y = Math.floor(y >> 5) << 5 + 32 - height;
				} else if (vel.y < 0) {
					vel.y = 0;
					y = Math.floor(y >> 5) << 5 + 32;
				}
				vel.y -= accel * FP.elapsed * FP.elapsed;
			}
			x += vel.x;
			if (collide("level", x, y)) {
				if (vel.x > 0) {
					vel.x = 0;
					x = Math.floor(x >> 5) << 5 + 32 -width;
				} else if (vel.x < 0) {
					vel.x = 0;
					x = Math.floor(x >> 5) << 5 + 32;
				}
				
			}
			
		}
		
	}

}