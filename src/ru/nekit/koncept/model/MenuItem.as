package ru.nekit.koncept.model
{
	public class MenuItem
	{
		
		public var action:String;
		public var label:String;
		public var icon:String;
		public var message:String;
		public var data:*;
		
		public function MenuItem(label:String, action:String = null, icon:String = null, message:String = null, data:* = null)
		{
			this.label 		= label;
			this.action 	= action;
			this.icon 		= icon;
			this.message 	= message;
			this.data		= data;
		}
	}
}