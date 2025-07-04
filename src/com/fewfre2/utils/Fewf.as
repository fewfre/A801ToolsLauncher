package com.fewfre2.utils
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.external.ExternalInterface;
	
	// Global access class
	public class Fewf
	{
		// Storage
		private static var _assets : AssetManager;
		private static var _i18n : I18n;
		private static var _dispatcher : MovieClip;
		private static var _sharedObject : SharedObjectManager;
		private static var _sharedObjectGlobal : SharedObjectManager;
		private static var _stage : Stage;
		private static var _isBrowserLoaded : Boolean;
		
		// Properties
		public static function get assets() : AssetManager { return _assets; }
		public static function get i18n() : I18n { return _i18n; }
		public static function get dispatcher() : MovieClip { return _dispatcher; }
		public static function get sharedObject() : SharedObjectManager { return _sharedObject; }
		public static function get sharedObjectGlobal() : SharedObjectManager { return _sharedObjectGlobal; }
		public static function get stage() : Stage { return _stage; }
		public static function get isBrowserLoaded() : Boolean { return _isBrowserLoaded; }
		
		public static function init(pStage:Stage, uniqID:String) : void {
			_assets = new AssetManager();
			_i18n = new I18n();
			_dispatcher = new MovieClip();
			_sharedObject = new SharedObjectManager(uniqID);
			_sharedObjectGlobal = new SharedObjectManager("fewfre");
			_stage = pStage;
			_isBrowserLoaded = ExternalInterface.available ? ExternalInterface.call("eval", "window.location.href") : false;
		}
	}
}
