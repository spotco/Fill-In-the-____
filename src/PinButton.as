package  {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	
	public class PinButton extends Sprite {
		
		private var floatlabels:Array = new Array;
		
		private var is_drag:Boolean = false;
		private var drag_counter:Number = 0;
		
		public var vx:Number = Math.random()*6-3;
		public var vy:Number = Math.random()*6-3;
		
		private static var init_anim_spd:Number = 25;
		private static var colors:Array = [0x3399dd, 0x99a6de, 0xafe1fe, 0xc6e6fc];
		private var init_counter:Number = init_anim_spd;
		
		private var closebutton:Sprite = new Sprite;
		
		private var testdraw:Sprite = new Sprite;
		private var kill:Number = -1;
		
		public function PinButton(v:Vector.<JsonEntry>) {
			
			this.addChild(testdraw);
			
			this.x = 900 / 2 + Math.random()*100-50;
			this.y = 600 / 2 + Math.random()*100-50;
			this.graphics.beginFill(rand_color(),0.8);
			this.graphics.lineStyle(7, 0x222222);
			this.graphics.drawCircle(0, 0, 230);
			this.graphics.endFill();
			this.addEventListener(MouseEvent.MOUSE_DOWN, click_down);
			this.addEventListener(MouseEvent.MOUSE_UP, click_up);
			
			this.scaleX = 0;
			this.scaleY = 0;
			
			//label_text_list = ["MSG1MSG1MSG1MSG1", "MSG2MSG2MSG2MSG2", "MSG3MSG3MSG3MSG3", "MSG4MSG4MSG4MSG4", "MSG3MSG3MSG3MSG3", "MSG4MSG4MSG4MSG4", "MSG3MSG3MSG3MSG3", "MSG4MSG4MSG4MSG4"];
			label_text_list = v;
			
			closebutton.addChild(new CROIX_IMG as Bitmap);
			closebutton.x = -20;
			closebutton.y = -200;
			this.addChild(closebutton);
			Common.add_mouse_over(closebutton);
			closebutton.addEventListener(MouseEvent.CLICK, function() {
				kill = 30;
				stsc = scaleX;
			});
		}
		
		private var add_counter:Number = 0;
		private var label_text_list:Vector.<JsonEntry>;
		
		private function add_text_label() {
			var fbl:FloatButtonLabel = new FloatButtonLabel(label_text_list.pop());
			floatlabels.push(fbl);
			this.addChild(fbl);
			fbl.update_scale();
		}
		
		//private function make_text_cloud(sts:Array) {
			//for (var i = sts.length-1; i >= 0; i--) {
				//var fbl:FloatButtonLabel = new FloatButtonLabel(sts[i], 40);
				//floatlabels.push(fbl);
				//this.addChild(fbl);
				//
				//fbl.x = Math.random() * 200 - 100;
				//fbl.y = Math.random() * 200 - 100;
				//
				//fbl.graphics.beginFill(0xFF0000);
				//fbl.graphics.drawCircle( -fbl.x, -fbl.y, 5);
				//
				//fbl.update_scale();
			//}
		//}
		
		private function update_labels() {
			//testdraw.graphics.clear();
			//testdraw.graphics.beginFill(0x00FF00);
			
			for each (var i:FloatButtonLabel in floatlabels) {
				var r:Rectangle = i.get_bounding_rect();
				
				//testdraw.graphics.drawRect(r.x-r.width/2, r.y-r.height/2, r.width, r.height);
				
				i.update();
				i.move_repel(floatlabels);
				
			}
			//testdraw.graphics.endFill();
		}
		
		public function move_repel(a:Array) {
			for each (var i:PinButton in a) {
				if (i != this && Common.dist(this, i) < 300) {
					var dvec:Vector.<Number> = Common.normalize_vec(i.x - this.x +Math.random() * 2 - 1 , i.y - this.y +Math.random() * 2 - 1);
					var sc:Number = -(300 - Common.dist(this, i)) / 300;
					
					this.vx += sc * dvec[0];
					this.vy += sc * dvec[1];
				}
			}
		}
		
		var stsc:Number;
		
		public function update(a:Array) {
			if (this.kill > -1) {
				this.scaleX = stsc * (this.kill) / 30;
				this.scaleY = stsc * (this.kill) / 30;
				kill--;
				if (this.kill == 0) {
					this.visible = false;
					parent.removeChild(this);
					a.splice(a.indexOf(this), 1);
				}
				return;
			}
			if (this.add_counter == 0 && this.label_text_list.length != 0) {
				this.add_counter = 20;
				add_text_label();
			} else {
				this.add_counter--;
			}
			
			this.x += this.vx;
			this.y += this.vy;
			
			this.vx *= 0.9;
			this.vy *= 0.9;
			
			update_labels();
			
			if (init_counter > 0) {
				this.scaleX = (init_anim_spd-this.init_counter) / init_anim_spd;
				this.scaleY = (init_anim_spd-this.init_counter) / init_anim_spd;
				init_counter--;
				return;
			}
			
			if (is_drag) {
				this.vy = 0;
				this.vx = 0;
				this.parent.setChildIndex(this, this.parent.numChildren - 1);
				drag_counter++;
				if (drag_counter > 6) {
					this.alpha = 0.7;
					this.x = stage.mouseX;
					this.y = stage.mouseY;
				} else {
					this.alpha = 1;
				}
			} else {
				this.alpha = 1;
				drag_counter = 0;
			}
			center_resize();
		}
		
		private function center_resize() {
			var cx:Number = Common.WID / 2;
			var cy:Number = Common.HEI / 2;
			var dist:Number = Math.sqrt(Math.pow(this.x - cx, 2) + Math.pow(this.y - cy, 2));
			var scale:Number = Math.max((Common.HEI - dist) / Common.HEI, 0.05);
			this.scaleX = scale;
			this.scaleY = scale;
		}
		
		private function click_down(e:MouseEvent) {
			is_drag = true;
		}
		
		private function click_up(e:MouseEvent) {
			is_drag = false;
		}
		
		private static function rand_color():uint {
			var c:uint = colors[Math.floor(Math.random() * colors.length)];
			return c;
		}
		
		[Embed(source = "../res/croix.png")] public static var CROIX_IMG:Class;
		
	}

}