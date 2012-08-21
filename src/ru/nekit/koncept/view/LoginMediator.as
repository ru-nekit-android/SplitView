package ru.nekit.koncept.view
{
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ru.nekit.koncept.ExceptionCodes;
	import ru.nekit.koncept.NAMES;
	import ru.nekit.koncept.model.MenuItem;
	import ru.nekit.koncept.model.proxy.UserProxy;
	import ru.nekit.koncept.view.views.*;
	
	import spark.events.IndexChangeEvent;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	
	public class LoginMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "loginView";
		
		private var _view:LoginView = null;
		
		private var _menu:ArrayCollection;
		
		public function LoginMediator(viewComponent:Object=null)
		{
			_view = viewComponent as LoginView;
			super(NAME, viewComponent);
		}
		
		public function get view():LoginView
		{
			return _view;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				NAMES.LOGIN_SUCCESS,
				NAMES.LOGIN_FAULT
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
			var body:Object = notification.getBody();
			var name:String = notification.getName();
			
			switch( name )
			{
				
				case NAMES.LOGIN_SUCCESS:
					
					break;
				
				case NAMES.LOGIN_FAULT:
					
					var transition:SlideViewTransition = new SlideViewTransition;
					var code:uint = Number(body);
					switch( code )
					{
						
						case ExceptionCodes.ACCOUNT_IS_INACTIVE:
							
							_view.navigator.pushView(EmailConfirmationView, null, null, transition);	
							
							break;
						
						case ExceptionCodes.INVALID_LOGIN_OR_PASSWORD:
							
							//нет такого пользователя
							
							break;
						
						case ExceptionCodes.LOGIN_VALIDATION_ERROR:
							
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
			_view.validateNow();
			_view.list.labelField = "label";
			_view.list.dataProvider = menu;
			_view.loginCall.addEventListener(MouseEvent.CLICK, 		loginCallHandler);
			_view.back.addEventListener(MouseEvent.CLICK, 			backClickHandler);
			_view.list.addEventListener(IndexChangeEvent.CHANGE, 	menuHandler);
		}
		
		override public function onRemove():void
		{
			_view.loginCall.removeEventListener(MouseEvent.CLICK, 		loginCallHandler);
			_view.back.removeEventListener(MouseEvent.CLICK, 			backClickHandler);
			_view.list.removeEventListener(IndexChangeEvent.CHANGE, 	menuHandler);
			_view = null;
		}
		
		private function loginCallHandler(evnt:MouseEvent):void
		{
			var user:UserProxy 	= facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			user.login 			= _view.login.text;
			user.password 		= _view.password.text;
			sendNotification(NAMES.LOGIN);
		}
		
		private function backClickHandler(event:MouseEvent = null):void
		{
			var transition:SlideViewTransition =new SlideViewTransition;
			transition.mode = SlideViewTransitionMode.PUSH;
			transition.direction = "right";
			_view.navigator.popView(transition);	
		}
		
		private function registerCallHandler(event:MouseEvent = null):void
		{
			var transition:SlideViewTransition = new SlideViewTransition;
			transition.mode = SlideViewTransitionMode.PUSH;
			transition.direction = "up";
			_view.navigator.pushView(RegistrationView, null, null, transition);	
		}
		
		private function recoverCallHandler(event:MouseEvent = null):void
		{
			var transition:SlideViewTransition = new SlideViewTransition;
			transition.mode = SlideViewTransitionMode.PUSH;
			transition.direction = "up";
			_view.navigator.pushView(RecoverView, null, null, transition);	
		}
		
		private function get menu():ArrayCollection
		{
			if( !_menu )
			{
				_menu = new ArrayCollection;
				_menu.addItem(new MenuItem("Новый?", "register"));
				_menu.addItem(new MenuItem("Забыл?", "recover"));
			}
			return _menu;
		}
		
		private function menuHandler(event:IndexChangeEvent):void
		{
			var action:String = (_view.list.selectedItem as MenuItem).action;
			var transition:SlideViewTransition = new SlideViewTransition;
			switch( action )
			{
				
				case "recover":
					
					recoverCallHandler();
					
					break;
				
				case "register":
					
					registerCallHandler();
					
					break;
				
				default:
					
					break;
			}
		}
	}
}