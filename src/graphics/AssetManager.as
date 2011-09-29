package graphics 
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import net.flashpunk.FP;
	/**
	$(CBI)* ...
	$(CBI)* @author Ozan Yücel
	$(CBI)*/
	public class AssetManager 
	{
		private static var _assets:Dictionary = new Dictionary();
		
		
		public function AssetManager() 
		{
			_assets[String(Resources.GFX_BLOCKS)] = getAssetFromXML(Resources.GFX_BLOCKS, Resources.XML_BLOCKS);
		}
		
		private function getAssetFromXML(bitmap:Class, xml:Class):AssetInfo 
		{
			var rawData:ByteArray = new xml;
			var dataString:String = rawData.readUTFBytes(rawData.length);
			var xmlData:XML = new XML(dataString);
			
			var dataList:XMLList;
			var dataElement:XML;
			
			var asset:AssetInfo = new AssetInfo(bitmap, xmlData.width, xmlData.height, xmlData.tileWidth, xmlData.tileHeight);
			
			dataList = xmlData.tileGraphics.graphic;
			
			var tileGraphics:Array = new Array();
			for each (dataElement in dataList) {
				tileGraphics.push(new TileGraphicInfo(Resources.GFX_BLOCKS, dataElement.@name,
						dataElement.@x, dataElement.@y, dataElement.@width, dataElement.@height));
			}
			
			asset.tileGraphics = tileGraphics;
			
			return asset;
		}

		static public function getGraphicInfo(source:Class, name:String):TileGraphicInfo 
		{
			var asset:AssetInfo = _assets[String(source)];
			
			if (asset)
				return asset.getGraphicInfo(name);
			
			return null;
		}	
		
		static public function getRandomGraphic(source:Class):TileGraphicInfo 
		{
			var asset:AssetInfo = _assets[String(source)];
			
			if (asset)
				return asset.getRandomGraphic();
			
			return null;
		}
	}
}