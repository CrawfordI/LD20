package Vase 
{
	
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author ...
	 */
	
	
	public class Portal extends Entity
	{
		 [Embed(source = '../../gfx/vase/portal.png')] public var PORTAL:Class;
	 public var sprportal:Image = new Image(PORTAL);
	
	 
	 public function Portal(xy:Point) 
		{
			super(xy.x,xy.y);
			
			graphic = sprportal;
			type = "portal";
			
			setHitbox(4, 8,-12,-16);
		}
		
	
	}

}