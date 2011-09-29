package com.matttuttle
{
	import flash.display.BitmapData;
	import graphics.*;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	public class GameWorld extends World
	{
		private var _tilemap:Tilemap;
		private var _grid:Grid;

		public function GameWorld()
		{
			FP.screen.color = 0x8EDFFA;

			add(new Player(FP.screen.width / 2, FP.screen.height - Resources.GFX_BLOCK_H));
			
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
			if(FP.random < GC.BLOCK_SPAWN_CHANCE)
			{
				var blockInfo:TileGraphicInfo = AssetManager.getRandomGraphic(Resources.GFX_BLOCKS);
				
				add(new Block(blockInfo));
			}
			
			super.update();
		}		
	}
}