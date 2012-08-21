package ru.nekit.koncept.model.vo.dataType
{
	import ru.nekit.koncept.model.vo.dataType.interfaces.IURIStructList;
	
	public class ImgList implements IURIStructList
	{
		
		private var _list:Vector.<ImgStruct>;
		
		public function ImgList()
		{
			_list = new Vector.<ImgStruct>;
		}
		
		public function get modelName():String
		{
			return "img";
		}
		
		public function get(index:uint):URIStruct
		{
			try{
				return _list[index];
			}catch(error:RangeError){	
			}
			return null;
		}
		
		public function copy():IURIStructList
		{
			var result:ImgList = new ImgList;
			result._list = _list.slice(0);
			return result;
		}
		
		public function add(value:URIStruct):void
		{
			_list.push(value)
		}
		
		public function remove(value:URIStruct):Boolean
		{
			var index:int = _list.indexOf(value);
			if( index == -1 )
			{
				return false;
			}
			else
			{
				_list.splice(index, 1);
				return true;
			}
		}
		
		public function getByURI(uri:String):URIStruct
		{
			var index:int = indexByURI(uri);
			if( index == -1 )
			{
				return null;
			}
			return get(index);
		}
		
		public function indexByURI(uri:String):int
		{
			const length:uint = this.length;
			for( var i:uint = 0; i < length; i++ )
			{
				if( _list[i].subject == uri )
				{
					return i;
				}
			}
			return -1;
		}
		
		public function removeAt(index:uint):URIStruct
		{
			try{
				return _list.splice(index, 1)[0];
			}catch( error:Error ){
			}
			return null;
		}
		
		public function get length():uint
		{
			return _list.length;
		}
		
		public function get isEmpty():Boolean
		{
			return _list.length == 0;
		}
		
		public function get list():Vector.<*>{
			return _list as Vector.<*>;
		}	
	}
}