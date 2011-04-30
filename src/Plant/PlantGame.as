package Plant
{
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author Matthew Dalrymple
	 */
	public class PlantGame extends World
	{
		
		private var Background:Spritemap;
		private var Sun:SunEntity;
		private var ThePlant:PlantEntity;
		private var Beam:SunBeamEntity = null;
		private var Clouds:Array;
		private var WaterDrops:Array;
		
		
		private var Cloudiness:Number;
		private var deltaCloudiness:Number;
		
		[Embed(source = '../../gfx/Plant/plant_bg.png')]
		private const BACKGROUND:Class;

		
		
		public function PlantGame() 
		{	
			//Background = new Image(BACKGROUND);
			Background = new Spritemap(BACKGROUND, 640, 480)
			Sun = new SunEntity();
			Clouds = new Array();
			WaterDrops = new Array();
			ThePlant = new PlantEntity();
			
			Background.add("default", [0, 1, 2, 1], 8, true);
			Background.play("default");
			
			var gameTitle:Text;
			Text.size = 20;
			gameTitle = new Text("PLANT GAME!!!!!!", 640/2, 480/2);

			addGraphic(Background);
			addGraphic(gameTitle);
			add(Sun);
			add(ThePlant);
			
			//Cloudiness = 150;
			Cloudiness = 500;
			
			attemptToAddCloud( FP.rand( 100 ), FP.rand(175) + 50 );
			attemptToAddCloud( FP.rand( 100 ), FP.rand(175) + 50 );
			attemptToAddCloud( FP.rand( FP.width ), FP.rand(150) + 50 );
			attemptToAddCloud( FP.rand( FP.width ), FP.rand(175) + 50 );
			attemptToAddCloud( FP.rand( FP.width ), FP.rand(175) + 50 );

		}
		
		
		
		override public function update():void 
		{
			super.update();
			
			// Sun Beam Logic:
			if ( Sun.wasSelected() ) {
				if ( Beam == null ) {
					Beam = new SunBeamEntity(Sun.centerX, Sun.centerY);
					Beam.setMaxDepth( FP.height - FP.rand( 150 ) );
					add(Beam);
				}
			}
			
			if ( Beam != null ) {
				var destroy:Boolean = false;
				
				if ( Beam.collide("plant", Beam.x, Beam.y) || Beam.collide("cloud", Beam.x, Beam.y) ) {
					destroy = true;
				} else if ( Beam.atMaxDepth() ) {
					destroy = true;
				}
				
				if ( destroy ) {
					Beam.destroy();
					Beam = null;
				}
			}
			
			// Water Drop Logic:
			for ( var i:int = 0; i < Clouds.length; i++ ) {
				var cloud:CloudEntity = Clouds[i];
				if ( cloud != null && cloud.wasSelected() && !cloud.alreadyDroppedWater() ) {
					var drop:WaterDropEntity = cloud.dropWater();
					WaterDrops.push(drop);
					add(drop);
				}
			}
			
			cleanUpWaterDrops();
			
			// Cloud Logic:
			cleanUpClouds();
			attemptToAddCloud();
			
		}
		
		
		private function cleanUpClouds():void {
			
			var removedOne:Boolean = false;
			// Destroy any clouds off screen
			for ( var i:int = 0; i < Clouds.length; i++ ) {
				if ( Clouds[i] != null && Clouds[i].isOffScreen() ) {
					Clouds[i].destroy();
					delete Clouds[i];
					Clouds[i] = null;
					removedOne = true;
				}
			}
			
			// Remove any spent clouds
			if ( removedOne ) {
				var s:int = Clouds.length;
				for ( var j:int = 0; j < s; j++ ) {
					var cloud:CloudEntity = Clouds.shift();
					if ( cloud != null )
						Clouds.push( cloud );
				}
			}
			
		}
		
		
		
		private function cleanUpWaterDrops():void {
			var removedOne:Boolean = false;
			// Destroy any clouds off screen
			for ( var i:int = 0; i < WaterDrops.length; i++ ) {
				if ( WaterDrops[i] != null && WaterDrops[i].doneSplashing() ) {
					WaterDrops[i].destroy();
					delete WaterDrops[i];
					WaterDrops[i] = null;
					removedOne = true;
				}
			}
			
			// Remove any spent water drops
			if ( removedOne ) {
				var s:int = WaterDrops.length;
				for ( var j:int = 0; j < s; j++ ) {
					var drop:WaterDropEntity = WaterDrops.shift();
					if ( drop != null )
						WaterDrops.push( drop );
				}
			}
		}
		
		
		
		private function addCloud( start_x:int = 0, start_y:int = 0 ):void {
			var C:CloudEntity;
			if( start_x > 0 || start_y > 0 ) {
				C = new CloudEntity( start_x, start_y );
			} else {
				C = new CloudEntity();
			}
			Clouds.push( C );
			add(C);
		}
		
		
		
		private function attemptToAddCloud( start_x:int = 0, start_y:int = 0 ):void {
			var chance:int = 1500 - Cloudiness
			if ( FP.rand( chance ) == 0 )
				addCloud( start_x, start_y );
		}
	}

	
}

