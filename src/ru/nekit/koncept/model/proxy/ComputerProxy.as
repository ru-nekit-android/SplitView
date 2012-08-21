package ru.nekit.koncept.model.proxy
{
	
	import flash.crypto.generateRandomBytes;
	import flash.data.EncryptedLocalStore;
	import flash.utils.ByteArray;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import ru.nekit.koncept.manager.network.NetworkInfo;
	import ru.nekit.koncept.model.vo.ComputerVO;
	
	public class ComputerProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "computerProxy";
		
		private static const DATA_NAME:String = "computer_data";
		
		private var _isFirstStartUp:Boolean = false;
		
		public function ComputerProxy()
		{
			super(NAME);
			data = new ComputerVO;
		}
		
		public function get vo():ComputerVO
		{
			return data as ComputerVO;
		}
		
		private function serialize():ByteArray
		{
			if( isFirstStartUp )
			{
				var idBytes:ByteArray = flash.crypto.generateRandomBytes(16);
				var idString:String = "";
				for( var i:uint = 0 ; i < 16; i++)
				{
					var byte:int = idBytes.readByte();
					if( byte < 0)
					{
						byte += 128;
					}
					idString += byte.toString(36);
				}
				vo.id = idString;
				vo.firstStartUpMacAddress 	= NetworkInfo.macAddress;
				vo.creationDate 			= new Date;
			}
			vo.currentMacAddress 	= NetworkInfo.macAddress;
			vo.lastEnterDate 		= new Date;
			var bytes:ByteArray 	= new ByteArray;
			bytes.writeObject(vo);
			bytes.compress();
			bytes.position 			= 0;
			return bytes;
		}
		
		private function deserialize(value:ByteArray):ComputerVO
		{
			var data:Object = value.readObject();
			for( var item:String in data )
			{
				vo[item] = data[item]; 
			}
			return vo;
		}
		
		private function read():ComputerVO
		{
			var bytes:ByteArray = EncryptedLocalStore.getItem(DATA_NAME);
			if( bytes )
			{
				bytes.uncompress();
				bytes.position = 0;
				return deserialize(bytes);
			}
			else
			{
				_isFirstStartUp = true;
			}
			return null;
		}
		
		public function get isFirstStartUp():Boolean
		{
			return _isFirstStartUp;
		}
		
		public function init():void
		{
			read();
			EncryptedLocalStore.setItem(DATA_NAME, serialize());
		}
		
		public function reset():void
		{
			EncryptedLocalStore.removeItem(DATA_NAME);
		}
	}
}