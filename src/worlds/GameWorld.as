package worlds
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import graphics.*;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import utility.Camera;
	
	public class GameWorld extends World
	{
		static public const SCORE_MULTIPLIER:int = 10;
		
		private var _tilemap:Tilemap;
		private var _grid:Grid;
		private var _player:Player;
		private var _hasPlayedTitle:Boolean = false;
		private var _infoText:Text;
		private var _blockSpawnTime:Number = 0;
		private var _minPlayerY:int;
		private var _scoreText:Text;
		private var _score:int = 0;
		private var _camera:Camera;

		public function GameWorld()
		{	
			startGame();
		}
		
		private function startGame():void 
		{
			_player = new Player(FP.screen.width / 2, FP.screen.height - Resources.GFX_BLOCK_H);
			add(_player);
			
			// Create _tilemap
			_tilemap = new Tilemap(Resources.GFX_BLOCKS, FP.screen.width, FP.screen.height, Resources.GFX_BLOCK_W, Resources.GFX_BLOCK_H);
			// Create _grid mask
			_grid = new Grid(_tilemap.width, _tilemap.height, _tilemap.tileWidth, _tilemap.tileHeight);
			
			// Fill the _tilemap and _grid programatically
			var i:int;
			for (i = 0; i < _tilemap.columns; i++)
				addGround(i, _tilemap.rows - 1, AssetManager.getGraphicInfo(Resources.GFX_BLOCKS, "block_1"));
			
			// Create a new entity to use as a _tilemap
			var entity:Entity = new Entity();
			entity.graphic = _tilemap;
			entity.mask = _grid;
			entity.type = "solid";
			add(entity);					
			
			_hasPlayedTitle = false;
			
			createScoreText();
			
			_minPlayerY = _player.y;
			
			_camera = new Camera(0, 0, 150, 16, 2);
		}
		
		public function addBlockToGround(block:Block):void 
		{
			var tileX:int = block.x / Resources.GFX_BLOCK_W;
			var tileY:int = block.y / Resources.GFX_BLOCK_H;
			
			var blockInfo:TileGraphicInfo = AssetManager.getGraphicInfo(Resources.GFX_BLOCKS, block.name);
			if (blockInfo) {
				addGround(tileX, tileY, blockInfo);
			}
	
			remove(block);
		}
		
		private function addGround(tileX:int, tileY:int, blockInfo:TileGraphicInfo):void 
		{
			for (var i:int = 0; i < blockInfo.width; i++) 
			{
				for (var j:int = 0; j < blockInfo.height; j++) 
				{
					var bitmapIndex:int = _tilemap.getIndex(blockInfo.x + i, blockInfo.y + j);
					
					_tilemap.setTile(i + tileX, j + tileY, bitmapIndex);
					_grid.setTile(i + tileX, j + tileY, true);						
				}
			}
		}
		
		override public function update():void
		{					
			_blockSpawnTime += FP.elapsed;
			if(_blockSpawnTime >= GC.BLOCK_SPAWN_TIME)
			{
				_blockSpawnTime = 0;
				
				var blockInfo:TileGraphicInfo = AssetManager.getRandomGraphic(Resources.GFX_BLOCKS);
				
				add(new Block(blockInfo));
			}
			
			if (_player && _player.dead) {	
				this.remove(_player);
				_player = null;
				createInfoText();
			}
			
			if (_infoText && _hasPlayedTitle) {
				if (Input.check("start")) {
					this.removeAll();
					_infoText = null;
					startGame();
				}		
			}
			else if (_player) {		
				_camera.followPlayer(FP.screen.height * 100, FP.screen.width, _player);
				
				if (Input.check("die")) {
					_player.kill();
				}
				else {
					if (_player.y < _minPlayerY) {
						_score += (_minPlayerY - _player.y) * SCORE_MULTIPLIER;
						_scoreText.text = _score.toString();
						_minPlayerY = _player.y;
					}
				}
			}
			
			super.update();
		}		
		
		private function createInfoText():void 
		{
			_infoText = new Text("click to play again!");
			_infoText.x = FP.screen.width / 2 - _infoText.width / 2;
			_infoText.y = FP.screen.height / 2 - _infoText.width / 2 + 50;
			_infoText.color = 0;
			_infoText.alpha = 0;
			_infoText.scrollX = _infoText.scrollY = 0;
			addGraphic(_infoText, -1);
			var textTween:VarTween = new VarTween(onTextFade);
			textTween.tween(_infoText, "alpha", 1, 0.5, Ease.quadIn);
			addTween(textTween, true);			
		}
		
		private function createScoreText():void 
		{
			_scoreText = new Text("0       ");
			_scoreText.x = 10;
			_scoreText.y = 10;
			_scoreText.color = 0;
			_scoreText.scrollX = _scoreText.scrollY = 0;
			addGraphic(_scoreText, -1);
		}
		
		protected function onTextFade():void
		{
			_hasPlayedTitle = true;
		}
	}
}