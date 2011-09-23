package  
{	
	public class Assets
	{
		[Embed(source = '../assets/character.png')] 
		public static const GFX_PLAYER:Class;
		static public const GFX_PLAYER_W:int = 32;
		static public const GFX_PLAYER_H:int = 32;
		
		[Embed(source = '../assets/block.png')] 
		public static const GFX_BLOCK:Class;	
		static public const GFX_BLOCK_W:int = 32;
		static public const GFX_BLOCK_H:int = 32;
	}
}