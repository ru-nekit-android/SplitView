package ru.nekit.koncept.model.proxy
{
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class EmailConfirmationProxy extends Proxy implements IProxy
	{
		public var code:String;
		
		public function EmailConfirmationProxy(code:String = null){
			super();
			this.code = code;
		}
	}
}