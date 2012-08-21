package ru.nekit.koncept.model.util.changeWatcher
{
	import flash.utils.describeType;
	
	import ru.nekit.koncept.model.*;
	import ru.nekit.koncept.model.util.changeWatcher.operation.*;
	import ru.nekit.koncept.model.vo.dataType.*;
	import ru.nekit.koncept.model.vo.dataType.interfaces.IURIList;
	import ru.nekit.koncept.model.vo.dataType.interfaces.IURIStructList;
	
	public class ChangeOperationUtil
	{
		
		public static function getChange(subject:String, subjectItem:Object, source:Object, destination:Object):SPOOperationStack
		{
			var result:SPOOperationStack 	= new SPOOperationStack;
			var input:SPOOperationStack 	= new SPOOperationStack;
			getChangeInternal(subject, subjectItem, source, destination, input);
			var map:Array = [];
			var length:uint = input.length;
			var i:uint = 0;
			for( ; i < length; i++ )
			{
				var operation:SPOOperation = input.get(i);
				var search:SPOOperation = result.getByOperation(operation);
				if( !search )
				{
					search = new SPOOperation(operation.operation, operation.subject, operation.predicate, null, subjectItem);
					search.object = [];
					result.add(search);
				}
				search.object.push(operation.object);
			}
			return result;
		}
		
		private static function getChangeInternal(subject:String, subjectItem:Object, source:Object, destination:Object, changeStack:SPOOperationStack, excludeFields:Vector.<String> = null ):void
		{
			var varList:XMLList 				= describeType( source ? source : destination )..variable;
			const length:uint 					= varList.length();
			for( var i:uint = 0; i < length; i++)
			{
				var name:String = varList[i].@name;
				if( !excludeFields || excludeFields.indexOf( name ) == -1 )
				{
					compareBy(subject, subjectItem, name, source, destination, changeStack);
				}
			}
		}
		
		private static function compareBy(subject:String, subjectItem:Object, predicate:String, source:Object, destination:Object, changeStack:SPOOperationStack):void
		{
			var newValue:* = destination ? destination[predicate] : null;
			var oldValue:* = source ? source[predicate] : null;	
			var i:uint;
			if( oldValue is IURIStructList || newValue is IURIStructList )
			{
				var uriStruct:URIStruct;
				var sourceURIStructList:IURIStructList		= oldValue as IURIStructList;
				var destinationURIStructList:IURIStructList = newValue as IURIStructList;
				if( sourceURIStructList == null || sourceURIStructList.isEmpty )
				{
					const destinationURIStructListLength:uint = destinationURIStructList.length;
					for( i = 0 ; i < destinationURIStructListLength; i++ )
					{
						uriStruct = destinationURIStructList.get(i);
						changeStack.add(new SPOOperation( 
							SPOOperation.INSERT,
							subject, 
							uriStruct.predicate, 
							uriStruct.subject,
							subjectItem
						));
						getChangeInternal(uriStruct.subject, uriStruct, null, uriStruct, changeStack, uriStruct.excludeFields);
					}
				}
				else if( destinationURIStructList == null || destinationURIStructList.isEmpty )
				{
					const sourceURIListLength:uint = sourceURIStructList.length;
					for( i = 0 ; i < sourceURIListLength; i++ )
					{
						uriStruct = sourceURIStructList.get(i);
						changeStack.add(new SPOOperation(
							SPOOperation.REMOVE,
							subject, 
							uriStruct.predicate, 
							uriStruct.subject,
							subjectItem
						));
					}
				}
				else
				{
					var pair:Array = [];
					var sourceURIStructListCopy:IURIStructList 		= sourceURIStructList.copy();
					var destinationURIStructListCopy:IURIStructList = destinationURIStructList.copy();
					var destinationURIStructListCopyLength:uint 	= destinationURIStructListCopy.length;
					for( i = 0 ; i < destinationURIStructListCopyLength; i++ )
					{
						if( destinationURIStructListCopy.get(i).subject )
						{
							uriStruct = destinationURIStructListCopy.get(i);
							var search:int = sourceURIStructListCopy.indexByURI(uriStruct.subject);
							if( search != -1 )
							{
								pair.push({source:sourceURIStructListCopy.get(search), destination: uriStruct });
								sourceURIStructListCopy.removeAt(search);
								destinationURIStructListCopy.removeAt(i);
								destinationURIStructListCopyLength--;
								i--;
							}
						}
						else
						{
							uriStruct = destinationURIStructList.get(i);
							changeStack.add(new SPOOperation( 
								SPOOperation.INSERT,
								subject, 
								uriStruct.predicate, 
								uriStruct.subject,
								subjectItem
							));
							getChangeInternal(uriStruct.subject, subjectItem, null, uriStruct, changeStack, uriStruct.excludeFields);
							destinationURIStructListCopy.removeAt(i);
							destinationURIStructListCopyLength--;
							i--;
						}
					}
					var sourceURIListCopyLength:uint = sourceURIStructListCopy.length;
					for( i = 0 ; i < sourceURIListCopyLength; i++ )
					{
						uriStruct = sourceURIStructListCopy.get(i);
						changeStack.add(new SPOOperation( 
							SPOOperation.REMOVE,
							subject,
							uriStruct.predicate, 
							uriStruct.subject,
							subjectItem
						));
					}
					destinationURIStructListCopyLength 	= destinationURIStructListCopy.length;
					for( i = 0 ; i < destinationURIStructListCopyLength; i++ )
					{
						uriStruct = destinationURIStructListCopy.get(i);
						changeStack.add(new SPOOperation( 
							SPOOperation.INSERT,
							subject, 
							uriStruct.predicate, 
							uriStruct.subject,
							subjectItem
						));
						getChangeInternal(uriStruct.subject, uriStruct, null, uriStruct, changeStack, uriStruct.excludeFields);
					}
					
					const pairLength:uint = pair.length;
					for( i = 0 ; i < pairLength; i++ )
					{
						uriStruct = pair[i].source;
						getChangeInternal(uriStruct.subject, uriStruct, pair[i].source, pair[i].destination, changeStack);
					}
				}	
			}
			else if( oldValue is IURIList || newValue is IURIList )
			{
				
				var sourceURIList:IURIList 			= oldValue as IURIList;
				var destinationURIList:IURIList 	= newValue as IURIList;
				
				var destinationList:Vector.<String> = destinationURIList.list.filter(function(element:String, index:uint, list:Vector.<String>):Boolean {
					return list.indexOf(element) == index;
				});
				var resultList:Vector.<String>		= sourceURIList.list.concat(destinationList);
				resultList = resultList.filter(function(element:String, index:uint, list:Vector.<String>):Boolean {
					return destinationList.indexOf(element) == -1 || sourceURIList.list.indexOf(element) == -1 ;
				});
				const resultLength:uint 			= resultList.length;
				const sourceLength:uint 			= sourceURIList.length;
				const destinationLength:uint 		= destinationList.length;
				var operationInsertList:Vector.<SPOOperation> 	= new Vector.<SPOOperation>;
				var operationRemoveList:Vector.<SPOOperation>  = new Vector.<SPOOperation>;
				var index:int;
				for( i = 0 ; i < resultLength; i++ )
				{
					index = destinationList.indexOf( resultList[i] );
					if( index != -1 )
					{
						operationInsertList.push(new SPOOperation(SPOOperation.INSERT, subject, sourceURIList.predicate, resultList[i], subjectItem));
					}
					index = sourceURIList.list.indexOf( resultList[i] );
					if( index != -1 )
					{
						operationRemoveList.push(new SPOOperation(SPOOperation.REMOVE, subject, sourceURIList.predicate, resultList[i], subjectItem));
					}
				}	
				const operationInsertListLength:uint 	= operationInsertList.length;
				const operationRemoveListLength:uint 	= operationRemoveList.length;
				const length:uint						= Math.min(operationInsertListLength, operationRemoveListLength);
				for( i = 0 ; i < length; i++ )
				{
					changeStack.add(new SPOOperation(SPOOperation.UPDATE, subject, sourceURIList.predicate, new UpdateObject(operationRemoveList[i].object, operationInsertList[i].object), subjectItem ));
				}
				if( operationInsertListLength != operationRemoveListLength )
				{
					const overList:Vector.<SPOOperation> 	= operationInsertListLength >= operationRemoveListLength ? operationInsertList : operationRemoveList;
					const overLength:uint 				= overList.length;
					if( operationInsertListLength > operationRemoveListLength )
					{
						for( i = length; i < overLength; i++ )
						{
							changeStack.add(operationInsertList[i]);
						}
					}
					else
					{ 
						for( i = length; i < overLength; i++ )
						{
							changeStack.add(operationRemoveList[i]);
						}
					}
				}
			}
			else if( oldValue is String || newValue is String )
			{
				if( oldValue == null && newValue != null )
				{
					changeStack.add(new SPOOperation(SPOOperation.INSERT, subject, predicate, newValue, subjectItem));
				}
				else if( oldValue != null && newValue == null )
				{
					changeStack.add(new SPOOperation(SPOOperation.REMOVE, subject, predicate, null, subjectItem));
				}
				else if( oldValue != null && newValue != null )
				{
					if( oldValue != newValue )
					{
						changeStack.add(new SPOOperation(SPOOperation.UPDATE, subject, predicate, new UpdateObject(oldValue, newValue), subjectItem));
					}
				}
			}
		}
	}
}