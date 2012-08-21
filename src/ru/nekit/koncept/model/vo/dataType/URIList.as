package ru.nekit.koncept.model.vo.dataType
{
	import flash.errors.IllegalOperationError;
	import ru.nekit.koncept.model.vo.dataType.interfaces.IURIList;
	
	public class URIList implements IURIList
	{
		
		private var _list:Vector.<String>;
		
		public function URIList()
		{
			_list = new Vector.<String>; 
		}
		
		public function add(uri:String):void
		{
			_list.push(uri);
		}
		
		public function addAll(...list):void
		{
			if( list )
			{
				const length:uint =  list.length;
				for( var i:uint = 0 ; i < length; i++)
				{
					add(list[i])	
				}
			}
		}
		
		public function get(index:uint):String
		{
			return _list[index];
		}
		
		public function get list():Vector.<String>
		{
			return _list;
		}
		
		public function get length():uint
		{
			return _list.length;
		}
		
		public function get predicate():String
		{
			throw new IllegalOperationError("You must override this function!!!");
		}
	}
}