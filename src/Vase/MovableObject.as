package Vase 
{
	import flash.display.Graphics;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MovableObject extends Entity
	{
		public var vel:Point = new Point(0, 0); 
		public var accel:Point = new Point(0, 0);
		public var mFriction:Point = new Point(0.5, 0.5);
		public var mMaxspeed:Point = new Point(3, 8);
		public var mGravity:Number = 0.2
		public var solid:String = "Solid";
		
		public function MovableObject(loc:Point) 
		{
			x = loc.x;
			y = loc.y;
			type = solid;
			super(x, y);			
		}
		
		override public function update():void 
		{
			processMovement();
			super.update();
		}
		
		protected function processMovement(xMovement:Boolean = true, yMovement:Boolean = true):void
		{
			if ( xMovement )
			{
				if (!motionx(this, vel.x)) { vel.x = 0; }
				vel.x += accel.x;
			}
			
			if ( yMovement )
			{
				if (!motiony(this, vel.y)) { vel.y = 0; }
				
				vel.y += accel.y;
			}
			
		}
		
		public function friction(x:Boolean = true, y:Boolean = true):void 
		{
			//if we should use friction, horizontally
			if ( x )
			{
				//speed > 0, then slow down
				if ( vel.x > 0 ) {
					vel.x -= mFriction.x;
					//if we go below 0, stop.
					if ( vel.x < 0 ) { vel.x = 0; }
				}
				//speed < 0, then "speed up" (in a sense)
				if ( vel.x < 0 ) {
					vel.x += mFriction.x;
					//if we go above 0, stop.
					if ( vel.x > 0 ) { vel.x = 0; }
				}
			}
			
		}
		
		public function motionx(e:Entity, spdx:Number):Boolean
		{
			//check each pixel before moving it
			for (var i:int = 0; i < Math.abs(spdx); i++) 
			{
				//if we've moved
				var moved:Boolean = false;
				var below:Boolean = true;
				
				if (!e.collide(solid, e.x, e.y + 1)) { below = false; }
				
				//if we don't hit a solid in the direction we're moving, move....
				if (!e.collide(solid, e.x + FP.sign(spdx), e.y)) 
				{
					//increase/decrease positions
					//if the player is in the way, simply don't move (but don't count it as stopping)
					/*if (!e.collide(Global.player.type, e.x + FP.sign(spdx), e.y)) {*/ e.x += FP.sign(spdx); //}
						
					//we've moved
					moved = true;
						
					//stop checking for slope (so we don't fly up into the air....)
					break;
				}
					
				//if we are now in the air, but just above a platform, move us down.
				if (below && !e.collide(solid,e.x, e.y + 1)) { e.y += 1; }
				
				//if we haven't moved, set our speed to 0
				if ( !moved ) { return false; }
			}
			//hit nothing!
			return true;
		}
		
		public function motiony(e:Entity, spdy:Number):Boolean
		{
			//for each pixel that we will move...
			for ( var i:int = 0; i < Math.abs(spdy); i ++ )
			{
				//if we DON'T collide with solid
				if (!e.collide(solid, e.x, e.y + FP.sign(spdy))) { 
					//if we don't run into a player, them move us
					/*if (!e.collide(Global.player.type, e.x, e.y + FP.sign(spdy))) { */e.y += FP.sign(spdy);// }
					//but note that we wont stop our movement if we hit a player.
				} else { 
					//stop movement if we hit a solid
					return false; 
				}
			}
			
			//hit nothing!
			return true;
		}
		
			public function gravity():void 
		{
			//increase velocity/speed based on gravity
			vel.y += mGravity;
			
		}
		
		public function maxspeed(x:Boolean = true, y:Boolean = true):void
		{
			if ( x ) {
				if ( Math.abs(vel.x) > mMaxspeed.x )
				{
					vel.x = mMaxspeed.x * FP.sign(vel.x);
				}
			}
			
			if ( y ) {
				if ( Math.abs(vel.y) > mMaxspeed.y )
				{
					vel.y = mMaxspeed.y * FP.sign(vel.y);
				}
			}
		}
	}

}