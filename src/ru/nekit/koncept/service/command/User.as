package ru.nekit.koncept.service.command
{
	import com.ak33m.rpc.xmlrpc.IXMLRPCStruct;
	
	import ru.nekit.koncept.service.XMLRPCCall;

	public class User
	{
		
		public static function manageProfile(vo:IXMLRPCStruct, successHandler:Function, faultHandler:Function):void
		{
			XMLRPCCall.call(successHandler, faultHandler, "Person.manageProfile", vo.getPropertyData() as Object);
		}
		
		public static function login(login:String, password:String, successHandler:Function, faultHandler:Function):void
		{
			XMLRPCCall.call(successHandler, faultHandler, "User.login", login, password);
		}
		
		public static function register(login:String, password:String, email:String, successHandler:Function, faultHandler:Function):void
		{
			XMLRPCCall.call(successHandler, faultHandler, "User.register", login, password, email);
		}
		
		public static function emailConfirmation(code:String, successHandler:Function, faultHandler:Function):void
		{
			XMLRPCCall.call(successHandler, faultHandler, "User.confirmEmail", code);
		}
		
		public static function logout(token:String, successHandler:Function, faultHandler:Function):void
		{
			XMLRPCCall.call(successHandler, faultHandler, "User.logout", token);
		}
		
	}
}