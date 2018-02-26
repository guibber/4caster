using Toybox.Test;
using Toybox.Activity;

class CasterViewTests {
	(:test)
	function TestProps(log) {
		var obj = new CasterView();
		Test.assertEqualMessage(obj.label, "4caster" , "Expected 4caster but got " + obj.label);	
		return true;		
	}
	
	(:test)
	function TestGetDistanceToNextMilestone(log) {
		var helper = new CasterViewTestsHelper();
		helper.ValidateGetDistanceToNextMilestone(0, 1609.34, log);
		helper.ValidateGetDistanceToNextMilestone(1609.34, 1609.34, log);
		helper.ValidateGetDistanceToNextMilestone(1000, 609.34, log);
		helper.ValidateGetDistanceToNextMilestone(2000, 1218.68, log);			
		return true;		
	}
	
	(:test)
	function TestFormatTimeFromSeconds(log) {
		var helper = new CasterViewTestsHelper();
		helper.ValidateFormatTimeFromSeconds(0, "0:00", log);
		helper.ValidateFormatTimeFromSeconds(1, "0:01", log);
		helper.ValidateFormatTimeFromSeconds(59, "0:59", log);
		helper.ValidateFormatTimeFromSeconds(60, "1:00", log);
		helper.ValidateFormatTimeFromSeconds(500, "8:20", log);
		helper.ValidateFormatTimeFromSeconds(1001, "16:41", log);
		helper.ValidateFormatTimeFromSeconds(59.1, "0:59", log);
		helper.ValidateFormatTimeFromSeconds(3661, "1:01:01", log);
		helper.ValidateFormatTimeFromSeconds(82861, "23:01:01", log);
		helper.ValidateFormatTimeFromSeconds(90061, "25:01:01", log);				
		return true;		
	}
	
	(:test)
	function TestGetCurrentOrAverageSpeed(log) {
		var helper = new CasterViewTestsHelper();
		helper.ValidateGetCurrentOrAverageSpeed(0.0, 800.00, 240000.0, 3.333333, log);
		helper.ValidateGetCurrentOrAverageSpeed(4.4, 800.00, 240000.0, 4.4, log);		
		return true;		
	}
	
	(:test)
	function TestCompute(log) {
		var helper = new CasterViewTestsHelper();
		helper.ValidateCompute(null, null, null, "0:00", log);
		helper.ValidateCompute(0.0, 0.0, 0.0, "0:00", log);
		helper.ValidateCompute(1.0, 0.0, 0.0, "0:00", log);
		helper.ValidateCompute(0.0, 1.0, 0.0, "0:00", log);
		helper.ValidateCompute(0.0, 0.0, 1.0, "0:00", log);
		helper.ValidateCompute(0.0, 800.00, 240000.0, "8:02", log);
		helper.ValidateCompute(0.0, 800.00, 241000.0, "8:04", log);
		helper.ValidateCompute(0.0, 800.00, 300000.0, "10:03", log);	
		helper.ValidateCompute(1.0, 1609.34, 60000.0, "27:49", log);
		helper.ValidateCompute(3.0, 1000.0, 240000.0, "7:23", log);
		helper.ValidateCompute(4.3, 2000, 360800.0, "10:44", log);
		return true;		
	}
}