package Vase 
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author ...
	 */
	
	public class fgGrass extends Entity
	{
		[Embed(source = "../../gfx/vase/fggrass.png")] public const FGGRASS:Class;
		public var sprgrass:Image = new Image(FGGRASS);
	
		public function fgGrass(x:int, y:int) 
		{
			super(x, y);
			
			graphic = sprgrass;
			type = "foreGround";
		}
		
	}

}