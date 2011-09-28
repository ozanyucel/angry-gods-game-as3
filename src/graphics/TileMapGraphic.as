package graphics 
{
	import flash.geom.Rectangle;
	/**
	$(CBI)* ...
	$(CBI)* @author Ozan Yücel
	$(CBI)*/
	public class TileMapGraphic 
	{
		private var _source:*;
		private var _name:String;
		private var _rect:Rectangle;
		
		public function TileMapGraphic(source:*, name:String, x:int, y:int, width:int, height:int) 
		{
			_source = source;
			_name 	= name;
			_rect 	= new Rectangle(x, y, width, height);
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get x():int 
		{
			return _rect.x;
		}
		
		public function get y():int 
		{
			return _rect.y;
		}
		
		public function get width():int 
		{
			return _rect.width;
		}
		
		public function get height():int 
		{
			return _rect.height;
		}
		
		public function get source():* 
		{
			return _source;
		}	
	}
}