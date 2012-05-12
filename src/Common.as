package  {
	import flash.text.TextFormat;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.ui.MouseCursor;

	public class Common {
		
		public static var WID:Number = 900;
		public static var HEI:Number = 600;
		
		[Embed(source='../res/BebasNeue.otf', embedAsCFF="false", fontName='Menu', fontFamily="Menu", mimeType='application/x-font')]
		public static var GAMEFONT:Class;
		
		public static function getTextFormat(size:Number):TextFormat {
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = "Menu";
			textFormat.size = size;
			return textFormat;
		}
		
		public static function add_mouse_over(o:DisplayObject) {
			o.addEventListener(MouseEvent.ROLL_OVER, function() {
				flash.ui.Mouse.cursor = MouseCursor.BUTTON;
			});
			o.addEventListener(MouseEvent.ROLL_OUT, function() {
				flash.ui.Mouse.cursor = MouseCursor.AUTO;
			});
		}
		
		public static function dist(a:DisplayObject, b:DisplayObject):Number {
			return Math.sqrt( Math.pow(a.x - b.x, 2) + Math.pow(a.y - b.y, 2) );
		}
		
		public static function normalize_vec(x:Number, y:Number) {
			var v:Vector.<Number> = new Vector.<Number>();
			var len:Number = Math.sqrt(x * x + y * y);
			v.push(x / len); 
			v.push(y / len);
			return v;
		}
		
		public static function sig(x:Number, val:Number = 1):Number {
			if (x < 0) {
				return -val;
			} else {
				return val;
			}
		}
		
	}

}