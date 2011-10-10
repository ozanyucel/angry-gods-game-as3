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
		private var _playerSprite:Spritemap = new Spritemap(Resources.GFX_PLAYER, Resources.GFX_TILE_W, Resources.GFX_TILE_H);
		
		private static const kMoveSpeed:Number = 1.5;
		private static const kJumpForce:Number = 15;
		
		private var _initY:Number = 0;
		private var _dead:Boolean = false;
			
		public var minWorld:Point = new Point(0, 0);
		public var maxWorld:Point = new Point(FP.screen.width, FP.screen.height);
		
		private var _bloodSplash:Emitter;
		
		static public const JUMP_COUNT:int = 1;
		private var _jumpCount:int = JUMP_COUNT;
		
		public function Player(initX:Number=0, initY:Number=0) // floor position
		{	
			width = Resources.GFX_PLAYER_W;
			height = Resources.GFX_PLAYER_H;
			originX = (Resources.GFX_PLAYER_W - Resources.GFX_TILE_W) / 2;
			originY = 0;
			
			x = initX - (width / 2);
			y = initY - height;			
			
			_initY = y;
			
			_playerSprite.add("right_idle", [0]);
			_playerSprite.add("right_walk", [2, 3], 0.25, true);
			_playerSprite.add("right_jump", [1]);
			
			_bloodSplash = new Emitter(new BitmapData(1, 1), 1, 1);
			_bloodSplash.newType("blood", [0]);
			_bloodSplash.setAlpha("blood", 1, 0);
			_bloodSplash.setColor("blood", 0xFFFF0000, 0xFFFF0000);
			_bloodSplash.setMotion("blood", 45, 5, 5, -270, 25, 20, Ease.circOut);
			
			_bloodSplash.newType("bones", [0]);
			_bloodSplash.setAlpha("bones", 1, 0.5);
			_bloodSplash.setColor("bones", 0xFFFFFFFF, 0xFFFFFFFF);
			_bloodSplash.setMotion("bones", 0, 2, 10, 360, 15, 25, Ease.quadOut);
			
			_bloodSplash.newType("guts", [0]);
			_bloodSplash.setAlpha("guts", 1, 0.5);
			_bloodSplash.setColor("guts", 0xFF8A0808, 0xFF8A0808);
			_bloodSplash.setMotion("guts", 0, 2, 10, 360, 15, 25, Ease.quadOut);
			
			_bloodSplash.relative = false;
				
			graphic = new Graphiclist(_playerSprite, _bloodSplash);
			
			// Set physics properties
			gravity.y = 2.0;
			maxVelocity.y = kJumpForce;
			maxVelocity.x = kMoveSpeed * 2;
			friction.x = 1; // floor friction
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
			
			if (Input.pressed("jump") && _jumpCount > 0)
			{
				acceleration.y += -FP.sign(gravity.y) * kJumpForce;
				acceleration.x += -FP.sign(gravity.x) * kJumpForce;
				_jumpCount--;
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
				//animation = "left_";
				_playerSprite.flipped = true;
			else
				//animation = "right_";
				_playerSprite.flipped = false;
			
			if (onGround)
			{
				if (velocity.x == 0)
					animation = "right_idle";
				else
					animation = "right_walk";
			}
			else
			{
				animation = "right_jump";
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
			if (!collidable)
				return;
			
			collidable = false;
			_playerSprite.visible = false;
			
			createBloodSplash();
		}
		
		private function createBloodSplash():void 
		{
			var i:int = 0;
			
			for (i = 0; i < 100; i++) 
				_bloodSplash.emit("blood", x + halfWidth, y + height);
			
			for (i = 0; i < 10; i++) 
				_bloodSplash.emit("bones", x + halfWidth, y + height);
			
			for (i = 0; i < 5; i++) 
				_bloodSplash.emit("guts", x + halfWidth, y + height);
		}
		
		override protected function onHitGround():void 
		{
			_jumpCount = JUMP_COUNT;
		}
		
		public function get dead():Boolean 
		{
			return _dead;
		}
	}
}