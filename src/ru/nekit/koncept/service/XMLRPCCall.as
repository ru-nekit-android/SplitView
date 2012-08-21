package ru.nekit.koncept.service
{
	
	import com.ak33m.rpc.xmlrpc.XMLRPCObject;
	
	import mx.collections.ItemResponder;
	import mx.rpc.AsyncToken;
	
	import ru.nekit.koncept.CONFIG;
	
	public class XMLRPCCall
	{
		
		public static function call(successHandler:Function, faultHandler:Function, command:String, ...args):void
		{
			var obj:XMLRPCObject 		= new XMLRPCObject;
			obj.endpoint 				= CONFIG.endpoint;
			obj.destination 			= CONFIG.xmlrpcDestination;
			var call:Function 			= obj.call;
			args.unshift(command);
			var token:AsyncToken 		= call.apply(null, args);
			var tresponder:ItemResponder = new ItemResponder(successHandler, faultHandler);
			token.addResponder(tresponder);	
		}
	}
}