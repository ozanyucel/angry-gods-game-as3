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
		private var _tilemap:TileMapExt;
		private var _grid:Grid;
		private var _blockGraphics:Array;
		
		public function GameWorld()
		{
			FP.screen.color = 0x8EDFFA;
			
			_blockGraphics = new Array();
			_blockGraphics.push(new TileMapGraphic("block_1", 0, 0, 1, 1));
			_blockGraphics.push(new TileMapGraphic("block_2", 1, 0, 1, 1));
			_blockGraphics.push(new TileMapGraphic("car_1", 2, 0, 2, 1));
			
			add(new Player(FP.screen.width / 2, FP.screen.height - Assets.GFX_BLOCK_H));
			
			// Create _tilemap
			_tilemap = new TileMapExt(Assets.GFX_BLOCK, FP.screen.width, FP.screen.height, Assets.GFX_BLOCK_W, Assets.GFX_BLOCK_H);
			// Create _grid mask
			_grid = new Grid(_tilemap.width, _tilemap.height, _tilemap.tileWidth, _tilemap.tileHeight);
			
			// Fill the _tilemap and _grid programatically
			var i:int;
			for (i = 0; i < _tilemap.columns; i++)
				addGround(i, _tilemap.rows - 1, _blockGraphics[1]);
			
			// Create a new entity to use as a _tilemap
			var entity:Entity = new Entity();
			entity.graphic = _tilemap;
			entity.mask = _grid;
			entity.type = "solid";
			add(entity);
		}
		
		public function addBlockToGround(block:Block):void 
		{
			var tileX:int = block.x / Assets.GFX_BLOCK_W;
			var tileY:int = block.y / Assets.GFX_BLOCK_H;
			
			var blockInfo:TileMapGraphic = getBlockInfo(block.name);
			if (blockInfo) {
				addGround(tileX, tileY, blockInfo);
			}
	
			remove(block);
		}
		
		private function addGround(tileX:int, tileY:int, blockInfo:TileMapGraphic):void 
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
		
		//private function addGround(column:uint, row:uint):void 
		//{
			//_tilemap.setTile(column, row, 1);
			//_grid.setTile(column, row, true);			
		//}
		
		override public function update():void
		{
			if(FP.random < GC.BLOCK_SPAWN_CHANCE)
			{
				var blockInfo:TileMapGraphic = _blockGraphics[FP.rand(_blockGraphics.length)];
				var blockBitmap:BitmapData = _tilemap.getBitmap(blockInfo.x, blockInfo.y, blockInfo.width, blockInfo.height);
				
				add(new Block(blockInfo.name, blockBitmap));
			}
			
			super.update();
		}		
		
		private function getBlockInfo(name:String):TileMapGraphic 
		{
			for (var i:int = 0; i < _blockGraphics.length; i++) 
			{
				var blockInfo:TileMapGraphic = _blockGraphics[i];
				if (blockInfo.name == name)
					return blockInfo;
			}
			
			return null;
		}
	}

}