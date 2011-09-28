package  
{
	import com.matttuttle.GameWorld;
	import com.matttuttle.PhysicsEntity;
	import flash.display.BitmapData;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	$(CBI)* ...
	$(CBI)* @author ozan
	$(CBI)*/
	public class Block extends PhysicsEntity
	{
		private var _name:String;
		
		public function Block(name:String, bitmap:BitmapData) 
		{	
			_name = name;
			
			width = bitmap.width;
			height = bitmap.height;
			originX = 0;
			originY = 0;
			
			x = FP.rand(FP.screen.width / width) * width;
			y = 0;			
				
			graphic = new Image(bitmap);
			
			// Set physics properties
			gravity.y = 2.6;
			maxVelocity.y =  gravity.y * 4;
			
			type = "block";
		}
	
		override public function update():void
		{
			super.update();
			
			if (onGround)
				GameWorld(this.world).addBlockToGround(this);
				
		}
		
		public function get name():String 
		{
			return _name;
		}
	}
}