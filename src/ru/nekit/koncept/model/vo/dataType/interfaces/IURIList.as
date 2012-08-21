package ru.nekit.koncept.model.vo.dataType.interfaces
{
	public interface IURIList
	{
		
		function add(uri:String):void;
		function addAll(...list):void;
		function get predicate():String;
		function get(index:uint):String;
		function get list():Vector.<String>;
		function get length():uint;
		
	}
}