package ext
{
	import ext.FancySliderExt;

	public class ParentApp
	{
		// Prevent garbage collection, since this class is used in child swf, not this swf
		public static function start() : String {
			return "start";
		}
		
		public static function newFancySlider(props:Object) {
			return new FancySliderExt(props);
		}
	}
}
