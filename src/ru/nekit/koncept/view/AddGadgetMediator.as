package ru.nekit.koncept.view
{
	
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ru.nekit.koncept.*;
	import ru.nekit.koncept.model.proxy.GadgetInviteCodeProxy;
	import ru.nekit.koncept.service.gadget.GadgetPublicConnectionService;
	import ru.nekit.koncept.service.gadget.event.GadgetEvent;
	import ru.nekit.koncept.view.views.*;
	
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	
	public class AddGadgetMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "addGadgetView";
		
		private var _view:AddGadgetView = null;
		private var _gadgetPublicConnection:GadgetPublicConnectionService;
		
		public function AddGadgetMediator(viewComponent:Object=null)
		{
			_view = viewComponent as AddGadgetView;
			super(NAME, viewComponent);
			_gadgetPublicConnection = facade.retrieveProxy(GadgetPublicConnectionService.NAME) as GadgetPublicConnectionService;
			_gadgetPublicConnection.addEventListener(GadgetEvent.GADGET_CONNECTED, onConnectHandler);
		}
		
		private function onConnectHandler():void
		{
			_gadgetPublicConnection.disconnect();
			var code:GadgetInviteCodeProxy = facade.retrieveProxy(GadgetInviteCodeProxy.NAME) as GadgetInviteCodeProxy;
			sendNotification(NAMES.GENERATE_QRCODE, code.toMD5());
		}
		
		private function backClickHandler(event:MouseEvent):void
		{
			var transition:SlideViewTransition = new SlideViewTransition;
			transition.mode = SlideViewTransitionMode.PUSH;
			transition.direction = "right";
			_view.navigator.pushView(GadgetView, null, null, transition);
		}
		
		public function get view():AddGadgetView
		{
			return _view;
		}
		
		override public function onRegister():void
		{
			_gadgetPublicConnection.init();
			_view.validateNow();
			_view.back.addEventListener(MouseEvent.CLICK, backClickHandler);
		}
		
		override public function onRemove():void
		{
			_gadgetPublicConnection.disconnect();
			_gadgetPublicConnection = null;
			_view.back.removeEventListener(MouseEvent.CLICK, backClickHandler);
			_view = null;
		}
	}
}