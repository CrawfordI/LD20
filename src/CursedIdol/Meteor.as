package CursedIdol 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	
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
		[Embed(source = "../../sfx/idol/idol_crash.mp3")]
		public const CRASH:Class;
		[Embed(source = "../../sfx/idol/idol_meteorfall.mp3")]
		public const FALL:Class;
		
		private var fallTime:int;
		private var fallStart:int;
		private var crater:Image;
		private var shadow:Image;
		private var xVel:Number;
		private var yVel:Number;
		public var falling:Boolean;
		public var scale:Number;
		private var fallSound:Sfx;
		
		private const craterPad:Number = 8;
		
		
		public function Meteor(iX:Number, iY:Number, xT:Number, yT:Number) 
		{
			//this.centerOrigin();
			falling = true;			
			scale = .5 + (FP.random * 2);
			fallStart = FP.rand(120) + 80;
			fallTime = fallStart;
			shadow = new Image(SHADOW);
			shadow.alpha = 0;
			shadow.scale = scale;
			crater = new Image(CRATER);
			crater.scale = scale;
			graphic = shadow;	
			
			fallSound = new Sfx(FALL);			
			fallSound.play();
			
			x = iX - shadow.scaledWidth/2;
			y = iY - shadow.scaledHeight / 2;								
			
			xVel = (xT - iX) / fallStart;
			yVel = (yT - iY) / fallStart;			
		}
		
		override public function update():void {
			if(falling){
				if (fallTime > 0){
					fallTime--;		
					shadow.alpha = (fallStart - fallTime) / fallStart;
					x += xVel;
					y += yVel;
				}					
				else {
					falling = false;
					graphic = crater;
					width = crater.scaledWidth;
					height = crater.scaledHeight;
					
					this.setHitbox(width, height, 0, 0);
					
					x -= (width - shadow.scaledWidth) / 2;
					y -= (height - shadow.scaledHeight) / 2;
					type = "impact";
					fallSound.stop();
					
					var crash:Sfx = new Sfx(CRASH);
					crash.play();

				}
			}
			else {
				type = "crater";
				this.setHitbox(crater.scaledWidth - (craterPad * scale * 4) , crater.scaledHeight - (craterPad * scale * 2), -craterPad * scale* 2, - craterPad * scale / 2);
			}						
		}
	
	}

}