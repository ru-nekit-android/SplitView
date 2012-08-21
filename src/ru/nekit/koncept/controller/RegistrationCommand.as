package ru.nekit.koncept.controller
{
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import ru.nekit.koncept.NAMES;
	import ru.nekit.koncept.model.proxy.UserProxy;
	import ru.nekit.koncept.service.command.User;
	
	public class RegistrationCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute(notification:INotification):void
		{
			var user:UserProxy 			= facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			User.register(user.login, user.password, user.email, successHandler, faultHandler);
		}
		
		private function successHandler(event:ResultEvent, token:Object = null):void
		{
			sendNotification(NAMES.REGISTRATION_SUCCESS, event.result);	
		}
		
		private function faultHandler(event:FaultEvent, token:Object = null):void
		{
			var user:UserProxy 			= facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			user.clear();
			sendNotification(NAMES.REGISTRATION_FAULT, event.fault.faultCode);
		}
	}
}