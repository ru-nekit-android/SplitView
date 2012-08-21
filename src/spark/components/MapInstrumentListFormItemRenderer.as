package spark.components
{
	import mx.core.mx_internal;
	
	
	use namespace mx_internal;
	
	/**
	 *  Item render with styles to support a List with rounded corners.
	 *  Adds a content property to optionally display arbitrary UIComponents next
	 *  to the decorator. Allows for "settings-list" pattern on Android as well
	 *  as settings/data-entry-form pattern on iOS.
	 */
	public class MapInstrumentListFormItemRenderer extends ListFormItemRenderer
	{
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if (down)
			{
				iconDisplay.source = iconDisplay.captureBitmapData(true, 0x00ff88);
			}
			else
			{
				//	iconDisplay.transform.colorTransform = new ColorTransform();
			}
			
			labelDisplay.commitStyles();
		}
	}
}