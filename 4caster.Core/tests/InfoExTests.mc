using Toybox.Test;
using Toybox.Activity;
using CasterCore.Utils as M;

module CasterCore {
	class InfoExTests {
		(:test)
		function TestNullProps(logger) {
			var info = new Activity.Info();
			info.currentSpeed = null;
			info.elapsedTime = null;
			info.elapsedDistance = null;
			info.timerTime = null;
			
			var obj = new M.InfoEx(info);
			
			Test.assertEqualMessage(obj.GetCurrentSpeed(), 0.0 , "Expected 0.00000 but got " + obj.GetCurrentSpeed());
			Test.assertEqualMessage(obj.GetElapsedTime(), 0.0 , "Expected 0.00000 but got " + obj.GetElapsedTime());
			Test.assertEqualMessage(obj.GetTimerTime(), 0.0 , "Expected 0.00000 but got " + obj.GetTimerTime());
			Test.assertEqualMessage(obj.GetElapsedDistance(), 0.0 , "Expected 0.00000 but got " + obj.GetElapsedDistance());
			return true;		
		}
		
		(:test)
		function TestPropsWithValue(logger) {
			var info = new Activity.Info();
			info.currentSpeed = 1.2;
			info.elapsedTime =  3.4;
			info.elapsedDistance = 5.6;
			info.timerTime = 6.7;
			
			var obj = new M.InfoEx(info);
			
			Test.assertEqualMessage(obj.GetCurrentSpeed(), 1.2 , "Expected 1.20000 but got " + obj.GetCurrentSpeed());		
			Test.assertEqualMessage(obj.GetElapsedTime(), 3.4 , "Expected 3.40000 but got " + obj.GetElapsedTime());
			Test.assertEqualMessage(obj.GetElapsedDistance(), 5.6 , "Expected 5.60000 but got " + obj.GetElapsedDistance());
			Test.assertEqualMessage(obj.GetTimerTime(), 6.7 , "Expected 6.70000 but got " + obj.GetTimerTime());
			return true;		
		}
	}
}