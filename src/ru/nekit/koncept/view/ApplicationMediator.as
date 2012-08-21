package ru.nekit.koncept.view
{
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.utils.Timer;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ru.nekit.koncept.NAMES;
	import ru.nekit.koncept.model.proxy.UserProxy;
	import ru.nekit.koncept.view.views.*;
	
	import spark.components.View;
	import spark.components.ViewNavigator;
	import spark.events.ElementExistenceEvent;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	
	public class ApplicationMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "ApplicationMediator";
		
		private var _view:aSkyCityDesktop = null;
		private var _activeView:View = null;
		private var _activeMenuView:View = null;
		
		public function ApplicationMediator(viewComponent:Object=null)
		{
			_view = viewComponent as aSkyCityDesktop;
			super(NAME, viewComponent);
		}
		
		public function get view():aSkyCityDesktop
		{
			return _view;
		}
		
		public function get activeView():View
		{
			return _activeView;
		}	
		
		public function get navigator():ViewNavigator
		{
			return _view.navigator.getViewNavigatorAt(1) as ViewNavigator;
		}
		
		public function get menuNavigator():ViewNavigator
		{
			return _view.menuNavigator;
		}
		
		public function get mainNavigator():ViewNavigator
		{
			return _view.mainNavigator;
		}
		
		override public function onRegister():void
		{
			_view.addEventListener(Event.ACTIVATE, activeHandler);
			_view.addEventListener(Event.DEACTIVATE, deactiveHandler);
			mainNavigator.addEventListener(ElementExistenceEvent.ELEMENT_ADD, 		addElementHandler);
			mainNavigator.addEventListener(ElementExistenceEvent.ELEMENT_REMOVE, 	removeElementHandler);
			registerViewMediator(mainNavigator.activeView);
		}
		
		private function activeHandler(event:Event):void
		{
			_view.frameRate = 24;
		}
		
		private function deactiveHandler(event:Event):void
		{
			_view.frameRate = 1;
			System.gc();
		}
		
		private function addElementHandler(event:ElementExistenceEvent):void
		{
			registerViewMediator(event.element as View);
		}
		
	/*	private function gcHandler(event:TimerEvent):void
		{
			System.gc();
		}*/
		
		private function removeElementHandler(event:ElementExistenceEvent):void
		{
			removeViewMediator(event.element as View);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				NAMES.STARTUP_COMPLETE,
				NAMES.LOGIN_SUCCESS,
				NAMES.EMAIL_CONFIRMATION_SUCCESS,
				NAMES.GO_WAIT,
				NAMES.SHOW_MENU,
				NAMES.HIDE_MENU,
				NAMES.CHANGE_MENU_STATE,
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
			var body:Object = notification.getBody();
			var transition:SlideViewTransition;
			
			switch( notification.getName() )
			{
				
				case NAMES.STARTUP_COMPLETE:
					break;
				
				case NAMES.LOGIN_SUCCESS:
					
					sendNotification(NAMES.SHOW_MENU);
					var timer:Timer = new Timer(600);
					timer.addEventListener(TimerEvent.TIMER, function handler(event:TimerEvent):void
					{
						transition = new SlideViewTransition;
						transition.mode = SlideViewTransitionMode.PUSH;
						transition.direction = "up";
						navigator.pushView(MainView, null, null, transition);	
						timer.removeEventListener(TimerEvent.TIMER, handler);
						timer.stop();
						timer = null;
					});
					timer.start();
					menuNavigator.visible = true;
					
					break;
				
				case NAMES.EMAIL_CONFIRMATION_SUCCESS:
					
					var user:UserProxy 			= facade.retrieveProxy(UserProxy.NAME) as UserProxy;
					
					if( user.isRestored )
					{
						sendNotification(NAMES.LOGIN);
					}
					else
					{
						transition 					= new SlideViewTransition;
						transition.mode 			= SlideViewTransitionMode.PUSH;
						transition.direction 		= user.isLogged ? "left" : "right";
						navigator.pushView(user.isLogged ? MainView : LoginView, null, null, transition);	
					}
					
					break;
				
				case NAMES.GO_WAIT:
					
					transition 					= new SlideViewTransition;
					transition.mode 			= SlideViewTransitionMode.PUSH;
					transition.direction 		= "right";
					navigator.pushView(WaitView, body, null, transition);
					
					break;
				
				case NAMES.SHOW_MENU:
					
					_view.showMenu.play();
					
					break;
				
				case NAMES.HIDE_MENU:
					
					_view.hideMenu.play();
					
					break;
				
				case NAMES.CHANGE_MENU_STATE:
					
					if( body )
					{
						_view.minimilzeMenu.play();
					}
					else
					{
						_view.showMenu.play();
					}
					
					break;
				
				default:
					break;
				
			}
		}
		
		private function addViewHandler(event:ElementExistenceEvent):void
		{
			registerViewMediator(event.element as View);
		}
		
		private function removeViewHandler(event:ElementExistenceEvent):void
		{
			removeViewMediator(event.element as View);
		}
		
		private function registerMenuViewMediator(view:View):void
		{
			_activeView = view;
			var classType:Class = Object(view).constructor;
			var mediator:IMediator = null;
			
			switch( classType  )
			{
				
				default:
					
					return;
					
					break;
				
			}
			
			if( mediator )
				facade.registerMediator( mediator );
		}
		
		private function registerViewMediator(view:View):void
		{
			
			_activeView = view;
			var classType:Class = Object(view).constructor;
			var mediator:IMediator = null;
			
			switch( classType  )
			{
				
				case StartupView:
					
					mediator = new StartupMediator(view);
					
					break;
				
				case DownloadView:
					
					mediator = new DownloadMediator(view);
					
					break;
				
				case DownloadInstructionView:
					
					mediator = new DownloadInstructionMediator(view);
					
					break;
				
				case LoginView:
					
					mediator = new LoginMediator(view);
					
					break;
				
				case RegistrationView:
					
					mediator = new RegistrationMediator(view);
					
					break;
				
				case RecoverView:
					
					mediator = new RecoverMediator(view);
					
					break;
				
				case MainView:
					
					mediator = new MainViewMediator(view);
					
					break;
				
				case MapView:
					
					mediator = new MapMediator(view);
					
					break;
				
				case GadgetView:
					
					mediator = new GadgetMediator(view);
					
					break;
				
				case  AddGadgetView:
					
					mediator = new AddGadgetMediator(view);
					
					break;
				
				case EmailConfirmationView:
					
					mediator = new EmailConfirmationMediator(view);
					
					break;
				
				case WaitView:
					
					mediator = new WaitMediator(view);
					
					break;
				
				case ProfileView:
					
					mediator = new ProfileMediator(view);
					
					break;
				
				default:
					
					return;
					
					break;
				
			}
			
			if( mediator )
				facade.registerMediator(mediator);
		}
		
		private function removeViewMediator(view:View):void
		{
			var classType:Class = Object(view).constructor;
			var name:String = null;
			switch( classType  )
			{
				
				case StartupView:
					
					name = StartupMediator.NAME;
					
					break;
				
				case DownloadView:
					
					name = DownloadMediator.NAME;
					
					break;
				
				case DownloadInstructionView:
					
					name = DownloadInstructionMediator.NAME;
					
					break;
				
				case LoginView:
					
					name = LoginMediator.NAME;
					
					break;
				
				case RegistrationView:
					
					name = RegistrationMediator.NAME;
					
					break;
				
				case RecoverView:
					
					name = RecoverMediator.NAME
					
					break;
				
				//case MainView:
				
				//name = MainViewMediator.NAME;
				
				//	break;
				
				case MapView:
					
					name = MapMediator.NAME;
					
					break;
				
				case GadgetView:
					
					name = GadgetMediator.NAME;
					
					break;
				
				case AddGadgetView:
					
					name = AddGadgetMediator.NAME;
					
					break;
				
				case EmailConfirmationView:
					
					name = EmailConfirmationMediator.NAME;
					
					break;
				
				case WaitView:
					
					name = WaitMediator.NAME;
					
					break;
				
				case ProfileView:
					
					name = ProfileMediator.NAME;
					
					break;
				
				default:
					
					return;
					
					break;
			}
			
			if( name )
				facade.removeMediator(name);
		}
	}
}