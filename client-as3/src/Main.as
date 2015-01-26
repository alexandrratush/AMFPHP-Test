package 
{
	import connection.ServerConnection;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author alexandrratush
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var serverConnection:ServerConnection = new ServerConnection();
			serverConnection.connect("http://amfphp-test/server/", true);
			serverConnection.call("ExampleService/returnOneParam", null, null, "qwerty");
		}
		
	}
	
}