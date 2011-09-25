package com.matttuttle
{
	
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
			
			add(new Player(FP.screen.width / 2, FP.screen.height - Assets.GFX_BLOCK_H));
			
			// Create _tilemap
			_tilemap = new Tilemap(Assets.GFX_BLOCK, FP.screen.width, FP.screen.height, Assets.GFX_BLOCK_W, Assets.GFX_BLOCK_H);
			// Create _grid mask
			_grid = new Grid(_tilemap.width, _tilemap.height, _tilemap.tileWidth, _tilemap.tileHeight);
			
			// Fill the _tilemap and _grid programatically
			var i:int;
			for (i = 0; i < _tilemap.columns; i++)
			{
				// top wall
				//_tilemap.setTile(i, 0, 1);
				//_grid.setTile(i, 0, true);
				// bottom wall
				addGround(i, _tilemap.rows - 1);
			}
			/*for (i = 0; i < _tilemap.rows; i++)
			{
				// left wall
				_tilemap.setTile(0, i, 1);
				_grid.setTile(0, i, true);
				// right wall
				_tilemap.setTile(_tilemap.columns - 1, i, 1);
				_grid.setTile(_tilemap.columns - 1, i, true);
			}*/
			
			// Create a new entity to use as a _tilemap
			var entity:Entity = new Entity();
			entity.graphic = _tilemap;
			entity.mask = _grid;
			entity.type = "solid";
			add(entity);
		}
		
		private function addGround(column:uint, row:uint):void 
		{
			_tilemap.setTile(column, row, 1);
			_grid.setTile(column, row, true);			
		}
		
		public function addBlockToGround(block:Block):void 
		{
			var tileX:int = block.x / block.width;
			var tileY:int = block.y / block.height;

			addGround(tileX, tileY);
			
			remove(block);
		}
		
		override public function update():void
		{
			if(FP.random < GC.BLOCK_SPAWN_CHANCE)
			{
				add(new Block());
			}
			
			super.update();
		}		
	}

}