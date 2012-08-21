package ru.nekit.koncept.controller
{
	
	import com.google.zxing.BarcodeFormat;
	import com.google.zxing.MultiFormatWriter;
	import com.google.zxing.common.ByteMatrix;
	
	import flash.display.BitmapData;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import ru.nekit.koncept.*;
	
	public class GenerateQRCodeCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute(notification:INotification):void
		{
			
			const hLength:uint = 300;
			const wLength:uint = 300;
			var qrEncoder:MultiFormatWriter = new MultiFormatWriter;
			try
			{
				var result:ByteMatrix = (qrEncoder.encode(notification.getBody() as String, BarcodeFormat.QR_CODE, wLength, hLength)) as ByteMatrix;
			}
			catch (e:Error)
			{
				throw new Error('Invalid input string');
				sendNotification(NAMES.GENERATE_QRCODE_FAULT, result);
			}
			var bmd:BitmapData 		= new BitmapData(wLength, hLength, false, 0x808080);
			for (var h:int = 0; h < hLength; h++)
			{
				for (var w:int = 0; w < wLength; w++)
				{
					if (result.get(w, h) == 0)
					{
						bmd.setPixel(w, h, 0);
					}
					else
					{
						bmd.setPixel(w, h, 0xFFFFFF);
					}        
				}
			}
			sendNotification(NAMES.GENERATE_QRCODE_SUCCESS, bmd);
		}
	}
}