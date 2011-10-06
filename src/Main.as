package 
{
	import graphics.AssetManager;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import worlds.GameWorld;
	import worlds.TitleWorld;
	
	[SWF(width='320', height='640', frameRate='30')]
	public class Main extends Engine
	{		
		public function Main():void
		{
			super(160, 320, 30, true);
			
			var assetManager:AssetManager = new AssetManager();
			
			FP.screen.scale = 2;
			FP.screen.color = 0x8EDFFA;
			
			Input.define("start", Key.X);
			Input.define("die", Key.D);
		}
		
		override public function init():void {
			FP.world = new TitleWorld();
		}
	}	
}