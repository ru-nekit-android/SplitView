package ru.nekit.p2p.model
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import ru.nekit.p2p.manager.entity.IEntity;
	import ru.nekit.p2p.model.vo.GadgetVO;
	import ru.nekit.p2p.service.DBService;
	
	public class GadgetListProxy extends Proxy implements IProxy
	{
		
		public static const NAME:String = "gadgetList";
		
		private var _list:Vector.<GadgetVO>;
		private var _db:DBService;
		
		public function GadgetListProxy()
		{
			super(NAME);
			_list	= new Vector.<GadgetVO>;
		}
		
		public function init():void
		{
			_db 	= facade.retrieveProxy(DBService.NAME) as DBService;
			read();
		}
		
		public function get length():uint
		{
			return _list.length;
		}
		
		public function read():void
		{
			var list:Vector.<IEntity> = _db.selectAll(GadgetVO);
			if( this.length )
			{
				_list	= new Vector.<GadgetVO>;
			}
			if( list )
			{
				const length:uint = list.length;
				for( var i:uint = 0 ; i < length; i++)
				{
					_list.push(GadgetVO(list[i]));
				}
			}
		}
		
		public function have(gadget:GadgetVO):Boolean
		{
			var list:Vector.<IEntity> = _db.selectAll(GadgetVO);
			if( list )
			{
				const length:uint = list.length;
				for( var i:uint = 0 ; i < length; i++)
				{
					if( GadgetVO(list[i]).uuid == gadget.uuid )
					{
						return true;
					}
				}
			}
			return false;
		}
		
		public function add(gadget:GadgetVO):void
		{
			_db.save(gadget);
		}
	}
}