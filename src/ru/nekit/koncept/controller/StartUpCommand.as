package ru.nekit.koncept.controller
{
	
	import com.asual.swfaddress.SWFAddress;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import ru.nekit.koncept.NAMES;
	import ru.nekit.koncept.model.proxy.*;
	import ru.nekit.koncept.service.gadget.GadgetPublicConnectionService;
	import ru.nekit.koncept.view.ApplicationMediator;
	
	public class StartUpCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute(notification:INotification):void
		{
			facade.registerMediator(new ApplicationMediator(notification.getBody()));
			var user:UserProxy = new UserProxy;
			facade.registerProxy(user);
			user.restore();
			
			facade.registerProxy(new GadgetInviteCodeProxy);
			facade.registerProxy(new GadgetPublicConnectionService);
			facade.registerProxy(new SupportDevicesProxy);
			facade.registerProxy(new MapInfoProxy);
			facade.registerProxy(new PersonProfileProxy);
			
			SWFAddress.onInit = swfAddressInit;	
		}	
		
		private function swfAddressInit():void
		{
			sendNotification(NAMES.PATH_CHANGE);	
			sendNotification(NAMES.STARTUP_COMPLETE);
		}
	}
}