package graphics 
{
	import flash.utils.ByteArray;
	import net.flashpunk.FP;
	/**
	$(CBI)* ...
	$(CBI)* @author Ozan Yücel
	$(CBI)*/
	public class AssetManager 
	{
		private static var _tileGraphics:Array = new Array();
		
		public function AssetManager() 
		{
			loadXML(Assets.XML_ASSET_TILES);
		}
		
		private function loadXML(xml:Class):void 
		{
			var rawData:ByteArray = new xml;
			var dataString:String = rawData.readUTFBytes(rawData.length);
			var xmlData:XML = new XML(dataString);
			
			var dataList:XMLList;
			var dataElement:XML;
			
			dataList = xmlData.tileGraphics.graphic;
			
			for each (dataElement in dataList) {
				_tileGraphics.push(new TileMapGraphic(Assets.GFX_BLOCK, dataElement.@name,
						dataElement.@x, dataElement.@y, dataElement.@width, dataElement.@height));
			}
		}
		
		static public function getGraphicInfo(name:String):TileMapGraphic 
		{
			for (var i:int = 0; i < _tileGraphics.length; i++) 
			{
				var tileInfo:TileMapGraphic = _tileGraphics[i];
				if (tileInfo.name == name)
					return tileInfo;
			}
			
			return null;
		}
		
		static public function getRandomGraphic():TileMapGraphic 
		{
			return _tileGraphics[FP.rand(_tileGraphics.length)];
		}
		
		static public function get tileGraphics():Array 
		{
			return _tileGraphics;
		}
	}
}