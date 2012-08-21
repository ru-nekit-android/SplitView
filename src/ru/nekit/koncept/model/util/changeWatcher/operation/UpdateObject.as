package ru.nekit.koncept.model.util.changeWatcher.operation
{
	import com.ak33m.rpc.xmlrpc.IXMLRPCStruct;
	
	public class UpdateObject implements IXMLRPCStruct
	{
		
		public var oldValue:*;
		public var newValue:*;
		
		public function UpdateObject(oldValue:*, newValue:*)
		{
			this.oldValue 	= oldValue;
			this.newValue	= newValue;
		}
		
		public function getPropertyData():*
		{
			return {old_value: oldValue, new_value: newValue};
		}
	}
}