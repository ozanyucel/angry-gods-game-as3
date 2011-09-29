package  
{
	import com.matttuttle.GameWorld;
	import com.matttuttle.PhysicsEntity;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import graphics.TileGraphicInfo;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	$(CBI)* ...
	$(CBI)* @author ozan
	$(CBI)*/
	public class Block extends PhysicsEntity
	{
		private var _tileGraphic:TileGraphicInfo;
		
		public function Block(tileGraphic:TileGraphicInfo) 
		{	
			_tileGraphic = tileGraphic;
			
			width = tileGraphic.width * Resources.GFX_BLOCK_W;
			height = tileGraphic.height * Resources.GFX_BLOCK_H;
			originX = 0;
			originY = 0;
			
			x = FP.rand(FP.screen.width / width) * width;
			y = 0;			
				
			var kx:int = Resources.GFX_BLOCK_W;
			var ky:int = Resources.GFX_BLOCK_H;
			var rect:Rectangle = new Rectangle(tileGraphic.x * kx, tileGraphic.y * ky, tileGraphic.width * kx, tileGraphic.height * ky);
			graphic = tileGraphic.getImage(rect);
			
			// Set physics properties
			gravity.y = 2.0;
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
			return _tileGraphic.name;
		}
	}
}