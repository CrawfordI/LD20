package Vase 
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author ...
	 */
	
	public class Ladder extends Entity
	{
		[Embed(source = '../../gfx/vase/ladder.png')] public var LADDER:Class;
	public var sprladder:Image = new Image(LADDER);
		public function Ladder(x:int, y:int)
		{
			super(x, y);
			
			graphic = sprladder;
			type = "ladder";
			
			setHitbox(32, 32);
		}
		
	}

}