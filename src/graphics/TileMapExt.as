package graphics 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	
	/**
	$(CBI)* ...
	$(CBI)* @author Ozan Yücel
	$(CBI)*/
	public class TileMapExt extends Tilemap 
	{
		private var _tileset:BitmapData;
		
		public function TileMapExt(tileset:*, width:uint, height:uint, tileWidth:uint, tileHeight:uint) 
		{
			super(tileset, width, height, tileWidth, tileHeight);
			
			_tileset = FP.getBitmap(tileset);
		}
		
		public function getBitmap(column:int, row:int, width:int, height:int):BitmapData 
		{
			var rect:Rectangle = new Rectangle(column * tileWidth, row * tileHeight, width * tileWidth, height * tileHeight);
			var bitmap:BitmapData = new BitmapData(rect.width, rect.height);		
			bitmap.copyPixels(_tileset, rect, new Point(0, 0), null, null, true);
			
			return bitmap;
		}
	}

}