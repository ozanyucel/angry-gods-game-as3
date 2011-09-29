package  
{	
	public class Resources
	{
		[Embed(source = '../assets/character.png')] 
		public static const GFX_PLAYER:Class;
		static public const GFX_PLAYER_W:int = 32;
		static public const GFX_PLAYER_H:int = 32;
		
		[Embed(source = '../assets/blocks.png')] 
		public static const GFX_BLOCKS:Class;	
		static public const GFX_BLOCK_W:int = 32;
		static public const GFX_BLOCK_H:int = 32;
		
		[Embed(source = "../assets/blocks.xml", mimeType = "application/octet-stream")]
		static public const XML_BLOCKS:Class;
		
		static public const TILE_CAR_X:int = 2;
		static public const TILE_CAR_Y:int = 0;
		static public const TILE_CAR_W:int = 2;
		static public const TILE_CAR_H:int = 1;
	}
}