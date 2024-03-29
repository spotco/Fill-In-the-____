package  
{
	import avmplus.variableXml;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	/**
	 * ...
	 * @author test
	 */
	public class PinSearchBar extends Sprite {
		
		public var field1:PinSearchBarEntrybar;
		public var field2:PinSearchBarEntrybar;
		public var field3:PinSearchBarEntrybar;
		
		public var search_button:Sprite;
		
		public function PinSearchBar(x:Number, y:Number) {
			this.x = x;
			this.y = y;
			
			this.graphics.lineStyle(5, 0x222222);
			this.graphics.beginBitmapFill((new BAR_TEX as Bitmap).bitmapData);
			this.graphics.drawRoundRect(0, 0, 665, 95, 25);
			this.graphics.endFill();
			
			
			field1 = new PinSearchBarEntrybar(15, 18, 220, 67, Common.DEFAULT_TXT);
			field2 = new PinSearchBarEntrybar(240, 18, 130, 67);
			field3 = new PinSearchBarEntrybar(375, 18, 220, 67);
			
			this.addChild(field1);
			this.addChild(field2);
			this.addChild(field3);
			
			search_button = new Sprite;
			search_button.addChild(new ARROW_IMG as Bitmap);
			search_button.x = 605;
			search_button.y = 35;
			Common.add_mouse_over(search_button);
			this.addChild(search_button);
			
			search_button.addEventListener(MouseEvent.CLICK, search_button_click);
			
			var l:TextField = FloatButtonLabel.make_text("Arg 1", 10);
			l.x = 15; l.y = 5;
			this.addChild(l);
			
			
			l = FloatButtonLabel.make_text("Rel", 10);
			l.x = 240; l.y = 5;
			this.addChild(l);
			
			l = FloatButtonLabel.make_text("Arg 2", 10);
			l.x = 375; l.y = 5;
			this.addChild(l);
			
			l = FloatButtonLabel.make_text("Fill in the _ _ _", 30);
			l.textColor = 0xCFCFCF;
			l.x = 15; l.y = 93;
			this.addChild(l);
			
			l = FloatButtonLabel.make_text("Powered by Reverb", 10);
			l.textColor = 0xCFCFCF;
			l.x = 15; l.y = 123;
			this.addChild(l);
		}
		
		private function search_button_click(e:Event) {
			var e:Event = new Event("search_button_click");
			this.dispatchEvent(e);
		}
	
		[Embed(source = "../res/searchbartex.png")] public static var BAR_TEX:Class;
		[Embed(source = "../res/arrow.png")] public static var ARROW_IMG:Class;
	}

}