package ru.nekit.koncept.service.gadget
{
	
	import com.projectcocoon.p2p.LocalNetworkDiscovery;
	import com.projectcocoon.p2p.events.ClientEvent;
	import com.projectcocoon.p2p.events.GroupEvent;
	import com.projectcocoon.p2p.vo.ClientVO;
	
	import flash.events.Event;
	
	import ru.nekit.koncept.service.AbstractService;
	import ru.nekit.koncept.service.gadget.event.GadgetEvent;
	
	internal class GadgetService extends AbstractService
	{
		
		protected static const ERROR_STATUS:String 			= "error";
		protected static const START_STATUS:String 			= "start";
		protected static const INIT_STATUS:String 			= "init";
		protected static const INIT_COMPLETE_STATUS:String 	= "init_complete";
		protected static const DISCONNECT_STATUS:String 	= "disconnect";
		
		protected var connection:LocalNetworkDiscovery;
		
		protected var _status:String;
		protected var _gadget:ClientVO;
		
		public function GadgetService(proxyName:String)
		{
			super(proxyName);
			status 					= START_STATUS;
			connection 				= new LocalNetworkDiscovery;
			connection.loopback 	= false;
		}
		
		protected function connect():void
		{
			connection.addEventListener(ClientEvent.CLIENT_ADDED, 	addClientHandler);
			connection.addEventListener(GroupEvent.GROUP_CONNECTED, groupConnectedHandler);
			connection.addEventListener(ClientEvent.CLIENT_UPDATE, 	updateClientHandler);
			connection.addEventListener(ClientEvent.CLIENT_REMOVED, removeClientHandler);
			connection.connect(1);
		}
		
		public function disconnect():void
		{
			connection.removeEventListener(ClientEvent.CLIENT_ADDED, 	addClientHandler);
			connection.removeEventListener(ClientEvent.CLIENT_UPDATE, 	updateClientHandler);
			connection.removeEventListener(ClientEvent.CLIENT_REMOVED, 	removeClientHandler);
			connection.removeEventListener(GroupEvent.GROUP_CONNECTED, 	groupConnectedHandler);
			connection.close();
			status 	= DISCONNECT_STATUS;
			_gadget = null;
		}
		
		public function send(message:*):void
		{
			connection.sendMessageToClient(message, _gadget.groupID);
		}
		
		//private function handshake():void
		//{
		//connection.sendMessageToClient(new Ha, _gadget.groupID);
		//}
		
		//public function secureSend(message:ISecureP2PMessage):void
		//{
		//	connection.sendMessageToClient(message, _gadget.groupID, message.type);
		//}
		
		[Bindable(statusChange)]
		public function get isConnected():Boolean
		{
			return _status == INIT_COMPLETE_STATUS;
		}
		
		protected function get status():String
		{
			return _status;
		}
		
		protected function set status(value:String):void
		{
			if( _status != value )
			{
				_status = value;
				dispatchEvent(new Event("statusChange"));
			}
		}
		
		protected function groupConnectedHandler(event:GroupEvent):void
		{
			
		}
		
		protected function removeClientHandler(event:ClientEvent):void
		{
			if( connection.clientsConnected < 2 )
			{
				status 	= DISCONNECT_STATUS;
			}
		}
		
		protected function addClientHandler(event:ClientEvent):void
		{
			if( connection.clientsConnected == 2 )
			{
				status 	= INIT_STATUS;
			}
			else if( connection.clientsConnected > 2 )
			{
				status 	= ERROR_STATUS;
			}
		}
		
		protected function updateClientHandler(event:ClientEvent):void
		{
			if( status 	== INIT_STATUS )
			{
				if( connection.clientsConnected == 2 )
				{
					var client:ClientVO;
					for( var i:uint = 0 ; i < 2; i++ )
					{
						client = connection.clients.getItemAt(i) as ClientVO;
						if( !client.isLocal && client.clientName == "gadget" )
						{
							_gadget = client;
							//handshake();
							break;
						}
					}
					if(_gadget)
					{
						status 	= INIT_COMPLETE_STATUS;
						dispatchEvent(new GadgetEvent(GadgetEvent.GADGET_CONNECTED));
					}
					else
					{
						status 	= ERROR_STATUS;
					}
				}
				else
				{
					status 	= ERROR_STATUS;
				}
			}
		}
	}
}