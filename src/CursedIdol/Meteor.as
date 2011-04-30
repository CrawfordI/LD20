package CursedIdol 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Pseudokai
	 */
	public class Meteor extends Entity 
	{
		[Embed(source = "../../gfx/idol/crater.png")]
		public const CRATER:Class;
		[Embed(source = "../../gfx/idol/shadow.png")]
		public const SHADOW:Class;
		
		private var fallTime:int;
		private var fallStart:int;
		private var crater:Image;
		private var shadow:Image;
		
		public function Meteor() 
		{
			fallStart = FP.rand(180) + 120;
			fallTime = fallStart;
			shadow = new Image(SHADOW);
			crater = new Image(CRATER);
			graphic = shadow;
		}
		
		override public function update():void {			
			if (fallTime > 0){
				fallTime--;		
				shadow.alpha = (fallStart - fallTime) / fallStart;
			}
			else
				graphic = crater;
			
			
		}
	
	}

}