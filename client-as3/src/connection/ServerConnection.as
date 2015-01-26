package connection
{
	import event.ObjectEvent;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;

	/**
	 * ...
	 * @author alexandrratush
	 */
	public class ServerConnection extends EventDispatcher
	{
		public static const RESULT:String = "result";
		public static const ERROR:String = "error";

		private var _gateway:String;
		private var _debugMode:Boolean;
		private var _logger:Function;
		private var _nc:NetConnection;

		public function ServerConnection()
		{
			_logger = trace;
		}
		
		public function connect(gateway:String, debugMode:Boolean = false):void
		{
			_gateway = gateway;
			_debugMode = debugMode;
			
			close();
			
			try
			{
				_nc = new NetConnection();
				_nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				_nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				_nc.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				_nc.connect(_gateway);
			}
			catch (e:Error)
			{
				log("ServerConnection | error connect " + e.message);
			}		
		}
		
		public function call(method:String, resultCallback:Function, errorCallback:Function, ...args):void
		{
			var resultCallback:Function = (resultCallback != null) ? resultCallback : onResult;
			var faultCallback:Function = (errorCallback != null) ? errorCallback : onError;
			var responder:Responder = new Responder(resultCallback, faultCallback);
			var argsToApply:Array = [method, responder].concat(args);
			
			log("ServerConnection | call " + argsToApply);
			
			try
			{
				_nc.call.apply(null, argsToApply);
			}
			catch (e:Error)
			{
				log("ServerConnection | error call " + e.message);
			}
		}

		public function close():void
		{
			if (_nc != null)
			{
				_nc.close();
				_nc.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				_nc.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				_nc.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				_nc = null;
			}
		}

		private function netStatusHandler(e:NetStatusEvent):void
		{
			log("ServerConnection | NetStatusEvent " + e.info.code);
			dispatchEvent(e);
		}

		private function securityErrorHandler(e:SecurityErrorEvent):void
		{
			log("ServerConnection | SecurityError " + e.text);
			dispatchEvent(e);
		}

		private function ioErrorHandler(e:IOErrorEvent):void
		{
			log("ServerConnection | IOErrorEvent " + e.text);
			dispatchEvent(e);
		}

		private function onResult(data:Object):void
		{
			log("ServerConnection | onResult " + data);
			dispatchEvent(new ObjectEvent(RESULT, data));
		}

		private function onError(data:Object):void
		{
			log("ServerConnection | error " + data.faultString + " | " + "statusCode " + data.faultCode);
			dispatchEvent(new ObjectEvent(ERROR, data));
		}

		private function log(value:*):void
		{
			if (_debugMode)
			{
				_logger.call(null, value);
			}
		}

		public function set logger(value:Function):void
		{
			if (value == null) return;
			_logger = value;
		}

		public function get gateway():String
		{
			return _gateway;
		}
	}

}