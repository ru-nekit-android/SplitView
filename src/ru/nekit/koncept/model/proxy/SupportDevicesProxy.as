package ru.nekit.koncept.model.proxy
{
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import ru.nekit.koncept.model.vo.SupportDeviceVO;
	
	public class SupportDevicesProxy extends Proxy implements IProxy
	{
		
		public static const NAME:String = "supportDevices";
		
		private var _list:Vector.<SupportDeviceVO>
		
		public function SupportDevicesProxy()
		{
			super(NAME);
			init();
		}
		
		private function init():void
		{
			_list = new Vector.<SupportDeviceVO>;
			_list.push(new SupportDeviceVO(1, "Android", "Android", "?", "?", "http://android"));
			_list.push(new SupportDeviceVO(2, "iOS", "iOs", "?", "?", "http://ios"));
		}
		
		public function get list():Vector.<SupportDeviceVO>
		{
			return _list;
		}
		
		public function get length():uint
		{
			return _list.length;
		}
	}
}