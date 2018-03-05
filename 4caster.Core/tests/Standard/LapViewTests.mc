using Toybox.Test;
using Toybox.Activity;
using CasterCore.Standard as M;

module CasterCore {
	class LapViewTests {
		(:test)
		function TestGetLabel(log) {
			var actual = new M.LapView(new CasterCore.FakeController(null)).GetLabel();
			Test.assertEqualMessage(actual, "label" , "Expected label but got " + actual);
			return true;		
		}
		
		(:test)
		function TestGetComputeViewString(log) {
			var info = new CasterCore.FakeInfo();
			var obj = new M.LapView(new CasterCore.FakeController(info));
			var actual = obj.GetComputeViewString(info);
			Test.assertEqualMessage(actual, "0:12" , "Expected 0:12 but got " + actual);
			return true;		
		}
	}
}