package graphics 
{
	/**
	$(CBI)* ...
	$(CBI)* @author Ozan Yücel
	$(CBI)*/
	public class TileMapGraphic 
	{
		private var _name:String;
		private var _x:int;
		private var _y:int;
		private var _width:int;
		private var _height:int;
		
		public function TileMapGraphic(name:String, x:int, y:int, width:int, height:int) 
		{
			_name 	= name;
			_x 		= x;
			_y 		= y;
			_width 	= width;
			_height = height;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get x():int 
		{
			return _x;
		}
		
		public function get y():int 
		{
			return _y;
		}
		
		public function get width():int 
		{
			return _width;
		}
		
		public function get height():int 
		{
			return _height;
		}
		
	}

}