package ru.nekit.koncept.model.vo
{
	public class MapPositionVO
	{
		
		public var lat:Number;
		public var lon:Number;
		public var level:Number;
		
		public function MapPositionVO(lat:Number, lon:Number, level:Number)
		{
			this.lat = lat;
			this.lon = lon;
			this.level = level;
		}
	}
}