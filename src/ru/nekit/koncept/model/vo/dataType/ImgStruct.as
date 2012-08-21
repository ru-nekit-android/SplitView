package ru.nekit.koncept.model.vo.dataType
{
	
	public class ImgStruct extends URIStruct
	{
		
		public var title:String;
		public var path:String;
		public var description:String;
		
		public function ImgStruct(uri:String = null, path:String = null, title:String = null, description:String = null):void
		{
			this.subject		= uri;
			this.path 			= path;
			this.title 			= title;
			this.description 	= description;
		}
		
		override public function get predicate():String
		{
			return "foaf:img";
		}
	}
}