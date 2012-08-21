package ru.nekit.koncept.controller
{
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import ru.nekit.koncept.NAMES;
	import ru.nekit.koncept.model.proxy.PersonProfileProxy;
	import ru.nekit.koncept.model.proxy.UserProxy;
	import ru.nekit.koncept.service.command.Person;
	
	public class PersonProfileGetCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute(notification:INotification):void
		{	
			var body:Object 						= notification.getBody();
			var type:String 						= notification.getType();
			var user:UserProxy 						= facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			Person.getProfile(user.login, successProfileHandler, faultProfileHandler);
		}
		
		private function successProfileHandler(event:ResultEvent, token:Object = null):void
		{
			var userProfile:PersonProfileProxy 		= facade.retrieveProxy(PersonProfileProxy.NAME) as PersonProfileProxy;
			userProfile.readData(event.result);
			sendNotification(NAMES.PERSON_GET_PROFILE_SUCCESS);	
		}
		
		private function faultProfileHandler(event:FaultEvent, token:Object = null):void
		{
			sendNotification(NAMES.PERSON_GET_PROFILE_FAILED, event.fault.faultCode);
		}
	}
}