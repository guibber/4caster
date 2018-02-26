using Toybox.Math;
using CasterCore.Utils as Utils;

class CasterViewTestsHelper {
	function NewInfo(speed, distance, time) {
		var info = new Activity.Info();
		info.currentSpeed = speed;
		info.elapsedDistance = distance;
		info.timerTime = time;
		return info;
	}
	
	function ValidateComputeReturnsZeros(speed, distance, time, log) {
		log.debug("ValidateReturnsZeros with speed = " + speed + " distance = " + distance + " time = " + time);
		var obj = new CasterView();		
		var actual = obj.compute(NewInfo(speed, distance, time));		
		Test.assertEqualMessage(actual, "0:00" , "Expected 0:00 but got " + actual);
		return true;
	}
	
	function ValidateGetDistanceToNextMilestone(distance, expected, log) {
		log.debug("ValidateGetDistanceToNextMilestone distance = " + distance + " expected = " + expected);
		var obj = new CasterView();		
		var actual = obj.GetDistanceToNextMilestone(distance);
		Test.assertEqualMessage(Math.round(actual * 100), Math.round(expected * 100) , "Expected " + expected + " but got " + Math.round(actual * 100)/100);	
		return true;		
	}
	
	function ValidateFormatTimeFromSeconds(seconds, expected, log) {
		log.debug("ValidateFormatTimeFromSeconds seconds = " + seconds + " expected = " + expected);
		var obj = new CasterView();		
		var actual = obj.FormatTimeFromSeconds(seconds);
		Test.assertEqualMessage(actual, expected, "Expected " + expected + " but got " + actual);	
		return true;		
	}
	
	function ValidateCompute(speed, distance, time, expected, log) {
		log.debug("ValidateCompute speed = " + speed + " distance = " + distance + " time = " + time + " expected = " + expected);
		var actual = new CasterView().compute(NewInfo(speed, distance, time));
		Test.assertEqualMessage(actual, expected , "Expected " + expected + " but got " + actual);	
	}
	
	function ValidateGetCurrentOrAverageSpeed(speed, distance, time, expected, log) {
		log.debug("ValidateGetCurrentOrAverageSpeed speed = " + speed + " distance = " + distance + " time = " + time + " expected = " + expected);
		var actual = new CasterView().GetCurrentOrAverageSpeed(new Utils.InfoEx(NewInfo(speed, distance, time)));
		Test.assertEqualMessage(Math.round(actual * 100), Math.round(expected * 100) , "Expected " + expected + " but got " + Math.round(actual * 100)/100);	
	}
}