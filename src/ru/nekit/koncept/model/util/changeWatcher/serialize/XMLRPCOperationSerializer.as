package ru.nekit.koncept.model.util.changeWatcher.serialize
{
	import ru.nekit.koncept.model.util.changeWatcher.SPOOperationStack;
	import ru.nekit.koncept.model.util.changeWatcher.operation.*;
	
	public class XMLRPCOperationSerializer
	{
		
		public static function serialize(stack:SPOOperationStack):Vector.<XMLRPCOperation>
		{
			var result:Vector.<XMLRPCOperation> = new Vector.<XMLRPCOperation>;
			const length:uint = stack.length;
			for( var i:uint = 0 ; i < length; i++ )
			{
				result.push(new XMLRPCOperation(stack.get(i)));
			}
			return result;
		}
	}
}