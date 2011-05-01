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
	public class Player extends MovableObject
	{
	
		private var onGround:Boolean;
		private var direction:Boolean;
		public var movement:Number = 1;
		public var jump:Number = 5;
		
		[Embed(source = "../../gfx/vase/maindude.png")] public const GUY:Class;
		public function Player(loc:Point) 
		{
			x = loc.x;
			y = loc.y;
			var guyImage:Image = new Image(GUY);
			type = "Player";
			super(loc, guyImage);
			setHitbox(guyImage.width, guyImage.height);
		}
		
		override public function update():void
		{
			updateMovement();
			super.update();
		}
		
		private function updateMovement():void
		{
			onGround = false;
			if (collide(solid, x, y + 1)) 
			{ 
				onGround = true;
			}
		
			accel.x = 0;
			
			if (Input.check(Key.LEFT) && vel.x > -mMaxspeed.x) { accel.x = -movement; direction = false; }
			if (Input.check(Key.RIGHT) && vel.x < mMaxspeed.x) { accel.x = movement; direction = true; }
			
			//friction (apply if we're not moving, or if our speed.x is larger than maxspeed)
			if ( (! Input.check(Key.LEFT) && ! Input.check(Key.RIGHT)) || Math.abs(vel.x) > mMaxspeed.x ) { friction(true, false); }
			
			//jump
			if ( Input.check(Key.UP) ) 
			{
				if (onGround) { 
					vel.y = -jump; 		 
				}
			}
			
			gravity();
			
			maxspeed(false, true);
			
			//variable jumping (tripple gravity)
			if (vel.y < 0 && !Input.check(Key.UP)) { gravity(); gravity(); }
			
			
			//set the sprites according to if we're on the ground, and if we are moving or not
			/*if (onGround)
			{
				if (speed.x < 0) { sprPlayer.play("walkLeft"); }
				if (speed.x > 0) { sprPlayer.play("walkRight"); }
				
				if (speed.x == 0) {
					if (direction) { sprPlayer.play("standRight"); } else { sprPlayer.play("standLeft"); }
				}
			} else {
				if (direction) { sprPlayer.play("jumpRight"); } else { sprPlayer.play("jumpLeft"); }
				
				//are we sliding on a wall?
				//if (collide(solid, x - 1, y)) { sprPlayer.play("slideRight"); }
				//if (collide(solid, x + 1, y)) { sprPlayer.play("slideLeft"); }
			}*/
			
			
			//set the motion. We set this later so it stops all movement if we should be stopped
			processMovement();
			
			//did we just get.. KILLED? D:
			if (collide("Spikes", x, y) && vel.y > 0)
			{
				//killme!
				//killme();
			}
			
		}
		
	}

}