package ru.nekit.koncept.model.proxy
{
	
	import com.adobe.crypto.MD5;
	
	import flash.crypto.generateRandomBytes;
	import flash.utils.ByteArray;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import ru.nekit.koncept.model.vo.GadgetInviteCodeVO;
	
	public class GadgetInviteCodeProxy extends Proxy implements IProxy
	{
		
		public static const NAME:String = "gadget_invite_code";
		
		public function GadgetInviteCodeProxy()
		{
			super(NAME);
		}
		
		public function get vo():GadgetInviteCodeVO
		{
			return data as GadgetInviteCodeVO;
		}
		
		public function generate():GadgetInviteCodeVO
		{
			var kb:ByteArray = flash.crypto.generateRandomBytes(30);
			kb.position = 0;
			var a:uint 	= kb.readByte();
			kb.position = 1 + a%9;
			var b:uint 	= kb.readByte();
			kb.position = 11 + b%9;
			var c:uint 	= kb.readByte();
			kb.position = 21 + c%9;
			var d:uint 	= kb.readByte();
			data = new GadgetInviteCodeVO(a%9, b%9, c%9, d%9);
			return vo;
		}
		
		public function toString():String
		{
			return vo.a + "" + vo.b + "" + vo.c + "" + vo.d;
		}
		
		public function toMD5(salt:String = null):String
		{
			var bytes:ByteArray = new ByteArray;
			bytes.writeInt(vo.a);
			bytes.writeUTF(vo.b.toString(16));
			bytes.writeUTF(vo.c.toString(8));
			bytes.writeUTF(vo.d.toString(32));
			bytes.position = 0;
			bytes.compress();
			var result:String = MD5.hashBinary( bytes );
			return salt ? MD5.hash(salt + result + salt) : result;
		}
	}
}