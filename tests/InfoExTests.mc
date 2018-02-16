using Toybox.Test;
using Toybox.Activity;

class InfoExTests {
	(:test)
	function TestNullProps(logger) {
		var info = new Activity.Info();
		info.currentSpeed = null;
		info.elapsedTime = null;
		info.elapsedDistance = null;
		
		var obj = new InfoEx(info);
		
		Test.assertEqualMessage(obj.GetCurrentSpeed(), 0.0 , "Expected 0.00000 but got " + obj.GetCurrentSpeed());
		Test.assertEqualMessage(obj.GetElapsedTime(), 0.0 , "Expected 0.00000 but got " + obj.GetElapsedTime());
		Test.assertEqualMessage(obj.GetElapsedDistance(), 0.0 , "Expected 0.00000 but got " + obj.GetElapsedDistance());
		return true;		
	}
	
	(:test)
	function TestPropsWithValue(logger) {
		var info = new Activity.Info();
		info.currentSpeed = 1.2;
		info.elapsedTime =  3.4;
		info.elapsedDistance = 5.6;
		
		var obj = new InfoEx(info);
		
		Test.assertEqualMessage(obj.GetCurrentSpeed(), 1.2 , "Expected 1.20000 but got " + obj.GetCurrentSpeed());		
		Test.assertEqualMessage(obj.GetElapsedTime(), 3.4 , "Expected 3.40000 but got " + obj.GetElapsedTime());
		Test.assertEqualMessage(obj.GetElapsedDistance(), 5.6 , "Expected 5.60000 but got " + obj.GetElapsedDistance());
		return true;		
	}
}