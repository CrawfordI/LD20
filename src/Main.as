package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Pseudokai
	 */
	public class Main extends Engine 
	{
		
		public function Main():void 
		{	
			//maybe?
			super(640, 480, 60, false);
			FP.world = new MainMenu();
			//FP.console.enable();
		}
		
		override public function init():void {
			super.init();
		}
	}
	
}