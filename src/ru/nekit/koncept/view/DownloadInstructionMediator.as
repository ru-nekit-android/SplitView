package ru.nekit.koncept.view
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ru.nekit.koncept.*;
	import ru.nekit.koncept.model.vo.SupportDeviceVO;
	import ru.nekit.koncept.view.views.*;
	
	import spark.events.ViewNavigatorEvent;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	
	public class DownloadInstructionMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "downloadInstructionView";
		
		private var _view:DownloadInstructionView = null;
		
		private var _supportDevice:SupportDeviceVO;
		
		public function DownloadInstructionMediator(viewComponent:Object=null)
		{
			_view = viewComponent as DownloadInstructionView;
			super(NAME, viewComponent);
		}
		
		public function get view():DownloadInstructionView
		{
			return _view;
		}
		
		private function backClickHandler(event:MouseEvent):void
		{
			var transition:SlideViewTransition = new SlideViewTransition;
			transition.mode = SlideViewTransitionMode.PUSH;
			transition.direction = "right";
			_view.navigator.popView(transition);
		}
		
		
		override public function listNotificationInterests():Array
		{
			return [
				NAMES.GENERATE_QRCODE_SUCCESS
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
			var body:Object = notification.getBody();
			
			switch( notification.getName() )
			{
				
				case NAMES.GENERATE_QRCODE_SUCCESS:
					
					_view.validateNow();
					var bmd:BitmapData 	= body as BitmapData;
					_view.qrCode.width 	= bmd.width;
					_view.qrCode.height = bmd.height;
					_view.qrCode.source = bmd;
					
					break;
				
				default:
					break;
				
			}
		}
		
		override public function onRegister():void
		{
			_supportDevice 	= _view.data as SupportDeviceVO;
			_view.title 	= _supportDevice.title;
			_view.url.text	= _supportDevice.url;
			sendNotification(NAMES.GENERATE_QRCODE, 					_supportDevice.url);
			_view.back.addEventListener(MouseEvent.CLICK, 				backClickHandler);
			_view.addEventListener(ViewNavigatorEvent.VIEW_ACTIVATE, 	viewActriveHandler);
		}
		
		override public function onRemove():void
		{
			_view.back.removeEventListener(MouseEvent.CLICK, 			backClickHandler);
			_view = null;
		}
		
		private function viewActriveHandler(event:ViewNavigatorEvent):void
		{
			
		}
	}
}