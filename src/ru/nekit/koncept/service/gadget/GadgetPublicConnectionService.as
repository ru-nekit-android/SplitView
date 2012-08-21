package ru.nekit.koncept.service.gadget
{
	
	public class GadgetPublicConnectionService extends GadgetService
	{
		
		public static const NAME:String 					= "gadget_public_connection";
		
		public function GadgetPublicConnectionService()
		{
			super(NAME);
		}
		
		public function init():void
		{
			if( !isConnected )
			{
				connection.groupName 			= "gadget::public";
				connect();
			}
		}
	}
}