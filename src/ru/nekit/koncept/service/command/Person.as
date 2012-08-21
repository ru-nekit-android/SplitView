package ru.nekit.koncept.service.command
{
	import ru.nekit.koncept.model.util.changeWatcher.serialize.XMLRPCOperation;
	import ru.nekit.koncept.model.util.changeWatcher.operation.SPOOperation;
	import ru.nekit.koncept.service.XMLRPCCall;
	
	public class Person
	{
		public static function getProfile(login:String, successHandler:Function, faultHandler:Function):void
		{
			XMLRPCCall.call(successHandler, faultHandler, "Person.getProfile", login);
		}
		
		public static function manageProfile(token:String, operationList:Vector.<XMLRPCOperation>, successHandler:Function, faultHandler:Function):void
		{
			XMLRPCCall.call(successHandler, faultHandler, "User.test", operationList);
		}
	}
}