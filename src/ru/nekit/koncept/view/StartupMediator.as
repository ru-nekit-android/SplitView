package ru.nekit.koncept.view
{
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ru.nekit.koncept.model.MenuItem;
	import ru.nekit.koncept.view.views.*;
	
	import spark.events.IndexChangeEvent;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	
	public class StartupMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "homeView";
		
		private var _view:StartupView = null;
		
		public function StartupMediator(viewComponent:Object=null)
		{
			_view = viewComponent as StartupView;
			super(NAME, viewComponent);
		}
		
		public function get view():StartupView
		{
			return _view;
		}
		
		private function get menu():ArrayCollection
		{
			var result:ArrayCollection = new ArrayCollection;
			result.addItem(new MenuItem("Вход", "login"));
			result.addItem(new MenuItem("Скачать", "download"));
			return result;
		}
		
		private function menuHandler(event:IndexChangeEvent):void
		{
			var action:String = (_view.list.selectedItem as MenuItem).action;
			var transition:SlideViewTransition = new SlideViewTransition;
			switch( action )
			{
				
				case "login":
					
					transition.mode = SlideViewTransitionMode.PUSH;
					transition.direction = "left";
					_view.navigator.pushView(LoginView, null, null, transition);	
					
					break;
				
				case "download":
					
					transition.mode = SlideViewTransitionMode.PUSH;
					transition.direction = "up";
					_view.navigator.pushView(DownloadView, null, null, transition);	
					
					break;
				
				default:
					
					break;
			}
		}
		
		override public function onRegister():void
		{
			_view.list.labelField = "label";
			_view.list.dataProvider = menu;
			_view.list.addEventListener(IndexChangeEvent.CHANGE, menuHandler);
		}
		
		override public function onRemove():void
		{
			_view.list.removeEventListener(IndexChangeEvent.CHANGE, menuHandler);
			_view = null;
		}
	}
}