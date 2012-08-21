package ru.nekit.koncept.service.gadget.event
{
	import flash.events.Event;
	
	public class GadgetEvent extends Event
	{
		
		public static const GADGET_CONNECTED:String = "connected";
		
		public function GadgetEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}