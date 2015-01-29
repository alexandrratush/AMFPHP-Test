package tests 
{
	import connection.ServerConnection;
	import flexunit.framework.Assert;
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
		}
		
		[After]
		public function tearDown():void
		{
			_serverConnection.close();
			_serverConnection = null;
		}
		
		[Test]
		public function connect():void
		{
			_serverConnection.connect("http://amfphp-test/server/");
		}
		
		[Test]
		public function newTrueTest():void
		{
			var x:int = 2 * 2;
			Assert.assertEquals(x, 4);
		}
		
		[Test]
		public function newFaultTest():void
		{
			var x:int = 2 * 2;
			Assert.assertEquals(x, 3);
		}
		
	}

}