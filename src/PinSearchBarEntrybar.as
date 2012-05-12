package  {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	
	public class PinSearchBarEntrybar extends Sprite {
		
		public var bg_fill:Sprite;
		public var textfield:TextField;
		
		public function PinSearchBarEntrybar(x:Number, y:Number, w:Number, h:Number, deftext:String = "text") {
			this.x = x;
			this.y = y;
			
			bg_fill = new Sprite;
			this.addChild(bg_fill);
			
			this.graphics.lineStyle(2, 0x222222);
			bg_fill.graphics.beginBitmapFill((new ENTRY_TEX as Bitmap).bitmapData);
			this.graphics.drawRoundRect(0, 0, w, h, 5);
			bg_fill.graphics.drawRoundRect(0, 0, w, h, 5);
			
			this.textfield = create_textfield(10, 7, w-20, h-10, deftext);
			this.addChild(this.textfield);
			
			this.addEventListener(FocusEvent.FOCUS_IN, focus_in);
			this.addEventListener(FocusEvent.FOCUS_OUT, focus_out);
			
			bg_fill.alpha = 0.5;			
		}
		
		private function focus_in(e:Event) {
			bg_fill.alpha = 0.9;
		}
		
		private function focus_out(e:Event) {
			bg_fill.alpha = 0.5;
		}
		
		private function create_textfield(x:Number, y:Number, w:Number, h:Number, deftext):TextField {
			var ntx:TextField = new TextField;
			ntx.text = deftext;
			ntx.embedFonts = true;
			ntx.antiAliasType = AntiAliasType.ADVANCED;
			ntx.type = "input";
			ntx.defaultTextFormat = Common.getTextFormat(50);
			ntx.setTextFormat(Common.getTextFormat(50));
			ntx.x = x;
			ntx.y = y;
			ntx.width = w;
			ntx.height = h;
			
			return ntx;
		}
		
		[Embed(source = "../res/entrybartex.png")] public static var ENTRY_TEX:Class;
		
	}

}