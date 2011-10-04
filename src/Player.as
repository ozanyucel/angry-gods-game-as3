package  
{
	import com.matttuttle.PhysicsEntity;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	$(CBI)* ...
	$(CBI)* @author ozan
	$(CBI)*/
	public class Player extends PhysicsEntity
	{
		private var _playerSprite:Spritemap = new Spritemap(Resources.GFX_PLAYER, Resources.GFX_PLAYER_W, Resources.GFX_PLAYER_H);
		
		private static const kMoveSpeed:Number = 1.5;
		private static const kJumpForce:Number = 18;
		
		private var _initY:Number = 0;
		private var _dead:Boolean = false;
			
		public var minWorld:Point = new Point(0, 0);
		public var maxWorld:Point = new Point(FP.screen.width, FP.screen.height);
		
		private var _bloodSplash:Emitter;
		
		public function Player(initX:Number=0, initY:Number=0) // floor position
		{	
			width = Resources.GFX_PLAYER_W / 2;
			height = Resources.GFX_PLAYER_H;
			originX = (width - Resources.GFX_PLAYER_W) / 2;
			originY = 0;
			
			x = initX - (width / 2);
			y = initY - height;			
			
			_initY = y;
			
			_playerSprite.add("right_idle", [19, 19, 19, 20], 0.1, true);
			_playerSprite.add("right_walk", [0, 1, 2, 3, 4, 5, 6, 7], 0.25, true);
			_playerSprite.add("right_jump", [21]);
			
			_playerSprite.add("left_idle", [17, 17, 17, 16], 0.1, true);
			_playerSprite.add("left_walk", [15, 14, 13, 12, 11, 10, 9, 8], 0.25, true);
			_playerSprite.add("left_jump", [18]);
			
			_bloodSplash = new Emitter(new BitmapData(1, 1, false, 0xFFFF0000), 1, 1);
			_bloodSplash.newType("blood", [0]);
			_bloodSplash.setAlpha("blood", 1, 0);
			_bloodSplash.setMotion("blood", 0, 25, 20, 180, -5, -5, Ease.quadOut);
			_bloodSplash.relative = false;
				
			graphic = new Graphiclist(_playerSprite, _bloodSplash);
			
			// Set physics properties
			gravity.y = 2.0;
			maxVelocity.y = kJumpForce;
			maxVelocity.x = kMoveSpeed * 2;
			friction.x = 0.7; // floor friction
			friction.y = 0; // wall friction
			
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
				
			if (Input.pressed("jump"))
			{
				trace("heyyy");
			}
			
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
				if (onGround) {
					kill();
				}
				else {
					y = block.y + block.height;
				}
			}
			
			if (!collidable && _bloodSplash.particleCount == 0)
				_dead = true;
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
			
			_playerSprite.play(animation);
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
		
		public function kill():void 
		{
			collidable = false;
			_playerSprite.visible = false;
			
			createBloodSplash();
		}
		
		private function createBloodSplash():void 
		{
			for (var i:int = 0; i < 100; i++) 
			{
				_bloodSplash.emit("blood", x + halfWidth, y + halfHeight);
			}
		}
		
		public function get dead():Boolean 
		{
			return _dead;
		}
	}
}