package  
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	
	public class FloatButtonLabel extends Sprite {
		
		var vx:Number = 0;
		var vy:Number = 0;
		public var mouseover:Boolean = false;
		public var text:TextField;
		
		public function FloatButtonLabel(text:String, priority:Number, info:Object = null) {
			this.text = make_text(text, priority);
			this.addChild(this.text);
		}
		
		public function update_scale() {
			var dist:Number = Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2));
			var scale:Number = Math.max((200 - dist) / 200, 0.2);
			this.scaleX = scale;
			this.scaleY = scale;
		}
		
		public function update() {
			this.x += vx;
			this.y += vy;
			this.vx *= 0.2;
			this.vy *= 0.2;
			update_scale();
			if (Math.sqrt(x * x + y * y) > 170) {
				this.alpha = Math.max(200 - Math.sqrt(x * x + y * y), 0);
			}
		}
		
		public function get_bounding_rect():Rectangle {
			return new Rectangle(this.x, this.y, this.text.width * this.scaleX, this.text.height * this.scaleY);
		}
		
		public function move_repel(a:Array) {
			for each (var i:FloatButtonLabel in a) {
				if (i != this && (Common.dist(i, this) < 100 || Math.abs(this.x - i.x) < this.width*Math.max(1,this.scaleX) && Math.abs(this.y - i.y) < 100*Math.max(1,this.scaleX))) {
					var dvec:Vector.<Number> = Common.normalize_vec(i.x - this.x +Math.random() * 2 - 1 , i.y - this.y +Math.random() * 10 - 5);
					var sc:Number = -(100 - Common.dist(this, i)) / 100;
					dvec[0] *= 0.7;
					dvec[1] *= 2;
					
					if (this.x > 0) {
						this.vx = Math.min(5,this.vy + sc * dvec[0]);
					} else {
						this.vx = Math.max(-5,this.vy + sc * dvec[0]);
					}
					
					if (this.y > 0) {
						this.vy = Math.min(5,this.vy + sc * dvec[1]);
					} else {
						this.vy = Math.max(-5,this.vy + sc * dvec[1]);
					}
					
				}
			}
		}
		
		public static function make_text(text:String, priority:Number):TextField {
			var ntx:TextField = new TextField;
			ntx.text = text;
			ntx.embedFonts = true;
			ntx.antiAliasType = AntiAliasType.ADVANCED;
			ntx.selectable = false;
			ntx.defaultTextFormat = Common.getTextFormat(priority);
			ntx.setTextFormat(Common.getTextFormat(priority));
			ntx.width = ntx.textWidth+10;
			ntx.height = ntx.textHeight+10;
			ntx.x = -ntx.width / 2;
			ntx.y = -ntx.height / 2;
			return ntx;
		}
		
	}

}