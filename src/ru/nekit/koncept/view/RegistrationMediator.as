package ru.nekit.koncept.view
{
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ru.nekit.koncept.ExceptionCodes;
	import ru.nekit.koncept.NAMES;
	import ru.nekit.koncept.model.proxy.UserProxy;
	import ru.nekit.koncept.view.views.*;
	
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	
	public class RegistrationMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "registerView";
		
		private var _view:RegistrationView = null;
		
		public function RegistrationMediator(viewComponent:Object=null)
		{
			_view = viewComponent as RegistrationView;
			super(NAME, viewComponent);
		}
		
		public function get view():RegistrationView
		{
			return _view;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				NAMES.REGISTRATION_SUCCESS,
				NAMES.REGISTRATION_FAULT
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
			var body:Object = notification.getBody();
			var name:String = notification.getName();
			
			switch( name )
			{
				
				case NAMES.REGISTRATION_SUCCESS:
					
					var transition:SlideViewTransition = new SlideViewTransition;
					transition.mode = SlideViewTransitionMode.PUSH;
					transition.direction = "left";
					_view.navigator.pushView(EmailConfirmationView, null, null, transition);	
					
					break;
				
				case NAMES.REGISTRATION_FAULT:
					
					var code:uint = Number(body);
					switch( code )
					{
						
						case ExceptionCodes.LOGIN_IS_EXIST:
							
							//такой логин занят
							
							break;
						
						case ExceptionCodes.EMAIL_IS_EXIST:
							
							//такая почта занята
							
							break;
						
						case ExceptionCodes.REGISTRATION_VALIDATION_ERROR:
							
							//ошибки валидации
							
							break;
						
						default:
							break;
						
					}
					
					break;
				
				default:
					break;
				
			}
			
		}
		
		override public function onRegister():void
		{
			_view.registrationCall.addEventListener(MouseEvent.CLICK, 	registrationCallHandler);
			_view.back.addEventListener(MouseEvent.CLICK, 		backClickHandler);
		}
		
		override public function onRemove():void
		{
			_view.removeEventListener(MouseEvent.CLICK, 		registrationCallHandler);
			_view.back.removeEventListener(MouseEvent.CLICK, 	backClickHandler);
			_view = null;
		}
		
		private function backClickHandler(event:MouseEvent):void
		{
			var transition:SlideViewTransition =new SlideViewTransition;
			transition.mode = SlideViewTransitionMode.PUSH;
			transition.direction = "down";
			_view.navigator.popView(transition);	
		}
		
		private function registrationCallHandler(evnt:MouseEvent):void
		{
			var user:UserProxy 	= facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			user.login 			= _view.login.text;
			user.password 		= _view.password.text;
			user.email			= _view.email_prefix.text;// + "@" + _view.email_sufix.text;
			sendNotification(NAMES.REGISTRATION);
			
		}
	}
}