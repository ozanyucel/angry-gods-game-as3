package  
{
	import com.matttuttle.PhysicsEntity;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	$(CBI)* ...
	$(CBI)* @author ozan
	$(CBI)*/
	public class Player extends PhysicsEntity
	{
		private var playerSprite:Spritemap = new Spritemap(Assets.GFX_PLAYER, Assets.GFX_PLAYER_W, Assets.GFX_PLAYER_H);
		
		private static const kMoveSpeed:uint = 2;
		private static const kJumpForce:uint = 20;
		
		private var _initY:Number = 0;
			
		public var minWorld:Point = new Point(0, 0);
		public var maxWorld:Point = new Point(FP.screen.width, FP.screen.height);
		
		public function Player(initX:Number=0, initY:Number=0) 
		{	
			width = 16;
			height = 32;
			originX = (width - Assets.GFX_PLAYER_W) / 2;
			originY = 0;
			
			x = initX - (width / 2);
			y = initY - height;			
			
			_initY = y;
			
			playerSprite.add("right_idle", [19, 19, 19, 20], 0.1, true);
			playerSprite.add("right_walk", [0, 1, 2, 3, 4, 5, 6, 7], 0.25, true);
			playerSprite.add("right_jump", [21]);
			
			playerSprite.add("left_idle", [17, 17, 17, 16], 0.1, true);
			playerSprite.add("left_walk", [15, 14, 13, 12, 11, 10, 9, 8], 0.25, true);
			playerSprite.add("left_jump", [18]);
				
			graphic = playerSprite; 			//new Image(new BitmapData(PLAYER_WIDTH, PLAYER_HEIGHT, false, 0xff0000));
			
			// Set physics properties
			gravity.y = 2.6;
			maxVelocity.y = kJumpForce;
			maxVelocity.x = kMoveSpeed * 2;
			friction.x = 0.7; // floor friction
			friction.y = 2.0; // wall friction
			
			// Define input keys
			Input.define("left", Key.A, Key.LEFT);
			Input.define("right", Key.D, Key.RIGHT);
			Input.define("jump", Key.W, Key.SPACE, Key.UP);
		}
	
		override public function update():void
		{
			acceleration.x = acceleration.y = 0;
			
			if (Input.check("left"))
				acceleration.x = -kMoveSpeed;
			
			if (Input.check("right"))
				acceleration.x = kMoveSpeed;
			
			if (Input.pressed("jump") && onGround)
			{
				acceleration.y = -FP.sign(gravity.y) * kJumpForce;
				acceleration.x = -FP.sign(gravity.x) * kJumpForce;
			}
			
			// Make animation changes here
			setAnimation();
			
			super.update();
			
			// Always face the direction we were last heading
			if (velocity.x < 0)
				facing = LEFT;
			else if (velocity.x > 0)
				facing = RIGHT;
				
			var block:Entity = this.collide(GC.TYPE_BLOCK, x, y);
			if (block)
			{
				trace("DEAD!: " + y + ", initY: " + _initY);
				
				if (onGround)
					this.world.remove(this);
				else
					y = block.y + block.height;
			}
		}
		
		private function setAnimation():void
		{
			var animation:String;
			
			if (facing == LEFT)
				animation = "left_";
			else
				animation = "right_";
			
			if (onGround)
			{
				if (velocity.x == 0)
					animation += "idle";
				else
					animation += "walk";
			}
			else
			{
				animation += "jump";
			}
			
			playerSprite.play(animation);
		}
		
		override protected function canMoveTo(x:Number, y:Number):Boolean 
		{
			if (x - originX < minWorld.x || y - originY < minWorld.y 
					|| x - originX + width > maxWorld.x || y - originY + height > maxWorld.y)
				return false;
				
			//if (collide("block", x, y))
				//return false;
			
			return super.canMoveTo(x, y);
		}	
	}
}