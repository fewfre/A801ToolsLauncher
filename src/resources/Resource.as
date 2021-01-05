package resources
{
	import flash.display.Bitmap;

	public class Resource
	{
		// Game Logos
		[Embed (source="images/deadmaze.png" )]
		public static const deadmaze:Class;
		[Embed (source="images/fortoresse.png" )]
		public static const fortoresse:Class;
		[Embed (source="images/transformice.png" )]
		public static const transformice:Class;
		// App icons
		[Embed (source="images/transformice-dressroom.png" )]
		public static const tfmDressroom:Class;
		[Embed (source="images/transformice-shaman-items.png" )]
		public static const tfmShamanItems:Class;
		[Embed (source="images/transformice-skill-tree.png" )]
		public static const tfmSkillTree:Class;
		[Embed (source="images/deadmaze-dressroom.png" )]
		public static const dmDressroom:Class;
		[Embed (source="images/deadmaze-bestiary.png" )]
		public static const dmBestiary:Class;
		[Embed (source="images/fortoresse-dressroom.png" )]
		public static const fortDressroom:Class;
		// Misc
		[Embed (source="images/loader.png" )]
		public static const loader:Class;
	}
}