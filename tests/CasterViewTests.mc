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
	function TestComputeReturnsZerosWhenNotActive(log) {
		var helper = new CasterViewTestsHelper();
		helper.ValidateReturnsZeros(null, null, null, log);
		helper.ValidateReturnsZeros(0.0, 0.0, 0.0, log);
		helper.ValidateReturnsZeros(1.0, 0.0, 0.0, log);
		helper.ValidateReturnsZeros(0.0, 1.0, 0.0, log);
		helper.ValidateReturnsZeros(0.0, 0.0, 1.0, log);
		return true;		
	}
		
	(:test)
	function TestComputeReturnsResultWhenActive(log) {
		var helper = new CasterViewTestsHelper();		
		var obj = new CasterView();
		var info = helper.NewInfo(1.0, 1.0, 1.0);
		var actual = obj.compute(info);
		Test.assertEqualMessage(actual, "4:10" , "Expected 4:10 but got " + actual);			
		return true;		
	}
}