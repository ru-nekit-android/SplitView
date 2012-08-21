package ru.nekit.koncept.service.gadget
{
	
	import com.projectcocoon.p2p.events.MessageEvent;
	
	import ru.nekit.p2p.model.GadgetInviteProxy;
	import ru.nekit.p2p.model.GadgetListProxy;
	import ru.nekit.p2p.model.vo.ComputerVO;
	import ru.nekit.p2p.model.vo.GadgetVO;
	import ru.nekit.p2p.service.gadget.event.GadgetEvent;
	
	public class GadgetInviteSevice extends GadgetService
	{
		
		public static const NAME:String 					= "gadget_invite";
		
		public function GadgetInviteSevice()
		{
			super(NAME);
		}
		
		public function invite(key:GadgetInviteProxy):void
		{
			addEventListener(GadgetEvent.GADGET_CONNECTED, gadgetConnectHandler);
			connection.addEventListener(MessageEvent.DATA_RECEIVED, dataReceivedHandler);
			if( !isConnected )
			{
				connection.clientName 	= "desktop";
				connection.groupName 	= "group_invite::" + 1;//key.toMD5( "::puorg" );
				/*
				connection.publishPasswordSalt  = "_!_poloonezy";
				connection.postPasswordSalt  	= "_!_zivert";
				connection.publishPassword		= key.toMD5(connection.publishPasswordSalt);
				connection.postPassword			= key.toMD5(connection.postPasswordSalt);
				*/
				connect();
			}
		}
		
		private function dataReceivedHandler(event:MessageEvent):void
		{
			/*var gadget:GadgetVO;
			var gadgetList:GadgetListProxy = facade.retrieveProxy(GadgetListProxy.NAME) as GadgetListProxy;
			if( gadgetList.have(gadget) )
			{
				
			}
			else
			{
				gadgetList.add(gadget);
			}
*/		}
		
		private function gadgetConnectHandler(event:GadgetEvent):void
		{
			//send("hello gadget");
			//handshake();
		}
	}
}