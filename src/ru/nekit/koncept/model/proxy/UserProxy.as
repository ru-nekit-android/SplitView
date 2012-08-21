package ru.nekit.koncept.model.proxy
{
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import spark.managers.PersistenceManager;
	
	public class UserProxy extends Proxy implements IProxy
	{
		
		private static var persistance:PersistenceManager;
		public static const NAME:String = "user";
		
		public var login:String;
		public var password:String;
		public var email:String;
		public var token:String;
		
		public function UserProxy()
		{
			super(NAME);
			persistance = new PersistenceManager;
		}
		
		public function logout():void
		{
			clear();
			persistance.clear();
		}
		
		public function get isLogged():Boolean
		{
			return token != null;
		}
		
		public function get isRestored():Boolean
		{
			return login != null && password != null;
		}
		
		public function clear():void
		{
			login 		= null;
			password 	= null;
			email 		= null;
			token 		= null;
		}
		
		public function save():void
		{
			persistance.setProperty("login", login);
			persistance.setProperty("password", password);
			persistance.save();
		}
		
		public function restore():void
		{
			login 		= persistance.getProperty("login") 		as String;
			password 	= persistance.getProperty("password") 	as String;
		}
	}
}