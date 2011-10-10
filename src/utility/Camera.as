package utility 
{
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author dolgion
	 */
	public class Camera
	{	
		private var _cameraSpeed:Number;
		
		private var _rightOffset:Number;
		private var _leftOffset:Number;
		private var _topOffset:Number;
		private var _bottomOffset:Number;
		
		public function Camera(leftOffset:Number, rightOffset:Number, topOffset:Number, bottomOffset:Number, cameraSpeed:Number) 
		{
			_cameraSpeed = cameraSpeed;
			
			_rightOffset = rightOffset;
			_leftOffset = leftOffset;
			_topOffset = topOffset;
			_bottomOffset = bottomOffset;		
		}
		
		public function adjustToPlayer(mapHeight:int, mapWidth:int, player:Player):void
		{
			// Find the coordinates to that would center the player 
			var newCameraX:int = (player.x + player.width/2) - FP.width / 2;
			var newCameraY:int = (player.y + player.height/2) - FP.height / 2;
			
			// Check if they go beyond map boundaries
			if (newCameraX < 0) newCameraX = 0;
			else if (newCameraX + FP.width > mapWidth) newCameraX = mapWidth - FP.width;
			
			if (newCameraY < 0) newCameraY = 0;
			else if (newCameraY + FP.height > mapHeight) newCameraY = mapHeight - FP.height;
			
			// Set the camera coordinates
			FP.camera.x = newCameraX;
			FP.camera.y = newCameraY;
		}
		
		public function followPlayer (mapHeight:Number, mapWidth:Number, player:Player):void
		{
			//trace("START! player: (x=" + player.left + ", y=" + player.top + "), camera: " + FP.camera.toString() + ", height: " + FP.height);
			
			if (player.left - FP.camera.x < _leftOffset) 
			{
				trace("LEFT! player: (x=" + player.left + ", y=" + player.top + "), camera: " + FP.camera.toString());
				//if (FP.camera.x > 0) 
					FP.camera.x -= _cameraSpeed;
			}
			else if ((FP.camera.x + FP.width) -  player.right < _rightOffset)
			{
				trace("RIGHT! player: (x=" + player.left + ", y=" + player.top + "), camera: " + FP.camera.toString());
				//if (FP.camera.x + FP.width < mapWidth) 
					FP.camera.x += _cameraSpeed;
			}
			
			if (player.top - FP.camera.y < _topOffset) 
			{
				trace("UP! player: (x=" + player.left + ", y=" + player.top + "), camera: " + FP.camera.toString());
				//if (FP.camera.y > 0) 
					FP.camera.y -= _cameraSpeed;
			}
			else if ((FP.camera.y + FP.height) - player.bottom < _bottomOffset)
			{
				trace("DOWN! player: (x=" + player.left + ", y=" + player.top + "), camera: " + FP.camera.toString() + ", height: " + FP.height);
				//if (FP.camera.y + FP.height < mapHeight) 
					FP.camera.y += _cameraSpeed;
			}
		}
	}
}