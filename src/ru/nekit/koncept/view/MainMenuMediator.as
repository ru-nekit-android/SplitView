package ru.nekit.koncept.view
{
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ru.nekit.koncept.NAMES;
	import ru.nekit.koncept.model.MenuItem;
	import ru.nekit.koncept.view.views.*;
	
	import spark.events.IndexChangeEvent;
	import spark.events.ViewNavigatorEvent;
	import spark.transitions.SlideViewTransition;
	
	public class MainMenuMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "mainMenuView";
		
		private var _menu:ArrayCollection;
		
		private var _view:MainMenu = null;
		
		public var minimalizeMenuState:Boolean; 
		
		public function MainMenuMediator(viewComponent:Object=null)
		{
			_view = viewComponent as MainMenu;
			super(NAME, viewComponent);
		}
		
		public function get view():MainMenu
		{
			return _view;
		}
		
		private function changeStateMenuCallHandler(event:MouseEvent):void
		{
			minimalizeMenuState = !minimalizeMenuState;
			sendNotification(NAMES.CHANGE_MENU_STATE, minimalizeMenuState);
		}
		
		private function get menu():ArrayCollection
		{
			if( !_menu )
			{
				_menu = new ArrayCollection;
				_menu.addItem(new MenuItem("Я", 		MainViewMediator.ME, 		"user.png"));
				_menu.addItem(new MenuItem("Карта", 	MainViewMediator.MAP,		"map.png"));
				_menu.addItem(new MenuItem("Гаджеты", 	MainViewMediator.GADGET, 	"iphone.png"));
			}
			return _menu;
		}
		
		private function switchView(name:String):void
		{
			const length:uint = _menu.length;
			for( var i:uint = 0; i < length; i++)
			{
				if( (_menu.getItemAt(i) as MenuItem).action == name )
				{
					_view.menu.selectedIndex = i;
					break;
				}
			}
			sendNotification(NAMES.SWITCH_TO_VIEW, name);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
			var body:Object = notification.getBody();
			var transition:SlideViewTransition;
			
		}
		
		override public function onRegister():void
		{
			_view.menu.labelField 			= "label";
			_view.menu.iconField 			= "icon";
			_view.menu.iconRightPosition 	= true;
			_view.menu.dataProvider 		= menu;
			minimalizeMenuState 			= false;
			switchView(MainViewMediator.ME);
			_view.menu.addEventListener(IndexChangeEvent.CHANGE, 		menuHandler);
			_view.menuState.addEventListener(MouseEvent.CLICK, 			changeStateMenuCallHandler);
			_view.addEventListener(ViewNavigatorEvent.VIEW_ACTIVATE, 	viewActiveHandler);
		}
		
		private function menuHandler(event:IndexChangeEvent):void
		{
			var action:String = (_view.menu.selectedItem as MenuItem).action;
			sendNotification(NAMES.SWITCH_TO_VIEW, action);
		}
		
		override public function onRemove():void
		{
			_view.menuState.removeEventListener(MouseEvent.CLICK, 		changeStateMenuCallHandler);
			_view.removeEventListener(ViewNavigatorEvent.VIEW_ACTIVATE, viewActiveHandler);
			_view = null;
		}
		
		private function viewActiveHandler(event:ViewNavigatorEvent):void
		{
			
		}
	}
}