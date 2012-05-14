package {

	public class JsonEntry {
		
		public var arg1:String;
		public var rel:String;
		public var arg2:String;
		
		public var title:String;
		public var url:String
		public var date:String;
		public var content:String;
		
		public var keyword:String;
		
		public var confidence:Number;
		
		public function JsonEntry(o:Object, alt:Boolean = false) {

			if (alt) {
				
				this.keyword = o["keyword"];
				var op = o["info"][0];
				this.title = op["title"];
				this.url = op["url"];
				this.content = op["content"];
				return;
			} else {
				
				this.arg1 = o["arg1"];
				this.rel = o["rel"];
				this.arg2 = o["arg2"];
				this.confidence = Number(o["confidence"]);
				
				o = o["info"];
				this.title = o["title"];
				this.keyword = o["title"];
				this.url = o["url"];
				this.date = o["date"];
				this.content = o["content"];
				this.keyword = this.arg1 + " " + this.rel + " " + this.arg2;
			}
			
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