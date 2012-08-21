package ru.nekit.koncept.view
{
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ru.nekit.koncept.model.MenuItem;
	import ru.nekit.koncept.view.views.*;
	
	import spark.components.List;
	import spark.events.IndexChangeEvent;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	
	public class GadgetMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "gadgetView";
		
		private var _view:GadgetView = null;
		
		private var _menu:ArrayCollection;
		private var _actionMenu:ArrayCollection;
		
		public function GadgetMediator(viewComponent:Object=null)
		{
			_view = viewComponent as GadgetView;
			super(NAME, viewComponent);
		}
		
		public function get view():GadgetView
		{
			return _view;
		}
		
		private function get menu():ArrayCollection
		{
			if( !_menu )
			{
				_menu = new ArrayCollection;
				/*
				_menu.addItem(new MenuItem("1", "choice"));
				_menu.addItem(new MenuItem("2", "choice"));
				*/
			}
			return _menu;
		}
		
		private function get actionMenu():ArrayCollection
		{
			if( !_actionMenu )
			{
				_actionMenu = new ArrayCollection;
				_actionMenu.addItem(new MenuItem("Добавить", "add"));
				_actionMenu.addItem(new MenuItem("Удалить", "remove"));
			}
			return _actionMenu;
		}
		
		override public function onRegister():void
		{
			_view.gadgetList.dataProvider = menu;
			_view.actionMenu.dataProvider = actionMenu;
			_view.gadgetList.addEventListener(IndexChangeEvent.CHANGE, 	menuHandler);
			_view.actionMenu.addEventListener(IndexChangeEvent.CHANGE, 	menuHandler);
		}
		
		private function menuHandler(event:IndexChangeEvent):void
		{
			var action:String = (List(event.currentTarget).selectedItem as MenuItem).action;
			var transition:SlideViewTransition;
			
			switch( action )
			{
				
				case "choice":
					
					break;
				
				case "add":
					
					transition = new SlideViewTransition;
					transition.mode = SlideViewTransitionMode.PUSH;
					transition.direction = "left";
					_view.navigator.pushView(AddGadgetView, null, null, transition);
					
					break;
				
				case "remove":
					
					break;
				
				default:
					break;
				
			}
		}
		
		override public function onRemove():void
		{
			_view.gadgetList.removeEventListener(IndexChangeEvent.CHANGE, 	menuHandler);
			_view.actionMenu.removeEventListener(IndexChangeEvent.CHANGE, 	menuHandler);
			_view = null;
		}
	}
}