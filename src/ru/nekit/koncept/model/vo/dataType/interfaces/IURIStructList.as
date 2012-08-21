package ru.nekit.koncept.model.vo.dataType.interfaces
{
	import ru.nekit.koncept.model.vo.dataType.URIStruct;

	public interface IURIStructList
	{
		function add(value:URIStruct):void;
		function get(index:uint):URIStruct;
		function remove(value:URIStruct):Boolean;
		function getByURI(uri:String):URIStruct;
		function indexByURI(uri:String):int;
		function get length():uint;
		function get list():Vector.<*>;
		function get isEmpty():Boolean;
		function copy():IURIStructList;
		function removeAt(index:uint):URIStruct;
	}
}