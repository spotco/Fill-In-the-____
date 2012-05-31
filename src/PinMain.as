package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.net.*;
	import flash.events.*;
	import com.adobe.serialization.json.JSON;
	
	public class PinMain extends Sprite  {
		
		var searchbar:PinSearchBar;
		
		var animTimer:Timer = new Timer(30);
		var buttons:Array = new Array;
		
		//var falltext_strings:Array;
		var falltext_infos:Vector.<JsonEntry>;
		var falltext_labels:Array = new Array;
		var falltext_ct:Number = 0;
		
		public function PinMain() {
			searchbar = new PinSearchBar(110, 10);
			searchbar.addEventListener("search_button_click", search);
			this.addChild(searchbar);
			//make_button();
			animTimer.addEventListener(TimerEvent.TIMER, anim_update);
			animTimer.start();
			
			this.addChild(new MouseWindow);
			request_current_news();
		}
		
		private function request_current_news() {
			var urlRequest:URLRequest = new URLRequest('http://spotcos.com/misc/yahoo/index.php');
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, current_news_recieved);
			urlLoader.load(urlRequest);
			configureErrors(urlLoader);
			trace("requête envoyé pour les actualités");
		}
		
		private function current_news_recieved(e:Event) {
			var jayson:Object = JSON.decode(e.target.data);
			var i:Number = 0;
			falltext_infos = new Vector.<JsonEntry>();
			while(jayson[i]) {
				//var rowe = jayson[i];
				//trace(rowe["keyword"]);
				//rowe = rowe["info"][0];
				//trace(rowe["title"]);
				//trace(rowe["url"]);
				//trace(rowe["content"]);
				
				var nje:JsonEntry = new JsonEntry(jayson[i], true);
				falltext_infos.push(nje);
				i++;
			}
			falltext_ct = 5;
			trace("info d'actualities reçu");
		}
		
		public function search(e:Event) {
			var s1:String = searchbar.field1.textfield.text;
			var s2:String = searchbar.field2.textfield.text;
			var s3:String = searchbar.field3.textfield.text;
			
			searchbar.field1.textfield.text = "";
			searchbar.field2.textfield.text = "";
			searchbar.field3.textfield.text = "";
			
			var noms:Array = [s1, s2, s3];
			//make_button(s1 + " " + s2 + " " + s3);
			envoyer_requet(s1, s2, s3);
		}
		
		public function anim_update(e:Event) {
			if (falltext_ct <= 0) {
				if (falltext_infos != null && falltext_infos.length > 0) {
					//trace("add");
					var s:FloatButtonLabel = new FloatButtonLabel(falltext_infos.pop(),0xBBBBBB);
					s.text.textColor = 0xFFFFFF;
					this.addChild(s);
					falltext_labels.push(s);
					s.x = Math.random() * Common.WID;
					s.vy = Math.random() * 2 + 2;
					s.addEventListener(MouseEvent.MOUSE_OVER, function() {
						s.mouseover = true;
					});
					s.addEventListener(MouseEvent.MOUSE_OUT, function() {
						s.mouseover = false;
					});
					falltext_ct = 10;
				}
				falltext_ct = Math.random()*40+30;
			} else {
				//trace(falltext_ct);
				falltext_ct--;
			}
			for each (var j:FloatButtonLabel in falltext_labels) {
				if (j.mouseover) {
					j.alpha = 1;
					continue;
				} else {
					j.alpha = 0.8;
				}
				j.y += j.vy;
				this.setChildIndex(j, 0);
				if (j.y > Common.HEI + 100) {
					this.removeChild(j);
					falltext_labels.splice(falltext_labels.indexOf(j), 1);
					this.falltext_infos.push(j.json_data);
				}
			}
			
			for each(var i:PinButton in buttons) {
				if (i.x > Common.WID + 200 || i.x < -200 || i.y > Common.HEI + 200 || i.y < -200) {
					this.removeChild(i);
					buttons.splice(buttons.indexOf(i), 1);
					continue;
				}
				i.update(buttons);
				i.move_repel(buttons);
			}
			this.setChildIndex(MouseWindow.globalTooltip, this.numChildren - 1);
		}
		
		public function make_button(v:Vector.<JsonEntry>, noms:Array) {
			var nb:PinButton = new PinButton(v,noms);
			buttons.push(nb);
			this.addChild(nb);
		}
		
		public function envoyer_requet(s1:String, s2:String, s3:String) {
			var urlRequest:URLRequest = new URLRequest('http://spotcos.com/misc/yahoo/search_extract.php');
			urlRequest.data = makeUrlVars(s1,s2,s3);
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, function(e:Event) {
				idRecieved(e,[s1,s2,s3]);
			});
			urlLoader.load(urlRequest);
			configureErrors(urlLoader);
			trace("requête envoyé");
		}
		
		public function idRecieved(e:Event,noms:Array) {
			var data:Object = JSON.decode(e.target.data);
			trace(e.target.data);
			//make_button(s1 + " " + s2 + " " + s3);
			var v:Vector.<JsonEntry> = new Vector.<JsonEntry>();
 			var i:int = 0;
			while (data[i]) {
				var j:JsonEntry = new JsonEntry(data[i]);
				v.push(j);
				i++;
			}
			make_button(v,noms);
		}
		
		private function configureErrors(dispatcher:IEventDispatcher) {
			dispatcher.addEventListener(NetStatusEvent.NET_STATUS, errorhandle);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorhandle);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, errorhandle);
			
		}
		

		private function errorhandle(e:Event) {
			trace("erreur reseau");
			var er:TextField = FloatButtonLabel.make_text("Network Error", 60);
			er.textColor = 0xFFFFFF;
			er.x = Math.random() * Common.WID;
			er.addEventListener(Event.ENTER_FRAME, function() {
				er.y++;
				if (er.y > Common.HEI) {
					er.x = Math.random()*Common.WID;
					er.y = 0;
				}
			});
			this.addChildAt(er, 0);
		}
		
		public static function makeUrlVars(s1:String, s2:String, s3:String):URLVariables {
			var v:URLVariables = new URLVariables;
			trace("a:" + s1);
			trace("b:" + Common.DEFAULT_TXT);
			trace(Common.DEFAULT_TXT == s1);
			if ( s2.length != 0 || s3.length != 0 || (s1.length != 0 && s1 != Common.DEFAULT_TXT)) {
				trace("requête parametres s1:" + s1 + " s2:" + s2 + " s3:"+s3);
				v.arg1 = s1;
				v.rel = s2;
				v.arg2 = s3;
			} else {
				trace("random");
			}
			v.nocache = new Date().getTime();
			return v;
		}
		
		
	}

}