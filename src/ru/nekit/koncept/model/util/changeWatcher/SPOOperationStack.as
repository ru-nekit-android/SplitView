package ru.nekit.koncept.model.util.changeWatcher
{
	import ru.nekit.koncept.model.util.changeWatcher.operation.*;
	
	public class SPOOperationStack
	{
		
		private var stack:Vector.<SPOOperation>;
		
		public function SPOOperationStack(stack:Vector.<SPOOperation> = null)
		{
			this.stack = stack ? stack : new Vector.<SPOOperation>;
		}
		
		public function get isEmpty():Boolean
		{
			return stack.length == 0;
		}
		
		public function get length():uint
		{
			return stack.length;
		}
		
		public function add(operation:SPOOperation):void
		{
			stack.push(operation);
		}
		
		public function get(index:uint):SPOOperation
		{
			return stack[index];
		}
		
		public function getByOperation(operation:SPOOperation):SPOOperation
		{
			const length:uint = this.length;
			for( var i:uint = 0 ; i < length; i++ )
			{
				var op:SPOOperation = stack[i];
				
				if( op.predicate == operation.predicate && op.subject == operation.subject && op.operation == operation.operation )
				{
					return op;
				}
			}
			return null;
		}
	}
}