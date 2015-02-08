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
	
	[RunWith("org.flexunit.runners.Parameterized")]
	public class ServerConnectionTest 
	{
		public static var data:Array = [ ["test"], ["test2"] ];
		
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
		
		[Test(async, description = "Return one param from server", dataProvider="data")]
		public function returnOneParam(value:String):void
		{
			var asyncHandler:Function = Async.asyncHandler(this,
					asyncReturnOneParamHandler,
					2000,
					value
			);
			
			_serverConnection.addEventListener(ServerConnection.RESULT, asyncHandler, false, 0, true);
			_serverConnection.call("ExampleService/returnOneParam", null, null, value);
		}
		
		private function asyncReturnOneParamHandler(e:ObjectEvent, value:Object):void
		{
			Assert.assertTrue(e.data is String);
			Assert.assertEquals(e.data, value);
		}
		
	}

}