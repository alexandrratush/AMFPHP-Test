package event
{
	import flash.events.Event;

	public class ObjectEvent extends Event
	{
		private var _data:Object;

		public function ObjectEvent(type:String, data:Object, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}

		override public function clone():Event
		{
			return new ObjectEvent(type, data, bubbles, cancelable);
		}

		public override function toString():String
		{
			return formatToString("DataObjectEvent", "type", "data", "bubbles", "cancelable", "eventPhase");
		}

		public function get data():Object
		{
			return _data;
		}

	}
}
