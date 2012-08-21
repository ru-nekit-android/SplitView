package spark.skins
{
	import flash.events.MouseEvent;
	
	import spark.skins.mobile.BeveledActionButtonSkin;
	
	public class mBeveledActionButtonSkin extends BeveledActionButtonSkin
	{
		public function mBeveledActionButtonSkin()
		{
			super();
		}
		
		override public function set currentState(name:String):void
		{
			super.currentState = name;
			alpha = name.indexOf("over") == 0 ? .9 : 1;
		}
	}
}