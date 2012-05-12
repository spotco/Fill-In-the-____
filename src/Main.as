package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.Font;
	
	[SWF(backgroundColor = "#222222", frameRate = "60", width = "900", height = "600")]
	
	public class Main extends Sprite {
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addChild(new PinMain());
		}
		

		

		
	}
	
}