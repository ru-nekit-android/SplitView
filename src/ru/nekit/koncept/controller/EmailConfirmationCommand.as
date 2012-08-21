package ru.nekit.koncept.controller
{
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import ru.nekit.koncept.NAMES;
	import ru.nekit.koncept.model.proxy.EmailConfirmationProxy;
	import ru.nekit.koncept.service.command.User;
	
	public class EmailConfirmationCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute(notification:INotification):void
		{
			var emailConfirmation:EmailConfirmationProxy = notification.getBody() as EmailConfirmationProxy;
			User.emailConfirmation(emailConfirmation.code, successHandler, faultHandler);
		}
		
		private function successHandler(event:ResultEvent, token:Object = null):void
		{
			sendNotification(NAMES.EMAIL_CONFIRMATION_SUCCESS, event.result);
		}
		
		private function faultHandler(event:FaultEvent, token:Object = null):void
		{
			sendNotification(NAMES.EMAIL_CONFIRMATION_FAULT, event.fault.faultCode);
		}
	}
}