package ru.nekit.koncept.model.vo
{
	import ru.nekit.koncept.manager.entity.IEntity;
	
	[Table("gadgets")]
	public class GadgetVO implements IEntity
	{
		
		[Id]
		public var id:uint;
		public var uuid:String;
		public var os:String;
		public var model:String;
		
	}
}