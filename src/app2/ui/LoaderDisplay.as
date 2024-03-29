package app2.ui
{
	import com.fewfre2.display.*;
	import com.fewfre2.utils.*;
	import com.fewfre2.events.FewfEvent;
	import app2.data.*;
	import app2.ui.*;
	import flash.display.*;
	import flash.events.*
	import flash.text.*;
	import flash.display.MovieClip;
    import resources.Resource;
	
	public class LoaderDisplay extends RoundedRectangle
	{
		private var _loadingSpinner	: MovieClip;
		private var _leftToLoadText	: TextBase;
		private var _loadProgressText: TextBase;
		
		// Constructor
		// pData = { x:Number, y:Number }
		public function LoaderDisplay(pData:Object)
		{
			pData.width = 500;
			pData.height = 200;
			pData.origin = 0.5;
			super(pData);
			this.drawSimpleGradient(ConstantsApp.COLOR_TRAY_GRADIENT, 15, ConstantsApp.COLOR_TRAY_B_1, ConstantsApp.COLOR_TRAY_B_2, ConstantsApp.COLOR_TRAY_B_3);
			
			Fewf.assets.addEventListener(ProgressEvent.PROGRESS, _onLoadProgress);
			Fewf.assets.addEventListener(AssetManager.PACK_LOADED, _onPackLoaded);
			
			_loadingSpinner = addChild(new MovieClip()) as MovieClip;
			_loadingSpinner.y -= 45;
			
			var img:DisplayObject = _loadingSpinner.addChild(new Resource.loader());
			img.x = -img.width*0.5;
			img.y = -img.height*0.5;
			
			// _loadingSpinner.scaleX = 2;
			// _loadingSpinner.scaleY = 2;
			
			_leftToLoadText = addChild(new TextBase({ text:"loading", values:"", size:18, x:0, y:10 })) as TextBase;
			_loadProgressText = addChild(new TextBase({ text:"loading_progress", values:"", size:18, x:0, y:35 })) as TextBase;
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function destroy():void {
			Fewf.assets.removeEventListener(ProgressEvent.PROGRESS, _onLoadProgress);
			removeEventListener(Event.ENTER_FRAME, update);
			
			_loadingSpinner = null;
		}
		
		public function open() : void {
			
		}
		
		public function update(pEvent:Event):void
		{
			var dt:Number = 0.1;
			if(_loadingSpinner != null) {
				_loadingSpinner.rotation += 360 * dt;
			}
		}
		
		private function _onPackLoaded(e:FewfEvent) : void {
			_leftToLoadText.setText("loading", e.data.itemsLeftToLoad);
			if(e.data.itemsLeftToLoad <= 0) {
				_leftToLoadText.text = "loading_finished";
				_loadProgressText.text = "";
			}
		}
		
		private function _onLoadProgress(e:ProgressEvent) : void {
			//_loadingSpinner.rotation += 10;
			//trace("Loading: "+String(Math.floor(e.bytesLoaded/1024))+" KB of "+String(Math.floor(e.bytesTotal/1024))+" KB.");
			_loadProgressText.setValues(String(Math.floor(e.bytesLoaded/1024))+" KB / "+String(Math.floor(e.bytesTotal/1024))+" KB");
		}
	}
}
