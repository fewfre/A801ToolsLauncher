package app2.ui.buttons
{
	import com.fewfre2.display.ButtonBase;
	import com.fewfre2.display.TextBase;
	import app2.ui.*;
	import app2.data.*;
	import flash.display.*;
	import flash.text.*;
	import flash.events.MouseEvent;
	
	public class SpriteButton extends ButtonBase
	{
		// Storage
		protected var _bg : RoundedRectangle;
		public var Image : DisplayObject;
		public var Text : TextBase;
		
		// Properties
		public function get Width():Number { return _bg.Width; }
		public function get Height():Number { return _bg.Height; }
		
		// Constructor
		// pData = { x:Number, y:Number, width:Number, height:Number, ?obj:DisplayObject, ?obj_scale:Number, ?id:int, ?text:String, ?origin:Number, ?originX:Number, ?originY:Number }
		public function SpriteButton(pData:Object)
		{
			_bg = addChild(new RoundedRectangle({ x:0, y:0, width:pData.width, height:pData.height, origin:pData.origin, originX:pData.originX, originY:pData.originY })) as RoundedRectangle;
			super(pData);
			
			if(pData.obj) {
				ChangeImage(pData.obj);
				if(pData.obj_scale) {
					this.Image.scaleX = pData.obj_scale ? pData.obj_scale : 0.75;
					this.Image.scaleY = pData.obj_scale ? pData.obj_scale : 0.75;
				}
			}
			
			if(pData.text) {
				this.Text = addChild(new TextBase({ text:pData.text, size:12, x:this.Width * (0.5 - _bg.originX) - 2, y:this.Height * 0.5 - 2 })) as TextBase;
			}
		}

		public function ChangeImage(pMC:DisplayObject) : void
		{
			var tScale:Number = 1;
			if(this.Image != null) { tScale = this.Image.scaleX; removeChild(this.Image); }
			this.Image = addChild( pMC );
			this.Image.x = this.Width * (0.5 - _bg.originX);
			this.Image.y = this.Height * (0.5 - _bg.originY);
			this.Image.scaleX = this.Image.scaleY = tScale;
		}

		/****************************
		* Render
		*****************************/
		override protected function _renderUp() : void {
			_bg.draw(ConstantsApp.COLOR_BUTTON_BLUE, 7, ConstantsApp.COLOR_BUTTON_OUTSET_TOP, ConstantsApp.COLOR_BUTTON_OUTSET_BOTTOM, ConstantsApp.COLOR_BUTTON_BLUE);
		}
		
		override protected function _renderDown() : void {
			if(this.Text) this.Text.color = 0xC2C2DA;
			if(this.Image) this.Image.alpha = 1;
			_bg.draw(ConstantsApp.COLOR_BUTTON_MOUSE_DOWN, 7, ConstantsApp.COLOR_BUTTON_OUTSET_BOTTOM, ConstantsApp.COLOR_BUTTON_BLUE, ConstantsApp.COLOR_BUTTON_MOUSE_DOWN);
		}
		
		override protected function _renderOver() : void {
			if(this.Text) this.Text.color = 0xB2B2CA;
			if(this.Image) this.Image.alpha = 0.8;
			_bg.draw(ConstantsApp.COLOR_BUTTON_MOUSE_OVER, 7, ConstantsApp.COLOR_BUTTON_OUTSET_BOTTOM, ConstantsApp.COLOR_BUTTON_BLUE, ConstantsApp.COLOR_BUTTON_MOUSE_OVER);
		}
		
		override protected function _renderOut() : void {
			if(this.Text) this.Text.color = 0xC2C2DA;
			if(this.Image) this.Image.alpha = 1;
			_renderUp();
		}
		
		override protected function _renderDisabled() : void {
			_bg.draw(0x555555, 7, ConstantsApp.COLOR_BUTTON_OUTSET_BOTTOM, ConstantsApp.COLOR_BUTTON_BLUE, 0x555555);
		}
	}
}
