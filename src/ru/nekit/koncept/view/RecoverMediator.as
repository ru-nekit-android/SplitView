package ru.nekit.koncept.view
{
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ru.nekit.koncept.view.views.*;
	
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	
	public class RecoverMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "recoverView";
		
		private var _view:RecoverView = null;
		
		public function RecoverMediator(viewComponent:Object=null)
		{
			_view = viewComponent as RecoverView;
			super(NAME, viewComponent);
		}
		
		private function backClickHandler(event:MouseEvent):void
		{
			var transition:SlideViewTransition =new SlideViewTransition;
			transition.mode = SlideViewTransitionMode.PUSH;
			transition.direction = "down";
			_view.navigator.popView(transition);
		}
		
		public function get view():RecoverView
		{
			return _view;
		}
		
		override public function onRegister():void
		{
			_view.back.addEventListener(MouseEvent.CLICK, backClickHandler);
		}
		
		override public function onRemove():void
		{
			_view.back.removeEventListener(MouseEvent.CLICK, backClickHandler);
			_view = null;
		}
	}
}