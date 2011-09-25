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
		public function Block() 
		{	
			width = 32;
			height = 32;
			originX = 0;
			originY = 0;
			
			x = FP.rand(FP.screen.width / width) * width;
			y = 0;			
				
			graphic = new Image(new BitmapData(width, height, false, 0xff0000));
			
			// Set physics properties
			gravity.y = 2.6;
			
			type = "block";
		}
	
		override public function update():void
		{
			super.update();
			
			if (onGround)
				GameWorld(this.world).addBlockToGround(this);
				
		}
	}
}