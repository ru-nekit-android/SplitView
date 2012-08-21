package ru.nekit.koncept
{
	import flash.errors.IllegalOperationError;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.patterns.facade.Facade;
	
	import ru.nekit.koncept.controller.*;
	
	public class aSkyCity extends Facade
	{
		
		private static var _instance:aSkyCity;
		private static var _instanceFlag:Boolean;
		
		public static function get instance():aSkyCity
		{
			if( !_instance )
			{
				_instanceFlag 	= true;
				_instance		= new aSkyCity;
				_instanceFlag	= false;
			}
			return _instance;
		}
		
		public function aSkyCity()
		{
			if( _instanceFlag )
			{
				
			}
			else
				throw new IllegalOperationError(null);
		}
		
		public function startup(application:aSkyCityDesktop):void
		{
			sendNotification(NAMES.STARTUP, application);
			/*return;
			var p:PersonProfileProxy = new PersonProfileProxy("nelch");
			var p2:PersonProfileProxy = new PersonProfileProxy();
			var vo:PersonProfileVO = new PersonProfileVO;
			var vo2:PersonProfileVO = new PersonProfileVO;
			
			p.vo = vo;
			p2.vo = vo2;
			
			vo.name = "0I";
			vo.surname = "0I2";
			
			vo.mbox.addAll("mailto:nelch@_inbox.ru", "gnelch@gmail.com", "-gnelch@gmail.com");
			
			vo2.name = "I";
			vo2.surname = "I2";
			vo2.birthPlace = "I3";
			vo2.mbox.addAll("mailto:nelch@inbox.ru", "gnelch@gmail.com", "+gnelch@gmail.com");
			
			vo.img.add(new ImgStruct("1","1.jpg", "old", "old"));
			vo.img.add(new ImgStruct("2", "2.jpg"));
			vo.img.add(new ImgStruct("3", "3.jpg"));
			
			vo2.img.add(new ImgStruct("1","1.jpg", "new", "new"));
			vo2.img.add(new ImgStruct("2", "2.jpg"));
			vo2.img.add(new ImgStruct("4", "4.jpg"));
			
			Person.manageProfile("",  XMLRPCOperationSerializer.serialize(p.compare(p2)), successProfileHandler, faultProfileHandler);*/
		}
		
		private function successProfileHandler(event:ResultEvent, token:Object = null):void
		{
			sendNotification(NAMES.PERSON_SET_PROFILE_SUCCESS, event.result);	
		}
		
		private function faultProfileHandler(event:FaultEvent, token:Object = null):void
		{
			sendNotification(NAMES.PERSON_SET_PROFILE_FAILED, event.fault.faultCode);
		}
		
		override protected function initializeController():void
		{
			super.initializeController();
			registerCommand(NAMES.STARTUP, 								StartUpCommand);
			registerCommand(NAMES.PATH_CHANGE, 							PathChangeCommand);
			registerCommand(NAMES.LOGIN,								LoginCommand);
			registerCommand(NAMES.REGISTRATION,							RegistrationCommand);
			registerCommand(NAMES.EMAIL_CONFIRMATION,					EmailConfirmationCommand);
			registerCommand(NAMES.LOGOUT,								LogoutCommand);
			registerCommand(NAMES.PERSON_GET_PROFILE,					PersonProfileGetCommand);
			registerCommand(NAMES.PERSON_SET_PROFILE,					PersonProfileSetCommand);
			registerCommand(NAMES.GENERATE_QRCODE,						GenerateQRCodeCommand);
			//registerCommand(NAMES.CREATE_GADGET_PUBLIC_CONNECTION,     	CreateGadgetPublicConnectionCommand);
			//registerCommand(NAMES.DESTROY_GADGET_PUBLIC_CONNECTION,     DestroyGadgetPublicConnectionCommand);
		}
	}
}