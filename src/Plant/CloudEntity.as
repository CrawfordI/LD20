package Plant 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import flash.geom.Point;
	import net.flashpunk.utils.Input;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Matthew Dalrymple
	 */
	public class CloudEntity extends Entity
	{
		[Embed(source = '../../gfx/plant/plant_cloud.png')]
		private const CLOUD:Class;
		
		[Embed(source = "../../sfx/plant/plant_waterdrop.mp3")]
		public const SFX_WATERDROP:Class;
		
		[Embed(source = "../../sfx/plant/plant_cloudspent.mp3")]
		public const SFX_CLOUDSPENT:Class;

		private var dx:Number = 1;
		private var dy:Number = 1;
		private var selected:Boolean;
		private var droppedWater:Boolean = false;
		
		private var sfxWaterDrop:Sfx;
		private var sfxCloudSpent:Sfx;
		
		public var sprCloud:Spritemap;
		
		public function alreadyDroppedWater():Boolean {
			return droppedWater;
		}
		
		public function dropWater():WaterDropEntity {
			sfxWaterDrop.play();
			droppedWater = true;
			return new WaterDropEntity( FP.height - (FP.rand( 100 ) + 25), 100 * sprCloud.scale, centerX, centerY );
		}
		
		public function wasSelected():Boolean {
			if ( selected ) {
				selected = false;
				return true;
			}
			return false;
		}
		
		public function CloudEntity( start_x:Number = 0, start_y:Number = 0 )
		{
			sprCloud = new Spritemap(CLOUD, 75, 50);
			sprCloud.add("default", [0, 1, 2, 1], 4, true);
			sprCloud.play("default");
			graphic = sprCloud;
			
			sfxWaterDrop = new Sfx(SFX_WATERDROP);
			sfxCloudSpent = new Sfx(SFX_CLOUDSPENT);
			
			x = 0 - sprCloud.width;
			y = FP.rand( 200 );
			
			if ( start_x > 0 || start_y > 0 ) {
				x = start_x;
				y = start_y;
			}
			
			dx = (0.15) * FP.rand( 4 ) + 0.25;
			
			if( FP.rand( 1 ) ) {
				sprCloud.scale = 1.5 + dx;
			} else {
				sprCloud.scale = 1.5 - dx;
			}
			if ( sprCloud.scale <= 0 )
				sprCloud.scale = 1.0;
			
			
			width = sprCloud.scaledWidth;
			height = sprCloud.scaledHeight;
			
			setHitbox(sprCloud.scaledWidth - 10, sprCloud.scaledHeight -15, -10, -10);
			type = "cloud";
		}
		
		public function isOffScreen():Boolean
		{
			if ( x < FP.width ) {
				return false;
			}
			return true;
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
		
		override public function update():void 
		{
			
			x += dx;
			
			sprCloud.update();
			
			if ( Input.mouseReleased ) {
				// Did the user press and release on this entity?
				if ( selected && collidePoint(x, y, Input.mouseX, Input.mouseY)  ) {
				//	trace("PRESSED AND RELEASED ON A CLOUD!");
				}
				selected = false;
			} else if (!Input.mouseDown) {
				// Not holding mouse down anymore
				selected = false;
			} else if (Input.mousePressed  && collidePoint(x, y, Input.mouseX, Input.mouseY)  ) {
				// The mouse button was just pressed this frame.
				selected = true;
				if ( alreadyDroppedWater() ) {
					sfxCloudSpent.play();
				}
			}
			
		}
		
	}

}