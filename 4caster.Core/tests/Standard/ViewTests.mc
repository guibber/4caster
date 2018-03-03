using Toybox.Test;
using Toybox.Activity;
using CasterCore.Standard as M;

module CasterCore {
	class FakeInfo {
		function hashCode() {
			return 1;
		}
	}
	
	class FakeController {
		var mExpectedInfo = null;
		
		function initialize(expectedInfo) {
			mExpectedInfo = expectedInfo;
		}
		
		function GetLabel() {
			return "label";
		}
		
		function CalculateTotalSecondsAtNextMilestone(info) {
			Test.assertEqualMessage(info, mExpectedInfo, "Invalid info object passed to method CalculateTotalSecondsAtNextMilestone");
			return 123;
		}
	}
	
	function ValidateFormatTimeFromSeconds(seconds, expected, log) {
		log.debug("ValidateFormatTimeFromSeconds seconds = " + seconds + " expected = " + expected);
		var obj = new M.View(null);
		var actual = obj.FormatTimeFromSeconds(seconds);
		Test.assertEqualMessage(actual, expected, "Expected " + expected + " but got " + actual);	
		return true;		
	}
	
	class ViewTests {
		(:test)
		function TestGetLabel(log) {
			var actual = new M.View(new CasterCore.FakeController(null)).GetLabel();
			Test.assertEqualMessage(actual, "label" , "Expected label but got " + actual);
			return true;		
		}
		
		(:test)
		function TestGetComputeViewString(log) {
			var info = new CasterCore.FakeInfo();
			var obj = new M.View(new CasterCore.FakeController(info));
			var actual = obj.GetComputeViewString(info);
			Test.assertEqualMessage(actual, "2:03" , "Expected 2:03 but got " + actual);
			return true;		
		}
		
		(:test)
		function TestFormatTimeFromSeconds(log) {
			CasterCore.ValidateFormatTimeFromSeconds(0, "0:00", log);
			CasterCore.ValidateFormatTimeFromSeconds(1, "0:01", log);
			CasterCore.ValidateFormatTimeFromSeconds(59, "0:59", log);
			CasterCore.ValidateFormatTimeFromSeconds(60, "1:00", log);
			CasterCore.ValidateFormatTimeFromSeconds(500, "8:20", log);
			CasterCore.ValidateFormatTimeFromSeconds(1001, "16:41", log);
			CasterCore.ValidateFormatTimeFromSeconds(59.1, "0:59", log);
			CasterCore.ValidateFormatTimeFromSeconds(3661, "1:01:01", log);
			CasterCore.ValidateFormatTimeFromSeconds(82861, "23:01:01", log);
			CasterCore.ValidateFormatTimeFromSeconds(90061, "25:01:01", log);				
			return true;		
		}
	}
}