package ru.nekit.koncept.manager.network
{
	
	import flash.net.NetworkInfo;
	import flash.net.NetworkInterface;
	
	public class NetworkInfo
	{
		
		public 	static const NAME:String 		= "networkInfoService";
		private static const WIFI:String 		= "wifi";
		private static const ETHERNET:String 	= "en";
		
		public static function get macAddress():String
		{
			if( flash.net.NetworkInfo.isSupported )
			{
				var wifi:NetworkInterface;
				var ethernet:NetworkInterface;
				var interfacelist:Vector.<NetworkInterface> = flash.net.NetworkInfo.networkInfo.findInterfaces();
				for each( var _interface:NetworkInterface in interfacelist)
				{
					if( _interface.name == WIFI )
					{
						wifi = _interface;
					}
					else if( _interface.name.indexOf(ETHERNET) == 0 )
					{
						if( _interface.hardwareAddress && _interface.hardwareAddress != "" )
						{
							ethernet = _interface;
						}
					}
				}
				if( wifi )
				{
					return wifi.hardwareAddress;
				}
				if( ethernet)
				{
					return ethernet.hardwareAddress;
				}
			}
			return null;
		}
	}
}