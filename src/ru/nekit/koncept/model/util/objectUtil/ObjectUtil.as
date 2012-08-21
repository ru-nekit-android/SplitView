package ru.nekit.koncept.model.util.objectUtil
{
	import flash.utils.describeType;
	
	import mx.utils.ObjectProxy;
	import mx.utils.object_proxy;
	
	public class ObjectUtil
	{
		
		public static function toObject(value:Object, excludeFields:Array = null):Object
		{
			var result:Object 				= {};
			var fieldList:Vector.<String> 	= new Vector.<String>;
			var varList:XMLList 			= describeType(value)..variable;
			var variableLength:uint 		= varList.length();
			for(var i:uint = 0; i < variableLength; i++){
				if( !excludeFields || excludeFields.indexOf(varList[i].@name) == -1 )
				{
					fieldList.push(varList[i].@name);
				}
			}
			for each( var field:String in fieldList )
			{
				if( value[field] )
				{
					result[field] = value[field];
				}
			}
			return result;
		}
		
		public static function toStringVector(...list):Vector.<String>
		{
			var result:Vector.<String> = new Vector.<String>;
			const length:uint = list.length;
			for( var i:uint = 0; i < length; i++)
			{
				result.push(list[i].toString());
			}
			return result;
		}
		
		public static function compare(source:Object, destination:Object, excludeFields:Array = null/*, includeFields:Array = null*/):Object
		{
			var result:Object;
			var fieldList:Vector.<String> 	= new Vector.<String>;
			var varList:XMLList 			= describeType(source)..variable;
			var variableLength:uint 		= varList.length();
			var i:uint;
			for( i = 0; i < variableLength; i++){
				if( !excludeFields || excludeFields.indexOf(varList[i].@name) == -1 )
				{
					fieldList.push(varList[i].@name);
				}
			}
			for each( var field:String in fieldList )
			{
				if( source[field] != destination[field])
				{
					if( !result)
					{
						result = {};
					}
					result[field] = destination[field];
				}
			}
			return result;
		}
		
		public static function read(destination:Object, source:Object):void
		{
			if( source is ObjectProxy )
			{
				source = source.object_proxy::object;
			}
			var i:uint = 0;
			var name:String;
			var data:Object;
			for( name in source ){
				data = source[name];
				if( name in destination )
				{
					var types:XMLList = describeType(destination).*;
					var type:String;
					const length:uint = types.length();
					for( i = 0; i < length; i++)
					{
						if( types[i].@name == name)
						{
							type = types[i].@type;
							break;
						}
					}
					if( data is Array && type != "Array" )
					{
						data = (data as Array)[0];
					}
					destination[name] = data;
				}
				else
				{
					//error or dinamic
				}
			}
		};
	}
}