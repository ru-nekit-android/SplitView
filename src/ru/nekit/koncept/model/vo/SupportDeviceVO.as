package ru.nekit.koncept.model.vo
{
	public class SupportDeviceVO
	{
		
		public function SupportDeviceVO(id:uint, title:String, os:String, model:String, message:String, url:String ):void
		{
			this.id 		= id;
			this.title 		= title;
			this.os 		= os;
			this.model 		= model;
			this.message 	= message;
			this.url 		= url;
		}
		
		public var id:uint;
		public var title:String;
		public var os:String;
		public var model:String;
		public var message:String;
		public var url:String;
		
	}
}