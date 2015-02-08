package tests 
{
	import connection.ServerConnection;
	import event.ObjectEvent;
	import flexunit.framework.Assert;
	import org.flexunit.async.Async;
	/**
	 * ...
	 * @author alexandrratush
	 */
	public class ServerConnectionTest 
	{
		private var _serverConnection:ServerConnection;
		
		[Before]
		public function setUp():void
		{
			_serverConnection = new ServerConnection();
			_serverConnection.connect(TestConfig.SERVER_GATEWAY);
		}
		
		[After]
		public function tearDown():void
		{
			_serverConnection.close();
			_serverConnection = null;
		}
		
		[Test(async, description="Return one param from server")]
		public function returnOneParam():void
		{
			var asyncHandler:Function = Async.asyncHandler(this,
					asyncEventHandler,
					2000,
					null,
					handleTimeout
			);
			
			_serverConnection.addEventListener(ServerConnection.RESULT, asyncHandler, false, 0, true);
			_serverConnection.call("ExampleService/returnOneParam", null, null, "qwerty");
		}
		
		private function asyncEventHandler(e:ObjectEvent, passThroughData:Object):void
		{
			Assert.assertTrue(e.data is String);
			Assert.assertEquals("qwerty", e.data);
		}

		private function handleTimeout(passThroughData:Object):void
		{
			Assert.fail("Timeout reached before event");
		}
		
	}

}