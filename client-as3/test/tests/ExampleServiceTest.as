package tests 
{
	import connection.ServerConnection;
	import event.ObjectEvent;
	import flexunit.framework.Assert;
	import org.flexunit.async.Async;

	[RunWith("org.flexunit.runners.Parameterized")]
	public class ExampleServiceTest 
	{
		public static var data:Array = [ ["test"], ["test2"] ];
		public static var data1:Array = [ [3, 4], [20, 5], [.5, 1.5] ];
		
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
					returnOneParamAsyncHandler,
					2000,
					value
			);
			
			_serverConnection.addEventListener(ServerConnection.RESULT, asyncHandler, false, 0, true);
			_serverConnection.call("ExampleService/returnOneParam", null, null, value);
		}
		
		private function returnOneParamAsyncHandler(e:ObjectEvent, value:Object):void
		{
			Assert.assertTrue(e.data is String);
			Assert.assertEquals(e.data, value);
		}
		
		[Test(async, description = "Return sum", dataProvider="data1")]
		public function returnSumParam(value1:int, value2:int):void
		{
			var asyncHandler:Function = Async.asyncHandler(this,
					returnSumAsyncHandler,
					2000,
					value1 + value2
			);
			
			_serverConnection.addEventListener(ServerConnection.RESULT, asyncHandler, false, 0, true);
			_serverConnection.call("ExampleService/returnSum", null, null, value1, value2);
		}
		
		private function returnSumAsyncHandler(e:ObjectEvent, value:Object):void
		{
			Assert.assertEquals(e.data, value);
		}
		
		[Test(async, description = "Return null")]
		public function returnNull():void
		{
			var asyncHandler:Function = Async.asyncHandler(this,
					returnNullAsyncHandler,
					2000
			);
			
			_serverConnection.addEventListener(ServerConnection.RESULT, asyncHandler, false, 0, true);
			_serverConnection.call("ExampleService/returnNull", null, null);
		}
		
		private function returnNullAsyncHandler(e:ObjectEvent, value:Object):void
		{
			Assert.assertNull(e.data);
		}
		
		[Test(async, description = "Return bla")]
		public function returnBla():void
		{
			var asyncHandler:Function = Async.asyncHandler(this,
					returnBlaAsyncHandler,
					2000
			);
			
			_serverConnection.addEventListener(ServerConnection.RESULT, asyncHandler, false, 0, true);
			_serverConnection.call("ExampleService/returnBla", null, null);
		}
		
		private function returnBlaAsyncHandler(e:ObjectEvent, value:Object):void
		{
			Assert.assertTrue(e.data is String);
			Assert.assertEquals("bla", e.data);
		}
		
		[Test(async, description = "Throw exception from server")]
		public function throwException():void
		{
			var asyncHandler:Function = Async.asyncHandler(this,
					throwExceptionAsyncHandler,
					2000,
					{arg1:"error"}
			);
			
			_serverConnection.addEventListener(ServerConnection.ERROR, asyncHandler, false, 0, true);
			_serverConnection.call("ExampleService/throwException", null, null, "error");
		}
		
		private function throwExceptionAsyncHandler(e:ObjectEvent, value:Object):void
		{
			Assert.assertEquals(e.data.faultString, "test exception " + value.arg1);
			Assert.assertEquals(e.data.faultCode, 123);
		}
		
		[Test(async, description = "Return after one second")]
		public function returnAfterOneSecond():void
		{
			var asyncHandler:Function = Async.asyncHandler(this,
					returnAfterOneSecondAsyncHandler,
					3000
			);
			
			_serverConnection.addEventListener(ServerConnection.RESULT, asyncHandler, false, 0, true);
			_serverConnection.call("ExampleService/returnAfterOneSecond", null, null);
		}
		
		private function returnAfterOneSecondAsyncHandler(e:ObjectEvent, value:Object):void
		{
			Assert.assertEquals(e.data, "slept for 1 second");
		}
		
	}

}