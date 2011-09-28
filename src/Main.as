package 
{
	import com.matttuttle.GameWorld;
	import graphics.AssetManager;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	[SWF(width='800', height='576', frameRate='30')]
	public class Main extends Engine
	{		
		public function Main():void
		{
			super(800, 576, 30, true);
			
			var assetManager:AssetManager = new AssetManager();
			
			FP.world = new GameWorld();
		}
		
		override public function init():void {
			trace("FlashPunk has started successfully!");
		}
	}	
}