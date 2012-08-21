package ru.nekit.koncept.controller
{
	import com.asual.swfaddress.SWFAddress;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import ru.nekit.koncept.NAMES;
	import ru.nekit.koncept.model.proxy.EmailConfirmationProxy;
	
	public class PathChangeCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			var pathNames:Array = SWFAddress.getPathNames();
			if( pathNames.length > 2 )
			{
				var command:String = String(pathNames[0]).toLowerCase();
				switch( command )
				{
					case "confirmation":
						
						sendNotification(NAMES.EMAIL_CONFIRMATION, new EmailConfirmationProxy(pathNames[1]));
						sendNotification(NAMES.GO_WAIT, "confirmation");
						
						break;
					
					default:
						
						break;
				}
			}
			//Alert.show(pathNames.toString());
		}
	}
}