package ru.nekit.koncept.view
{
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ru.nekit.koncept.NAMES;
	import ru.nekit.koncept.model.proxy.EmailConfirmationProxy;
	import ru.nekit.koncept.view.views.*;
	
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	
	public class EmailConfirmationMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "emailConfirmationView";
		
		private var _view:EmailConfirmationView = null;
		
		public function EmailConfirmationMediator(viewComponent:Object=null)
		{
			_view = viewComponent as EmailConfirmationView;
			super(NAME, viewComponent);
		}
		
		public function get view():EmailConfirmationView
		{
			return _view;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				NAMES.EMAIL_CONFIRMATION_SUCCESS,
				NAMES.EMAIL_CONFIRMATION_FAULT
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
			var body:Object = notification.getBody();
			var name:String = notification.getName();
			
			switch( name )
			{
				
				case NAMES.EMAIL_CONFIRMATION_SUCCESS:
					
					break;
				
				case NAMES.EMAIL_CONFIRMATION_FAULT:
					
					//нет такого кода
					
					break;
				
				default:
					break;
				
			}
			
		}
		
		private function backClickHandler(event:MouseEvent):void
		{
			var transition:SlideViewTransition = new SlideViewTransition;
			transition.mode = SlideViewTransitionMode.PUSH;
			transition.direction = "right";
			_view.navigator.popView(transition);
		}
		
		private function confirmationCallHandler(event:MouseEvent):void
		{
			var emailConfirmation:EmailConfirmationProxy = new EmailConfirmationProxy;
			emailConfirmation.code = _view.confirmationCode.text;
			sendNotification(NAMES.EMAIL_CONFIRMATION, emailConfirmation);
		}
		
		override public function onRegister():void
		{
			_view.back.addEventListener(MouseEvent.CLICK, 		backClickHandler);
			_view.confirmationCall.addEventListener(MouseEvent.CLICK, confirmationCallHandler);
		}
		
		override public function onRemove():void
		{
			_view.back.removeEventListener(MouseEvent.CLICK, 		backClickHandler);
			_view.confirmationCall.removeEventListener(MouseEvent.CLICK, confirmationCallHandler);
		}
	}
}