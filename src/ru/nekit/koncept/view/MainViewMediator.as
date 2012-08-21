package ru.nekit.koncept.view
{
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ru.nekit.koncept.NAMES;
	import ru.nekit.koncept.view.views.*;
	
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	
	public class MainViewMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String 	= "mainView";
		public static const MAP:String  	= "map";
		public static const ME:String  		= "me";
		public static const GADGET:String  	= "gadget";
		
		private var _view:MainView = null;
		
		public function MainViewMediator(viewComponent:Object=null)
		{
			_view = viewComponent as MainView;
			super(NAME, viewComponent);
		}
		
		public function get view():MainView
		{
			return _view;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				NAMES.SWITCH_TO_VIEW
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
			var body:Object = notification.getBody();
			var transition:SlideViewTransition = new SlideViewTransition;
			
			switch( notification.getName() )
			{
				
				case NAMES.SWITCH_TO_VIEW:
					
					transition.mode 					= SlideViewTransitionMode.PUSH;
					transition.direction 				= "down";
					var view:Class = viewByName(body as String);
					if( view )
					{
						//_view.view.pushView(view, null, null, transition);
						(facade.retrieveMediator(ApplicationMediator.NAME) as ApplicationMediator).mainNavigator.pushView(view, null, null, transition);
					}
					
					break;
				
				default:
					
					break;
				
			}
		}
		
		private function viewByName(name:String):Class
		{
			
			switch( name )
			{
				
				case MAP:
					
					return MapView;
					
				case ME:
					
					return MeView;
					
				case GADGET:
					
					return GadgetView;
					
				default:
					//throw new Error("Unknown name");
			}
			return null;
		}
		
		private function exitClickHandler(event:MouseEvent):void
		{
			sendNotification(NAMES.LOGOUT);
			var timer:Timer = new Timer(600);
			timer.addEventListener(TimerEvent.TIMER, function handler(event:TimerEvent):void
			{
				var transition:SlideViewTransition 	= new SlideViewTransition;
				transition.mode 					= SlideViewTransitionMode.PUSH;
				transition.direction 				= "down";
				_view.navigator.pushView(LoginView, null, null, transition);
				timer.removeEventListener(TimerEvent.TIMER, handler);
				timer.stop();
				timer = null;
			});
			timer.start();
			sendNotification(NAMES.HIDE_MENU);	
		}
		
		private function profileClickHandler(event:MouseEvent):void
		{
			var transition:SlideViewTransition 	= new SlideViewTransition;
			transition.mode 					= SlideViewTransitionMode.PUSH;
			transition.direction 				= "up";
			_view.navigator.pushView(ProfileView, null, null, transition);	
		}
		
		override public function onRegister():void
		{
			//_view.exitCall.addEventListener(MouseEvent.CLICK, exitClickHandler);
			//_view.profileCall.addEventListener(MouseEvent.CLICK, profileClickHandler);
			facade.registerMediator(new MainMenuMediator((facade.retrieveMediator(ApplicationMediator.NAME) as ApplicationMediator).menuNavigator .activeView));
		}
		
		override public function onRemove():void
		{
			//	_view.exitCall.removeEventListener(MouseEvent.CLICK, exitClickHandler);
			//	_view.profileCall.removeEventListener(MouseEvent.CLICK, profileClickHandler);
			_view = null;
		}
	}
}