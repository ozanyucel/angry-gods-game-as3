package com.matttuttle
{
	import flash.geom.Point;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	
	public class PhysicsEntity extends Entity
	{
		public static const LEFT:uint  = 0;
		public static const RIGHT:uint = 1;
		public static const UP:uint    = 2;
		public static const DOWN:uint  = 3;
		
		// Define variables
		public var velocity:Point      = new Point(0, 0);
		public var acceleration:Point  = new Point(0, 0);
		public var friction:Point      = new Point(0, 0);
		public var maxVelocity:Point   = new Point(0, 0);
		public var gravity:Point       = new Point(0, 0);
		
		public var facing:uint;
		public var solid:String = "solid";
		
		public function PhysicsEntity()
		{
			_onGround = _onWall = false;
			facing = RIGHT;
		}
		
		public function get onGround():Boolean { return _onGround; }
		public function get onWall():Boolean { return _onWall; }
		
		override public function update():void
		{		
			if (!collidable)
				return;
			
			// Apply acceleration and velocity
			velocity.x += acceleration.x;
			velocity.y += acceleration.y;
			applyVelocity();
			applyGravity();
			checkMaxVelocity();
			applyFriction();
			super.update();
		}
		
		public function applyGravity():void
		{
			//increase velocity based on gravity
			velocity.x += gravity.x;
			velocity.y += gravity.y;
		}
		
		private function checkMaxVelocity():void
		{
			if (maxVelocity.x > 0 && Math.abs(velocity.x) > maxVelocity.x)
			{
				velocity.x = maxVelocity.x * FP.sign(velocity.x);
			}
			
			if (maxVelocity.y > 0 && Math.abs(velocity.y) > maxVelocity.y)
			{
				velocity.y = maxVelocity.y * FP.sign(velocity.y);
			}
		}
		
		private function applyFriction():void
		{
			// If we're on the ground, apply friction
			if (onGround && friction.x)
			{
				if (velocity.x > 0)
				{
					velocity.x -= friction.x;
					if (velocity.x < 0)
					{
						velocity.x = 0;
					}
				}
				else if (velocity.x < 0)
				{
					velocity.x += friction.x;
					if (velocity.x > 0)
					{
						velocity.x = 0;
					}
				}
			}
			
			// Apply friction if on a wall
			if (onWall && friction.y)
			{
				if (velocity.y > 0)
				{
					velocity.y -= friction.y;
					if (velocity.y < 0)
					{
						velocity.y = 0;
					}
				}
				else if (velocity.y < 0)
				{
					velocity.y += friction.y;
					if (velocity.y > 0)
					{
						velocity.y = 0;
					}
				}
			}
		}
		
		private function applyVelocity():void
		{
			var i:int;
			
			_onGround = false;
			_onWall = false;
			
			for (i = 0; i < Math.abs(velocity.x); i++)
			{
				if(canMoveTo(x + FP.sign(velocity.x), y))
				{
					x += FP.sign(velocity.x);
				}
				else
				{
					_onWall = true;
					velocity.x = 0;
					break;
				}

			}
			
			for (i = 0; i < Math.abs(velocity.y); i++)
			{
				if (canMoveTo(x, y + FP.sign(velocity.y)))
				{
					y += FP.sign(velocity.y);
				}
				else
				{
					if (FP.sign(velocity.y) == FP.sign(gravity.y)) {
						_onGround = true;
						onHitGround();
					}
					velocity.y = 0;
					break;					
				}
			}
		}
		
		protected function onHitGround():void 
		{
			// override
		}
		
		protected function canMoveTo(x:Number, y:Number):Boolean 
		{
			return !collide(solid, x, y);
		}
		
		private var _onGround:Boolean;
		private var _onWall:Boolean;
		
	}

}