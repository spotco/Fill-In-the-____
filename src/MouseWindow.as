package  
{
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.display.*;
	import flash.net.*;
	public class MouseWindow extends Sprite {
		
		public static var globalTooltip:MouseWindow;
		
		public function MouseWindow() {
			globalTooltip = this;
		}
		
		public static function create_tooltip(header:String, body:String, url:String) {
			while (globalTooltip.numChildren != 0) {
				globalTooltip.removeChildAt(0);
			}
			globalTooltip.visible = true;
			globalTooltip.addChild(create_textbox(header, body, url));
		}
		
		private static function create_textbox(header:String, body:String, url:String):Sprite {
			var header_text:TextField = FloatButtonLabel.make_text(header, 30);
			var body_text:TextField = FloatButtonLabel.make_text(body, 15);
			//var misc_text:TextField = FloatButtonLabel.make_text(misc, 15);
			
			header_text.selectable = true;
			
			body_text.width = Math.min(400, body_text.width);
			body_text.height = 165;
			body_text.wordWrap = true;
			body_text.border = false;
			body_text.selectable = true;
			
			var bodysp:Sprite = new Sprite;
			bodysp.graphics.beginFill(0xCFCFCF, 0.8);
			bodysp.graphics.lineStyle(5, 0x555555);
			//bodysp.graphics.drawRoundRect(0, 0, Math.max(body_text.textWidth,header_text.textWidth), body_text.textHeight + header_text.textHeight, 20);
			header_text.x = 5;
			header_text.y = 5;
			bodysp.addChild(header_text);
			
			body_text.x = 5;
			body_text.y = header_text.y + header_text.textHeight;
			bodysp.addChild(body_text);
			
			bodysp.graphics.drawRoundRect(0, 0, Math.max(body_text.textWidth, header_text.textWidth) + 40, body_text.y + body_text.textHeight+5, 20);
			bodysp.x = Common.WID - bodysp.width;
			bodysp.y = Common.HEI -  (body_text.y + body_text.textHeight + 10);
			
			body_text.width = Math.max(body_text.textWidth, header_text.textWidth);
			
			var closebutton:Sprite = new Sprite;
			closebutton.addChild(new PinButton.CROIX_IMG as Bitmap);
			closebutton.addEventListener(MouseEvent.CLICK, function() {
				MouseWindow.globalTooltip.visible = false;
			});
			closebutton.width = 25;
			closebutton.height = 25;
			closebutton.x = bodysp.width - 34;
			closebutton.y = 5;
			Common.add_mouse_over(closebutton);
			bodysp.addChild(closebutton);
			bodysp.alpha = 0.8;
			bodysp.addEventListener(MouseEvent.MOUSE_OVER, function() {
				bodysp.alpha = 1;
			});
			bodysp.addEventListener(MouseEvent.MOUSE_OUT, function() {
				bodysp.alpha = 0.8;
			});
			
			Common.add_mouse_over(header_text);
			header_text.addEventListener(MouseEvent.CLICK, function() {
				flash.net.navigateToURL(new URLRequest(url));
			});
			
			header_text.addEventListener(MouseEvent.MOUSE_OVER, function() {
				header_text.textColor = 0x333333;
			});
			header_text.addEventListener(MouseEvent.MOUSE_OUT, function() {
				header_text.textColor = 0x000000;
			});
			
			return bodysp;
		}
		
		
	}

}