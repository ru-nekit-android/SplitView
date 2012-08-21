package ru.nekit.p2p.service
{
	import flash.data.SQLConnection;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import ru.nekit.p2p.manager.entity.EntityManager;
	import ru.nekit.p2p.manager.entity.IEntity;
	
	public class DBService extends Proxy implements IProxy
	{
		
		public static const NAME:String = "dbService";
		
		private const em:EntityManager 	= EntityManager.instance;
		private var _dbFile:File;
		private var _connection:SQLConnection;	
		
		public function DBService()
		{
			super(NAME);
		}
		
		public function init():void
		{
			_dbFile 			= File.applicationStorageDirectory.resolvePath("p2p.db");
			_connection 		= new SQLConnection();
			_connection.open(_dbFile);
			em.sqlConnection 	= _connection;
		}
		
		public function deleteDatabase():Boolean
		{
			var result:Boolean = false;
			if ( _dbFile ) 
			{				
				if ( _connection && _connection.connected )
					_connection.close(null);	
				var fs:FileStream = new FileStream();
				try 
				{
					fs.open(_dbFile,FileMode.UPDATE);
					while ( fs.bytesAvailable )	
						fs.writeByte(Math.random() * Math.pow(2,32));						
					fs.close();
					_dbFile.deleteFile();				
					result = true;
				}
				catch (e:Error)
				{
					fs.close();
				}				
			}
			return result;
		}
		
		public function save(o:IEntity):Object
		{
			em.save(o);
			return o;
		}
		
		public function remove(o:IEntity):void
		{
			em.remove(o);
		}
		
		public function removeAll(c:Class):void
		{
			em.removeAll(c);
		}
		
		public function select(o:IEntity):IEntity
		{
			return em.select(o);
		}
		
		public function selectAll(c:Class):Vector.<IEntity>
		{
			return em.selectAll(c);
		}
	}
}