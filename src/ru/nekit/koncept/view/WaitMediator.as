package ru.nekit.koncept.view
{
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ru.nekit.koncept.view.views.WaitView;
	
	public class WaitMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "waitView";
		
		private var _view:WaitView = null;
		
		public function WaitMediator(viewComponent:Object=null)
		{
			_view = viewComponent as WaitView;
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			var state:String = _view.data as String;
			if( state ){
				_view.currentState = state;
			}
		}
		
		override public function onRemove():void
		{
			_view = null;
		}
	}
}