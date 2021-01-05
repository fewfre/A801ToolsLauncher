package com.fewfre2.utils
{
	import flash.display.*;
	import flash.geom.*;
	import flash.net.*;
	
	public class FewfDisplayUtils
	{
		// Scale type: Contain
		public static function fitWithinBounds(pObj:DisplayObject, pMaxWidth:Number, pMaxHeight:Number, pMinWidth:Number=0, pMinHeight:Number=0) : DisplayObject {
			var tRect:flash.geom.Rectangle = pObj.getBounds(pObj);
			var tWidth:Number = tRect.width * pObj.scaleX;
			var tHeight:Number = tRect.height * pObj.scaleY;
			var tMultiX:Number = 1;
			var tMultiY:Number = 1;
			if(tWidth > pMaxWidth) {
				tMultiX = pMaxWidth / tWidth;
			}
			else if(tWidth < pMinWidth) {
				tMultiX = pMinWidth / tWidth;
			}
			
			if(tHeight > pMaxHeight) {
				tMultiY = pMaxHeight / tHeight;
			}
			else if(tHeight < pMinHeight) {
				tMultiY = pMinHeight / tHeight;
			}
			
			var tMulti:Number = 1;
			if(tMultiX > 0 && tMultiY > 0) {
				tMulti = Math.min(tMultiX, tMultiY);
			}
			else if(tMultiX < 0 && tMultiY < 0) {
				tMulti = Math.max(tMultiX, tMultiY);
			}
			else {
				tMulti = Math.min(tMultiX, tMultiY);
			}
			
			pObj.scaleX *= tMulti;
			pObj.scaleY *= tMulti;
			return pObj;
		}
	}
}
