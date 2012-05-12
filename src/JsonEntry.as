package {

	public class JsonEntry {
		
		public var arg1:String;
		public var rel:String;
		public var arg2:String;
		
		public var title:String;
		public var url:String
		public var date:String;
		public var content:String;
		
		public var confidence:Number;
		
		public function JsonEntry(o:Object) {
						//var first = data[0];
			//trace(first["arg1"]);
			//trace(first["rel"]);
			//trace(first["arg2"]);
			//trace(first["confidence"]);
			//
			//var first_info = first["info"];
			//trace(first_info["title"]);
			//trace(first_info["content"]);
			
			this.arg1 = o["arg1"];
			this.rel = o["rel"];
			this.arg2 = o["arg2"];
			this.confidence = Number(o["confidence"]);
			
			o = o["info"];
			this.title = o["title"];
			this.url = o["info"];
			this.date = o["date"];
			this.content = o["content"];
			
			if (arg1 == null) {
				arg1 = "";
				trace("arg1 null");
			}
			if (rel == null) {
				rel = "";
				trace("rel null");
			}
			if (arg2 == null) {
				arg2 = "";
				trace("arg2 null");
			}
			if (title == null) {
				title = "";
				trace("title null");
			}
			if (content == null) {
				title = "";
				trace("title null");
			}
		}
		
	}

}