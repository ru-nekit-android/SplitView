package ru.nekit.koncept.view
{
	
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ru.nekit.koncept.NAMES;
	import ru.nekit.koncept.model.proxy.PersonProfileProxy;
	import ru.nekit.koncept.view.views.*;
	
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	
	public class ProfileMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "profileView";
		
		private var _view:ProfileView = null;
		private var _profile:PersonProfileProxy;
		
		public function ProfileMediator(viewComponent:Object=null)
		{
			_view = viewComponent as ProfileView;
			super(NAME, viewComponent);
		}
		
		public function get view():ProfileView
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
		
		private function profileClickHandler(event:MouseEvent):void
		{
			sendNotification(NAMES.PERSON_SET_PROFILE, _profile);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				NAMES.PERSON_GET_PROFILE_SUCCESS,
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
			var body:Object = notification.getBody();
			var name:String = notification.getName();
			
			switch( name )
			{
				
				case NAMES.PERSON_GET_PROFILE_SUCCESS:
					
					break;
				
				default:
					break;
				
			}
		}
		
		override public function onRegister():void
		{
			sendNotification(NAMES.PERSON_GET_PROFILE);
			_view.back.addEventListener(MouseEvent.CLICK, backClickHandler);
			_view.saveCall.addEventListener(MouseEvent.CLICK, profileClickHandler);
			//_profile = (facade.retrieveProxy(PersonProfileProxy.NAME) as PersonProfileProxy).copy();
		}
		
		override public function onRemove():void
		{
			_view.back.removeEventListener(MouseEvent.CLICK, backClickHandler);
			_view.saveCall.removeEventListener(MouseEvent.CLICK, profileClickHandler);
			_profile = null;
			_view = null;
		}
	}
}