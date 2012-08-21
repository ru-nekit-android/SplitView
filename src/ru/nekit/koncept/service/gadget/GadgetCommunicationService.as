package ru.nekit.koncept.service.gadget
{
	import ru.nekit.p2p.model.vo.ComputerVO;
	import ru.nekit.p2p.model.vo.GadgetVO;
	
	public class GadgetCommunicationService extends GadgetService
	{
		
		public static const NAME:String 					= "gadget_communication";
		
		public function GadgetCommunicationService()
		{
			super(NAME);
		}
		
		public function connectToGadget(computer:ComputerVO, gadget:GadgetVO):void
		{
			if( !isConnected )
			{
				connection.groupName 			= "group::" + 1;//key.toMD5( "::puorg" );
				/*
				connection.publishPasswordSalt  = "_!_poloonezy";
				connection.postPasswordSalt  	= "_!_zivert";
				connection.publishPassword		= key.toMD5(connection.publishPasswordSalt);
				connection.postPassword			= key.toMD5(connection.postPasswordSalt);
				*/
				connect();
			}
		}
	}
}