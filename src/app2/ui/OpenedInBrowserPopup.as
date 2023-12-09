package app2.ui
{
	import app2.data.*;
	import app2.ui.*;
	import com.fewfre2.display.*;
	import com.fewfre2.events.*;
	import com.fewfre2.utils.*;
	import flash.display.*;
	import flash.events.*;
	
	public class OpenedInBrowserPopup extends MovieClip
	{
		// Constants
		public static const CLOSE : String= "close_browser_popup";
		
		// Storage
		private var _tray : RoundedRectangle;
		
		// Constructor
		// pData = {  }
		public function OpenedInBrowserPopup(pData:Object) {
			this.x = Fewf.stage.stageWidth * 0.5;
			this.y = Fewf.stage.stageHeight * 0.5;
			
			/****************************
			* Click Tray
			*****************************/
			var tClickTray:Sprite = addChild(new Sprite()) as Sprite;
			tClickTray.x = -5000;
			tClickTray.y = -5000;
			tClickTray.graphics.beginFill(0x000000, 0.35);
			tClickTray.graphics.drawRect(0, 0, -tClickTray.x*2, -tClickTray.y*2);
			tClickTray.graphics.endFill();
			tClickTray.addEventListener(MouseEvent.CLICK, _onCloseClicked);
			
			/****************************
			* Background
			*****************************/
			var tWidth:Number = 350, tHeight:Number = 100;
			_tray = addChild(new RoundedRectangle({ x:0, y:0, width:tWidth, height:tHeight, origin:0.5 })) as RoundedRectangle;
			_tray.drawSimpleGradient(ConstantsApp.COLOR_TRAY_GRADIENT, 15, ConstantsApp.COLOR_TRAY_B_1, ConstantsApp.COLOR_TRAY_B_2, ConstantsApp.COLOR_TRAY_B_3);
			
			/****************************
			* Languages
			*****************************/
			_tray.addChild(new TextBase({ text:"OpenedInBrowser", size:18 }));
		}
		
		private function _onCloseClicked(pEvent:Event) : void {
			_close();
		}
		
		private function _close() : void {
			dispatchEvent(new Event(CLOSE));
		}
	}
}
