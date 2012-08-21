package ru.nekit.koncept.model.vo.dataType
{
	import flash.errors.IllegalOperationError;
	
	import ru.nekit.koncept.model.util.objectUtil.ObjectUtil;
	import ru.nekit.koncept.model.vo.dataType.interfaces.IURIStruct;
	
	public class URIStruct implements IURIStruct
	{
		
		public var subject:String;
		
		public function get predicate():String
		{
			throw new IllegalOperationError("You must override this function!");
		}
		
		public function get excludeFields():Vector.<String>
		{
			return ObjectUtil.toStringVector("subject");
		}
	}
}