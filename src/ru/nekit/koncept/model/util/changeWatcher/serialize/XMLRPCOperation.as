package ru.nekit.koncept.model.util.changeWatcher.serialize
{
	import com.ak33m.rpc.xmlrpc.IXMLRPCStruct;
	
	import ru.nekit.koncept.model.util.changeWatcher.operation.SPOOperation;
	
	public class XMLRPCOperation implements IXMLRPCStruct
	{
		
		public var operation:SPOOperation;
		
		public function XMLRPCOperation(operation:SPOOperation)
		{
			this.operation 	= operation;
		}
		
		public function getPropertyData():*
		{
			return { operation : operation.operation, subject: operation.subject, predicate : operation.predicate, object: operation.object };
		}
	}
}