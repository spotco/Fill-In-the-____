package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.net.*;
	import flash.events.*;
	import com.adobe.serialization.json.JSON;
	
	public class PinMain extends Sprite  {
		
		var searchbar:PinSearchBar;
		
		var animTimer:Timer = new Timer(30);
		var buttons:Array = new Array;
		//http://spotcos.com/misc/yahoo/test.php
		public function PinMain() {
			searchbar = new PinSearchBar(135, 10);
			searchbar.addEventListener("search_button_click", search);
			this.addChild(searchbar);
			//make_button();
			animTimer.addEventListener(TimerEvent.TIMER, anim_update);
			animTimer.start();
		}
		
		public function search(e:Event) {
			var s1:String = searchbar.field1.textfield.text;
			var s2:String = searchbar.field2.textfield.text;
			var s3:String = searchbar.field3.textfield.text;
			
			searchbar.field1.textfield.text = "";
			searchbar.field2.textfield.text = "";
			searchbar.field3.textfield.text = "";
			
			make_button(s1 + " " + s2 + " " + s3);
			envoyer_requet(s1, s2, s3);
		}
		
		public function anim_update(e:Event) {
			for each(var i:PinButton in buttons) {
				if (i.x > Common.WID + 200 || i.x < -200 || i.y > Common.HEI + 200 || i.y < -200) {
					this.removeChild(i);
					buttons.splice(buttons.indexOf(i), 1);
					continue;
				}
				i.update(buttons);
				i.move_repel(buttons);
			}
		}
		
		public function make_button(text:String) {
			var nb:PinButton = new PinButton(text);
			buttons.push(nb);
			this.addChild(nb);
		}
		
		public function envoyer_requet(s1:String, s2:String, s3:String) {
			var urlRequest:URLRequest = new URLRequest('http://spotcos.com/misc/yahoo/test.php');
			urlRequest.data = makeUrlVars();
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, idRecieved);
			urlLoader.load(urlRequest);
			configureErrors(urlLoader);
			trace("requete envoyé");
		}
		
		public function idRecieved(e:Event) {
			trace(e.target.data);
			//var data:Object = JSON.decode(e.target.data);
			//var i:int = 0;
			//while (data[i]) {
				//trace(data[i]);
				//i++;
			//}
		}
		
		private function configureErrors(dispatcher:IEventDispatcher) {
			dispatcher.addEventListener(NetStatusEvent.NET_STATUS, errorhandle);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorhandle);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR,errorhandle);
		}
		

		private function errorhandle(e:Event) {
			trace("erreur reseau");
		}
		
		public static function makeUrlVars():URLVariables {
			var v:URLVariables = new URLVariables;
			v.nocache = new Date().getTime();
			return v;
		}
		
		
	}

}