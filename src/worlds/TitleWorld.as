package worlds
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	
	public class TitleWorld extends World
	{
		private var _hasPlayedTitle:Boolean;
		
		protected var _title:Entity;
		protected var _infoText:Text;
		
		public function TitleWorld()
		{
			_hasPlayedTitle = false;
			super();
		}
		
		override public function begin():void
		{
			_title = addGraphic(new Image(Resources.GFX_TITLE));	
			
			_infoText = new Text("click to play");
			_infoText.x = FP.screen.width / 2 - _infoText.width / 2;
			_infoText.y = FP.screen.height - 40;
			_infoText.color = 0;
			_infoText.alpha = 0;
			addGraphic(_infoText, -1);
			var textTween:VarTween = new VarTween(onTextFade);
			textTween.tween(_infoText, "alpha", 1, 0.5, Ease.quadIn);
			addTween(textTween, true);
		}
		
		protected function onTextFade():void
		{
			_hasPlayedTitle = true;
		}
		
		override public function update():void
		{
			if (Input.check("start") && _hasPlayedTitle) {
				FP.world = new GameWorld();
			}
		}
	}
}