package ru.nekit.koncept.model.util.changeWatcher.operation
{
	
	public class SPOOperation
	{
		
		public static const UPDATE:String = "update"; 
		public static const REMOVE:String = "remove"; 
		public static const INSERT:String = "insert"; 
		
		public var operation:String;
		public var subject:String;
		public var predicate:String;
		public var object:*;
		public var subjectItem:Object;
		
		public function SPOOperation(operation:String, subject:String, predicate:String, object:*, subjectItem:Object)
		{
			this.operation		= operation;
			this.subject 		= subject;
			this.predicate 		= predicate;
			this.object			= object;
			this.subjectItem 	= subjectItem;
		}
	}
}