package ru.nekit.koncept.view
{
	
	import com.esri.ags.events.MapEvent;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.geometry.WebMercatorMapPoint;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import ru.nekit.koncept.model.MenuItem;
	import ru.nekit.koncept.model.proxy.MapInfoProxy;
	import ru.nekit.koncept.model.vo.MapPositionVO;
	import ru.nekit.koncept.view.views.*;
	
	import spark.events.IndexChangeEvent;
	import spark.events.ViewNavigatorEvent;
	import spark.transitions.SlideViewTransition;
	
	public class MapMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "mapView";
		
		private var _view:MapView = null;
		
		public function MapMediator(viewComponent:Object=null)
		{
			_view = viewComponent as MapView;
			super(NAME, viewComponent);
		}
		
		public function get view():MapView
		{
			return _view;
		}
		
		private function get menu():ArrayCollection
		{
			var result:ArrayCollection = new ArrayCollection;
			result.addItem(new MenuItem(" ", "plus", "2circle-plus.png"));
			result.addItem(new MenuItem(" ", "minus", "2circle-minus.png"));
			return result;
		}
		
		private function mapInstrumentsHandler(event:MouseEvent):void
		{
			var action:String = (_view.mapInstruments.selectedItem as MenuItem).action;
			var transition:SlideViewTransition = new SlideViewTransition;
			switch( action )
			{
				
				case "plus":
					
					_view.map.zoomIn();
					
					break;
				
				case "minus":
					
					_view.map.zoomOut();
					
					break;
				
				default:
					
					break;
			}
		}
		
		private function mapComplete(event:MapEvent):void
		{
			var position:MapPositionVO = (facade.retrieveProxy(MapInfoProxy.NAME) as MapInfoProxy).vo.position;
			_view.map.setCenter(position.lat, position.lon, position.level);
		}
		
		override public function onRegister():void
		{
			_view.mapInstruments.labelField = "label";
			_view.mapInstruments.dataProvider = menu;
			_view.mapInstruments.addEventListener(MouseEvent.CLICK, 	mapInstrumentsHandler);
			_view.map.addEventListener(MapEvent.LOAD,  					mapComplete);
			_view.addEventListener(ViewNavigatorEvent.VIEW_DEACTIVATE, 	viewDeactiveHandker);
		}
		
		private function updateMapPosition():void
		{
			var position:MapPositionVO = (facade.retrieveProxy(MapInfoProxy.NAME) as MapInfoProxy).vo.position;
			var a:Point = _view.localToGlobal(new Point(_view.map.x, _view.map.y));
			var center:Point = new Point(a.x + _view.map.width/2, a.y + _view.map.height/2);
			var mapPoint:MapPoint = _view.map.toMapFromStage(center.x, center.y);
			var result:WebMercatorMapPoint = new WebMercatorMapPoint();
			result.x 		= mapPoint.x;
			result.y 		= mapPoint.y;
			position.lat	= result.lat;
			position.lon	= result.lon;
			position.level 	= _view.map.level;
		}
		
		private function viewDeactiveHandker(event:ViewNavigatorEvent):void
		{
			updateMapPosition();
		}
		
		override public function onRemove():void
		{
			_view.mapInstruments.removeEventListener(IndexChangeEvent.CHANGE, mapInstrumentsHandler);
			_view = null;
		}
	}
}