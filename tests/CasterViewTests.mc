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
		return true;		
	}
	
	(:test)
	function TestComputeReturnsZerosWhenNotActive(log) {
		var helper = new CasterViewTestsHelper();
		helper.ValidateComputeReturnsZeros(null, null, null, log);
		helper.ValidateComputeReturnsZeros(0.0, 0.0, 0.0, log);
		helper.ValidateComputeReturnsZeros(1.0, 0.0, 0.0, log);
		helper.ValidateComputeReturnsZeros(0.0, 1.0, 0.0, log);
		helper.ValidateComputeReturnsZeros(0.0, 0.0, 1.0, log);
		return true;		
	}
		
	(:test)
	function TestComputeReturnsResultWhenActive(log) {
		var helper = new CasterViewTestsHelper();		
		helper.ValidateCompute(1.0, 1609.34, 60000.0, "27:49", log);
		helper.ValidateCompute(3.0, 1000.0, 240000.0, "7:23", log);
		helper.ValidateCompute(4.3, 2000, 360800.0, "10:44", log);
		return true;		
	}
}