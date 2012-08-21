package ru.nekit.koncept.model.util.changeWatcher.operation
{
	public class Operation
	{
	
		public var modelName:String;
		public var methodName:String;
		public var param:*;
		
		public function Operation(modelName:String, methodName:String, param:*)
		{
			this.modelName 	= modelName;
			this.methodName = methodName;
			this.param 		= param;
		}
		
		public function get full():String
		{
			return modelName + "." + methodName;
		}
	}
}