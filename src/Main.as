package 
{
	import com.matttuttle.GameWorld;
	import graphics.AssetManager;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	[SWF(width='448', height='768', frameRate='30')]
	public class Main extends Engine
	{		
		public function Main():void
		{
			super(224, 384, 30, true);
			
			var assetManager:AssetManager = new AssetManager();
			
			FP.screen.scale = 2;
			FP.world = new GameWorld();
		}
		
		override public function init():void {
			trace("FlashPunk has started successfully!");
		}
	}	
}