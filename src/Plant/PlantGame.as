package Plant
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Matthew Dalrymple
	 */
	public class PlantGame extends World
	{
		
		private const STATE_INTRO:int = 0;
		private const STATE_SEED:int  = 1
		private const STATE_START:int = 2;
		private const STATE_PLAY:int  = 3;
		private const STATE_OVER:int  = 4;
		
		private var state:int = STATE_INTRO;
		
		private var Background:Spritemap;
		private var Sun:SunEntity;
		private var ThePlant:PlantEntity;
		private var Beam:SunBeamEntity = null;
		private var Clouds:Array;
		private var WaterDrops:Array;
		private var IntroMessage:Image;
		private var IntroEntity:Entity;
		private var SeedImage:Image;
		private var SeedEntity:Entity;
		private var GameOverImage:Image = null;
		private var GameOverEntity:Entity = null;
		
		
		private var ScoreText:Text;
		private var HealthText:Text;
		
		private var ScoreTextEntity:Entity;
		private var HealthTextEntity:Entity;
		
		private var Cloudiness:Number = 0;
		private var deltaCloudiness:Number = 10;
		private const MAX_CLOUDINESS:int = 10000;
		
		[Embed(source = '../../gfx/Plant/plant_bg.png')]
		private const BACKGROUND:Class;
		
		[Embed(source = '../../gfx/Plant/plant_intro.png')]
		private const INTRO_SPLASH:Class;
		
		[Embed(source = '../../gfx/Plant/plant_seed.png')]
		private const SEED:Class;
		
		[Embed(source = '../../gfx/Plant/plant_gameover.png')]
		private const GAMEOVER:Class;
		
		[Embed(source = '../../sfx/plant/plant_zap.mp3')]
		private const SFX_ZAP:Class;
		
		[Embed(source = '../../sfx/plant/plant_sunspent.mp3')]
		private const SFX_SUNSPENT:Class;
		
		[Embed(source = '../../bgm/plant_bgm.mp3')]
		private const BGM:Class;
		
		
		private var sfxZap:Sfx;
		private var sfxSunSpent:Sfx;
		private var sfxBGM:Sfx;
		
		private var SeedDropping:Boolean = false;
		
		private var Score:Number = 0;
		private var Count:Number = 0;
		
		private var EndGame:Boolean = false;
		
		private var PreviousWorld:World;
		
		public function PlantGame( prevWorld:World ) 
		{	
			PreviousWorld = prevWorld;
			Background = new Spritemap(BACKGROUND, 640, 480);
			Sun = new SunEntity();
			Clouds = new Array();
			WaterDrops = new Array();
			IntroMessage = new Image(INTRO_SPLASH);
			SeedImage = new Image(SEED);
			GameOverImage = new Image(GAMEOVER);
			sfxZap = new Sfx(SFX_ZAP);
			sfxSunSpent = new Sfx(SFX_SUNSPENT);
			sfxBGM = new Sfx(BGM);
			sfxBGM.loop();
			
			Background.add("default", [0, 1, 2, 1], 8, true);

			addGraphic(Background);
			IntroEntity = addGraphic(IntroMessage);
			
			Cloudiness = 150;

		}
		
		private function init( plantX:Number, plantY:Number ):void {
			
			ThePlant = new PlantEntity( plantX, plantY );
			
			add(Sun);
			add(ThePlant);
			
			Background.play("default");
			
			attemptToAddCloud( FP.rand( 100 ), FP.rand(175) + 50 );
			attemptToAddCloud( FP.rand( 100 ), FP.rand(175) + 50 );
			attemptToAddCloud( FP.rand( FP.width ), FP.rand(150) + 50 );
			attemptToAddCloud( FP.rand( FP.width ), FP.rand(175) + 50 );
			attemptToAddCloud( FP.rand( FP.width ), FP.rand(175) + 50 );
			
			ScoreText 	= new Text(" Score:           ", FP.width - 150, 205);
			HealthText	= new Text("Health:           ", FP.width - 150, 215);
			
			ScoreTextEntity = addGraphic(ScoreText);
			HealthTextEntity = addGraphic(HealthText);
			
			this.state = STATE_PLAY;
		}
		
		override public function update():void 
		{
			super.update();
			
			switch(this.state) {
				case STATE_INTRO:
					if ( Input.pressed(Key.ANY) ) {
						state = STATE_SEED;
						FP.world.remove(IntroEntity);
						SeedEntity = addGraphic(SeedImage);
						SeedEntity.setHitbox(SeedImage.width, SeedImage.height);
						SeedEntity.moveTo(250, 210);
					}
					break;
				case STATE_SEED:
						if( !SeedDropping ) {
							SeedEntity.x = Input.mouseX - SeedEntity.width / 2;
							SeedEntity.y = Input.mouseY - SeedEntity.height / 2;
							SeedEntity.clampHorizontal(125, FP.width - 125);
							SeedEntity.clampVertical(200, 250);
							if (Input.mousePressed) {
								SeedDropping = true;
							}
						} else {
							SeedEntity.y += 2;
							if ( SeedEntity.y >= (FP.height - 175) + FP.rand( 25 ) ) {
								state = STATE_START;
							}
						}
					break;
				case STATE_START:
					init(SeedEntity.centerX, SeedEntity.centerY);
					state = STATE_PLAY;
					break;
				case STATE_PLAY:
				
					Count++;
					
					// Sun Beam Logic:
					if ( Sun.wasSelected() ) {
						if ( Beam == null ) {
							Beam = new SunBeamEntity(Sun.centerX, Sun.centerY);
							Beam.setMaxDepth( FP.height - FP.rand( 150 ) );
							add(Beam);
							// Play SFX
							sfxZap.play();
						} else {
							sfxSunSpent.play();
						}
					}

					if ( Beam != null ) {
						var destroy:Boolean = false;
						var plant:PlantEntity;
						if ( (plant = Beam.collide("plant", Beam.x, Beam.y) as PlantEntity) || Beam.collide("cloud", Beam.x, Beam.y) ) {
							if ( plant != null ) {
								//Play Absorb Energy SFX Here?
								plant.addEnergy( FP.rand( 150 ) + 50 );
							}
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
					
					// Update Cloudiness
					Cloudiness += deltaCloudiness;
					if ( Cloudiness > MAX_CLOUDINESS || Cloudiness <= 0 )
						deltaCloudiness = deltaCloudiness * -1;
					
					SeedImage.color = ThePlant.plantColor();
					
					if ( ThePlant.getHealth() <= 0 || ThePlant.plantSize() >= 100 ) {
						EndGame = true;
					}
					
					updateScore();
					updateScoreBoard();
					
					if ( EndGame )
						state = STATE_OVER;
					break;
				case STATE_OVER:
			
					//FP.world.remove(Sun);
					if ( GameOverEntity == null ) {
				
						GameOverEntity = addGraphic(GameOverImage);
						FP.world.remove(ScoreTextEntity);
						FP.world.remove(HealthTextEntity);
				
						if ( ThePlant.getHealth() <= 0 ) {
							Score = 0;
						}
						//Text.font = "Comic Sans MS";
						Text.size = 30;
						var ScoreRounded:uint = Score;
						var FinalScoreText:Text = new Text( "FINAL SCORE:                ", FP.halfWidth, FP.halfHeight );
						FinalScoreText.text = "FINAL SCORE: " + ScoreRounded;
						Text.size = 14;
						var PromptText:Text = new Text("Press any key to return", FP.halfWidth, FP.halfHeight + FinalScoreText.height / 2);
			
						FinalScoreText.centerOO();
						PromptText.centerOO();
		
						addGraphic( FinalScoreText );
						addGraphic( PromptText );
						
					} else if ( Input.pressed(Key.ANY) ) {
						// GO HOME
						sfxBGM.stop();
						FP.world = PreviousWorld;
					}

					break;
			}
			
		}
		
		private function updateScore():void {
			if( !EndGame ) {
				Score += ((((ThePlant.plantSize() / 100) + 1) * 1.3) * ( 1.9 * ThePlant.getHealth())) / 120;
				Count++;
				if ( ThePlant.getHealth() <= 0 ) {
					Score = 0;
				}
			} else {
				// Calculate Final Plant Score AND TIME BONUS
				Score += (((ThePlant.plantSize() / 100) + 1) * ThePlant.getHealth()) / 120;
				Score += (75000 - Count) * 1.8;
				//trace(" COUNT WAS: " + Count );
				if ( Score < 0 )
					Score = 0;
			}
			if ( Score > 999999999 )
				Score = 999999999;
		}
		
		private function updateScoreBoard():void {
			var IntScore:uint = Score;
			ScoreText.text	= " Score: " + IntScore;
			if( ThePlant.getHealth() >= 100 )
				HealthText.text	= "Health: " + ThePlant.getHealth() + "%";
			else if( ThePlant.getHealth() < 10 )
				HealthText.text	= "Health:   " + ThePlant.getHealth() + "%";
			else
				HealthText.text	= "Health:  " + ThePlant.getHealth() + "%";
		}
		
		
		private function cleanUpClouds( destroyAll:Boolean = false ):void {
			
			var removedOne:Boolean = false;
			// Destroy any clouds off screen
			for ( var i:int = 0; i < Clouds.length; i++ ) {
				if ( Clouds[i] != null && (Clouds[i].isOffScreen() || destroyAll) ) {
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
			var chance:int =  15000 - Cloudiness
			if ( FP.rand( chance ) <= 25 )
				addCloud( start_x, start_y );
		}
	}

	
}

