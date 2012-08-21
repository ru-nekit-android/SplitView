package ru.nekit.koncept.controller
{
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import ru.nekit.koncept.*;
	import ru.nekit.p2p.model.GadgetInviteProxy;
	
	public class GenerateInviteKeyCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute(notification:INotification):void
		{
			var key:GadgetInviteProxy = facade.retrieveProxy(GadgetInviteProxy.NAME) as GadgetInviteProxy;
			key.generate();
			sendNotification(NAMES.GENERATE_KEY_SUCCESS, key);
			sendNotification(NAMES.CREATE_GADGET_INVITE, key);
		}
	}
}