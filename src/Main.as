package 
{
	import graphics.AssetManager;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import worlds.GameWorld;
	import worlds.TitleWorld;
	
	[SWF(width='448', height='768', frameRate='30')]
	public class Main extends Engine
	{		
		public function Main():void
		{
			super(224, 384, 30, true);
			
			var assetManager:AssetManager = new AssetManager();
			
			FP.screen.scale = 2;
			FP.screen.color = 0x8EDFFA;
			
			Input.define("start", Key.X, Key.D);
		}
		
		override public function init():void {
			FP.world = new TitleWorld();
		}
	}	
}