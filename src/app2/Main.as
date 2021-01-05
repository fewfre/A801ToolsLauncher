package app2
{
	import app2.data.*;
	import app2.ui.LoaderDisplay;
	
	import com.fewfre2.utils.*;

	import flash.display.*;
	import flash.events.*;
	import flash.system.Capabilities;
	import app2.data.ConstantsApp;
	
	import flash.system.LoaderContext;
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.*;
	import fl.controls.Slider;
	
	import app2.ui.buttons.*;
	import app2.ui.*;
	import com.fewfre2.display.*;
	import ext.ParentApp;
	
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import resources.Resource;

	[SWF(backgroundColor="0x6A7495" , width="900" , height="425")]
	public class Main extends MovieClip
	{
		// Storage
		private var _loaderDisplay	: LoaderDisplay;
		private var _config			: Object;
		private var _defaultLang	: String;
		private var _swfUrlBase		: String;
		
		// Constructor
		public function Main() {
			super();
			ParentApp.start();
			if (stage) {
				this._start();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, this._start);
			}
		}
		
		private function _start(...args:*) {
			_swfUrlBase = this.loaderInfo.parameters.swfUrlBase || "";
			
			Fewf.init(stage);
			
			stage.align = StageAlign.TOP;
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.frameRate = 16;

			// _loaderDisplay = addChild( new LoaderDisplay({ x:stage.stageWidth * 0.5, y:stage.stageHeight * 0.5 }) ) as LoaderDisplay;
			
			// _startPreload();
			
			_addToolsTray();
		}
		
		// private function _startPreload() : void {
		// 	_load([
		// 		_swfUrlBase+"resources/config.json",
		// 	], String( new Date().getTime() ), _onPreloadComplete);
		// }
		
		// private function _onPreloadComplete() : void {
		// 	_config = Fewf.assets.getData("config");
		// 	_defaultLang = _getDefaultLang(_config.languages["default"]);
			
		// 	_startLoad();
		// }
		
		// private function _startLoad() : void {
		// 	var now:Date = new Date();
		// 	var cb = [now.getFullYear(), now.getMonth(), now.getDate(), now.getHours(), now.getMinutes(), now.getSeconds()].join("-");
		// 	var tPacks = [
		// 		_swfUrlBase+"resources/i18n/"+_defaultLang+".json",
		// 		// [_swfUrlBase+"resources/interface.swf", { useCurrentDomain:true }],
		// 		// _swfUrlBase+"resources/flags.swf",
		// 	];
			
		// 	_load(tPacks, cb, _onLoadComplete);
		// }
		
		// private function _onLoadComplete() : void {
		// 	Fewf.i18n.parseFile(_defaultLang, Fewf.assets.getData(_defaultLang));
			
		// 	_loaderDisplay.destroy();
		// 	removeChild( _loaderDisplay );
		// 	_loaderDisplay = null;
			
		// 	// _world = addChild(new World(stage)) as World;
		// 	// loadSwfApplication();
		// 	_addToolsTray();
		// }
		
		/***************************
		* Setup Selections
		****************************/
		private var _toolsTray : MovieClip;
		private function _addToolsTray() : void {
			_toolsTray = addChild(new MovieClip()) as MovieClip;
			_toolsTray.x = stage.stageWidth * 0.5;
			_toolsTray.y = stage.stageHeight * 0.5;
			
			Fewf.i18n.parseFile("en", {
				defaultFont: "Veranda",
				defaultScale: 1,
				strings: {
					"Dressroom": { "text":"Dressroom" },
					"Shaman Items": { "text":"Shaman Items" },
					"Skill Tree Builder": { "text":"Skill Tree Builder" },
					"Bestiary": { "text":"Bestiary" },
					"Tracker": { "text":"Tracker" }
				}
			});
			
			// Transformice
			_addToolSection(0, -90, new Resource.transformice(), [
				_newToolBtn(new Resource.tfmDressroom(), 1, "Dressroom", _onTransformiceDressroomChosen),
				_newToolBtn(new Resource.tfmShamanItems(), 1, "Shaman Items", _onTransformiceShamanItemsChosen),
				_newToolBtn(new Resource.tfmSkillTree(), 1, "Skill Tree Builder", _onTransformiceSkillTreeChosen),
			]);
			
			// Deadmaze
			_addToolSection(-200, 90, new Resource.deadmaze(), [
				// _newToolBtn(new Resource.dmDressroom(), 0.9, "Dressroom", _onDeadMazeDressroomChosen),
				_newToolBtn(new Resource.dmBestiary(), 0.75, "Bestiary", _onDeadMazeBestiaryChosen),
				_newToolBtn(new Resource.dmTracker(), 1, "Tracker", _onDeadMazeTrackerChosen),
			]);
			
			// Fortoresse
			_addToolSection(200, 90, new Resource.fortoresse(), [
				_newToolBtn(new Resource.fortDressroom(), 1, "Dressroom", _onFortoresseDressroomChosen),
			]);
		}
		
		private function _newToolBtn(img:DisplayObject, scale:Number, text:String, pOnClick:Function) : SpriteButton {
			var myObj = new Sprite();
			myObj.addChild(img);
			img.x = -(img.width*scale*0.5+1);
			img.y = -(img.height*scale*0.5+1);
			img.scaleX = img.scaleY = scale;
			
			var btn = new SpriteButton({ obj:myObj, text:text, width:75, height:75, origin:0.5 });
			btn.addEventListener(ButtonBase.CLICK, pOnClick);
			return btn;
		}
		
		private function _addToolSection(x:Number, y:Number, icon:Bitmap, buttons:Array) : Sprite {
			var width = 300, height = 125;
			var tray = _toolsTray.addChild(new RoundedRectangle({ x:x, y:y, width:width, height:height, origin:0.5 })) as RoundedRectangle;
			tray.drawSimpleGradient(ConstantsApp.COLOR_TRAY_GRADIENT, 15, ConstantsApp.COLOR_TRAY_B_1, ConstantsApp.COLOR_TRAY_B_2, ConstantsApp.COLOR_TRAY_B_3);
			// tray.draw(0x6A7495, 15, 0x5d7d90, 0x11171c, 0x3c5064);
			
			var icon = tray.addChild(icon);
			icon.x = -icon.width*0.5;
			icon.y = -height*0.5-icon.height+25;
			
			var spacingX = buttons[0].Width+10;
			var startX = -spacingX*(buttons.length-1)*0.5;
			for(var i:int = 0; i < buttons.length; i++) {
				var btn:SpriteButton = tray.addChild(buttons[i]) as SpriteButton;
				btn.x = startX+i*spacingX;
				btn.y = 12;
			}
			
			return tray;
		}
		
		private function _onTransformiceDressroomChosen(e:*) : void {
			_doToolChoiceClicked("https://projects.fewfre.com/a801/transformice/dressroom/", "dressroom.swf");
		}
		
		private function _onTransformiceShamanItemsChosen(e:*) : void {
			_doToolChoiceClicked("https://projects.fewfre.com/a801/transformice/shaman_items/", "app.swf");
		}
		
		private function _onTransformiceSkillTreeChosen(e:*) : void {
			navigateToURL(new URLRequest("https://projects.fewfre.com/a801/transformice/skill_tree/"), "_blank");
		}
		
		private function _onDeadMazeDressroomChosen(e:*) : void {
			_doToolChoiceClicked("https://projects.fewfre.com/a801/deadmaze/dressroom/", "dressroom.swf");
		}
		
		private function _onDeadMazeBestiaryChosen(e:*) : void {
			_doToolChoiceClicked("https://projects.fewfre.com/a801/deadmaze/bestiary/", "bestiary.swf");
		}
		
		private function _onDeadMazeTrackerChosen(e:*) : void {
			navigateToURL(new URLRequest("https://projects.fewfre.com/a801/deadmaze/tracker/"), "_blank");
		}
		
		private function _onFortoresseDressroomChosen(e:*) : void {
			_doToolChoiceClicked("https://projects.fewfre.com/a801/fortoresse/dressroom/", "dressroom.swf");
		}
		
		private function _doToolChoiceClicked(base:String, swf:String) : void {
			removeChild(_toolsTray);
			_loadTool(base+swf, base);
		}
		
		/***************************
		* Tool Loader
		****************************/
		private var toolSwfUrl:String;
		private var toolSwfUrlBase:String;
		private var toolUrlLoader:URLLoader;
		private var toolLoader:Loader;

		private function _loadTool(swfUrl:String, base:String) : void {
			toolSwfUrl = swfUrl;
			toolSwfUrlBase = base;
			// initialisationPreChargeur();
			_toolStartLoad();
		}

		// protected function initialisationPreChargeur() : void
		// {
		// 	throw new Error("Cette fonction doit être surchargée.");
		// }// end function

		// protected function chargementEnCours(event:ProgressEvent) : void
		// {
		// 	throw new Error("Cette fonction doit être surchargée.");
		// }// end function

		// protected function finChargement(event:Event) : void
		// {
		// 	throw new Error("Cette fonction doit être surchargée.");
		// }// end function

		private function _toolStartLoad() : void {
			toolUrlLoader = new URLLoader();
			toolUrlLoader.dataFormat = "binary";
			toolUrlLoader.addEventListener("complete", _onToolLoadComplete);
			// toolUrlLoader.addEventListener("progress", chargementEnCours);
			toolUrlLoader.load(new URLRequest(toolSwfUrl + "?d=" + new Date().getTime()));
		}

		private function _onToolLoadComplete(event:Event) : void {
			var data:ByteArray = toolUrlLoader.data as ByteArray;
			var ctx:LoaderContext = new LoaderContext();
			ctx.allowCodeImport = true;
			ctx.parameters = { swfUrlBase:toolSwfUrlBase };
			
			// Remove all elements on screen
			while (numChildren) {
				removeChildAt(0);
			}
			
			// Add SWF to stage
			toolLoader = new Loader();
			toolLoader.loadBytes(data, ctx);
			// toolLoader.contentLoaderInfo.addEventListener("complete", finChargement);
			addChild(toolLoader);
		}
		
		
		
		/***************************
		* Helper Methods
		****************************/
		private function _load(pPacks:Array, pCacheBreaker:String, pCallback:Function) : void {
			Fewf.assets.load(pPacks, pCacheBreaker);
			var tFunc = function(event:Event){
				Fewf.assets.removeEventListener(AssetManager.LOADING_FINISHED, tFunc);
				pCallback();
				tFunc = null; pCallback = null;
			};
			Fewf.assets.addEventListener(AssetManager.LOADING_FINISHED, tFunc);
		}
		
		private function _mergeArray(...arrays):Array {
			var result:Array = [];
			for(var i:int=0;i<arrays.length;i++){
				result = result.concat(arrays[i]);
			}
			return result;
		}
		
		private function _getDefaultLang(pConfigLang:String) : String {
			var tFlagDefaultLangExists:Boolean = false;
			// http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/system/Capabilities.html#language
			if(Capabilities.language) {
				var tLanguages:Array = _config.languages.list;
				for(var i:Object in tLanguages) {
					if(Capabilities.language == tLanguages[i].code || Capabilities.language == tLanguages[i].code.split("-")[0]) {
						return tLanguages[i].code;
					}
					if(pConfigLang == tLanguages[i].code) {
						tFlagDefaultLangExists = true;
					}
				}
			}
			return tFlagDefaultLangExists ? pConfigLang : "en";
		}
	}
}