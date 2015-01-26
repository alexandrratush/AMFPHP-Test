package 
{
	import flash.display.Sprite;
	import org.flexunit.internals.TraceListener;
	import org.flexunit.listeners.CIListener;
	import org.flexunit.runner.FlexUnitCore;
	
	/**
	 * ...
	 * @author alexandrratush
	 */
	public class TestUnitRunner extends Sprite 
	{
		
		public function TestUnitRunner() 
		{
			super();
			
			var flexUnit:FlexUnitCore = new FlexUnitCore();
			flexUnit.addListener(new TraceListener());
			flexUnit.addListener(new CIListener());
			flexUnit.run(TestSuite);
		}
		
	}

}