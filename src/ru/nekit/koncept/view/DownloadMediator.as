package ru.nekit.koncept.view
{
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ru.nekit.koncept.model.MenuItem;
	import ru.nekit.koncept.model.proxy.SupportDevicesProxy;
	import ru.nekit.koncept.model.vo.SupportDeviceVO;
	import ru.nekit.koncept.view.views.*;
	
	import spark.events.IndexChangeEvent;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	
	public class DownloadMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "downloadView";
		
		private var _view:DownloadView = null;
		
		private var _menu:ArrayCollection;
		
		public function DownloadMediator(viewComponent:Object=null)
		{
			_view = viewComponent as DownloadView;
			super(NAME, viewComponent);
		}
		
		public function get view():DownloadView
		{
			return _view;
		}
		
		private function backClickHandler(event:MouseEvent):void
		{
			var transition:SlideViewTransition = new SlideViewTransition;
			transition.mode = SlideViewTransitionMode.PUSH;
			transition.direction = "down";
			_view.navigator.popView(transition);
		}
		
		private function get menu():ArrayCollection
		{
			if( !_menu )
			{
				_menu = new ArrayCollection;
				var supportDevices:SupportDevicesProxy = facade.retrieveProxy(SupportDevicesProxy.NAME) as SupportDevicesProxy;
				var length:uint = supportDevices.length;
				for( var i:uint = 0 ; i < length; i++ )
				{
					var item:SupportDeviceVO = supportDevices.list[i];
					_menu.addItem(new MenuItem(item.title, "choice", null, item.message, item));
				}
			}
			return _menu;
		}
		
		override public function onRegister():void
		{
			_view.list.dataProvider = menu;
			_view.list.addEventListener(IndexChangeEvent.CHANGE, 	menuHandler);
			_view.back.addEventListener(MouseEvent.CLICK, 		backClickHandler);
		}
		
		override public function onRemove():void
		{
			_view.back.removeEventListener(MouseEvent.CLICK, 		backClickHandler);
			_view = null;
		}
		
		
		private function menuHandler(event:IndexChangeEvent):void
		{
			var action:String = (_view.list.selectedItem as MenuItem).action;
			var transition:SlideViewTransition;
			
			switch( action )
			{
				
				case "choice":
					
					transition = new SlideViewTransition;
					transition.mode = SlideViewTransitionMode.PUSH;
					transition.direction = "right";
					_view.navigator.pushView(DownloadInstructionView, (_view.list.selectedItem as MenuItem).data);
					
					break;
				
				default:
					break;
				
			}
		}
	}
}