package graphics 
{
	import net.flashpunk.FP;
	/**
	$(CBI)* ...
	$(CBI)* @author ozan
	$(CBI)*/
	public class AssetInfo 
	{
		private var _source:*;
		private var _width:int;
		private var _height:int;
		private var _tileWidth:int;
		private var _tileHeight:int;
		private var _tileGraphics:Array = new Array();
		
		public function AssetInfo(source:*, width:int, height:int, tileWidth:int, tileHeight:int) 
		{		
			_source = source;
			_width = width;
			_height = height;
			_tileWidth = tileWidth;
			_tileHeight = tileHeight;
		}
		
		public function get width():int 
		{
			return _width;
		}
		
		public function get height():int 
		{
			return _height;
		}
		
		public function get source():* 
		{
			return _source;
		}
		
		public function get tileWidth():int 
		{
			return _tileWidth;
		}
		
		public function get tileHeight():int 
		{
			return _tileHeight;
		}
		
		public function set tileGraphics(value:Array):void 
		{
			_tileGraphics = value;
		}
			
		public function getGraphicInfo(name:String):TileGraphicInfo 
		{
			for (var i:int = 0; i < _tileGraphics.length; i++) 
			{
				var tileInfo:TileGraphicInfo = _tileGraphics[i];
				if (tileInfo.name == name)
					return tileInfo;
			}
			
			return null;
		}	
		
		public function getRandomGraphic():TileGraphicInfo 
		{
			return _tileGraphics[FP.rand(_tileGraphics.length)];
		}
	}
}