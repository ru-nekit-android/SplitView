package ru.nekit.koncept.model.vo
{
	
	import ru.nekit.koncept.model.vo.dataType.ImgList;
	import ru.nekit.koncept.model.vo.dataType.MBox;
	
	public class PersonProfileVO 
	{
		
		public var surname:String;
		public var name:String;
		public var birthPlace:String;
		
		public var mbox:MBox = new MBox;
		public var img:ImgList = new ImgList;
		
	}
}