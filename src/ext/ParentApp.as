package ext
{
	import ext.FancySliderExt;
	import app2.Main;

	public class ParentApp
	{
		private static var _main : Main;
		public static var sharedData : Object = {};
		
		// Prevent garbage collection, since this class is used in child swf, not this swf
		public static function start(main:Main) : String {
			_main = main;
			return "start";
		}
		
		public static function newFancySlider(props:Object) {
			return new FancySliderExt(props);
		}
		
		public static function reopenSelectionLauncher() : Function {
			return _main.reopenSelectionLauncher;
		}
	}
}
