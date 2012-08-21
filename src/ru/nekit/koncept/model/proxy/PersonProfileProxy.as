package ru.nekit.koncept.model.proxy
{
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import ru.nekit.koncept.model.util.changeWatcher.ChangeOperationUtil;
	import ru.nekit.koncept.model.util.changeWatcher.SPOOperationStack;
	import ru.nekit.koncept.model.util.objectUtil.ObjectUtil;
	import ru.nekit.koncept.model.vo.PersonProfileVO;
	
	public class PersonProfileProxy extends Proxy implements IProxy
	{
		
		public static const NAME:String 		= "userProfile";
		public static const NS_PREFIX:String 	= "http://askycity.net/persons/";
		
		public var source:PersonProfileVO;
		public var userName:String;
		
		public function PersonProfileProxy(userName:String = "")
		{
			this.userName = userName;
			super(NAME + userName, new PersonProfileVO);
		}
		
		public function get vo():PersonProfileVO
		{
			return data as PersonProfileVO;
		}
		
		public function set vo(data:PersonProfileVO):void
		{
			this.data = data;
		}
		
		public function readData(data:Object):void
		{
			if( !data )
			{
				vo = new PersonProfileVO;
			}
			if( !source )
			{
				source = new PersonProfileVO;
			}
			ObjectUtil.read(source, data);
			ObjectUtil.read(vo, data);
		}
		
		public function compare(value:PersonProfileProxy):SPOOperationStack
		{
			return ChangeOperationUtil.getChange(NS_PREFIX + userName, vo, vo, value.vo);
		}
	}
}