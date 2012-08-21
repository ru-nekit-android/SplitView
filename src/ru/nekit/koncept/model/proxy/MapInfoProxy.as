package ru.nekit.koncept.model.proxy
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import ru.nekit.koncept.model.vo.MapInfoVO;
	import ru.nekit.koncept.model.vo.MapPositionVO;
	
	public class MapInfoProxy extends Proxy implements IProxy
	{
		
		public static const NAME:String = "map";
		
		public function MapInfoProxy()
		{
			super(NAME, new MapInfoVO);
			vo.position = new MapPositionVO( 43.119, 131.89, 12);
		}
		
		public function get vo():MapInfoVO
		{
			return data as MapInfoVO;
		}
	}
}