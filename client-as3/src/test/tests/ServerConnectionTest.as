package test.tests 
{
	import connection.ServerConnection;
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
		
	}

}