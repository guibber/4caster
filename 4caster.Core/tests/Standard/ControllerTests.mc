using Toybox.Test;
using Toybox.Activity;
using Toybox.Math;
using CasterCore.Standard as M;
using CasterCore.Config as Cfg;

module CasterCore {
	class ControllerTestsHelper {
		function NewInfo(speed, distance, time) {
			var info = new Activity.Info();
			info.currentSpeed = speed;
			info.elapsedDistance = distance;
			info.timerTime = time;
			return info;
		}
		
		function ValidateGetDistanceToNextMilestone(distance, expected, log) {
			log.debug("ValidateGetDistanceToNextMilestone distance = " + distance + " expected = " + expected);
			var obj = new M.Controller(new Cfg.Settings("4caster", 1609.34));
			var actual = obj.GetDistanceToNextMilestone(distance);
			Test.assertEqualMessage(Math.round(actual * 100), Math.round(expected * 100) , "Expected " + expected + " but got " + Math.round(actual * 100)/100);	
			return true;		
		}
		
		function ValidateCalculateTotalSecondsAtNextMilestone(speed, distance, time, expected, log) {
			log.debug("ValidateCalculateTotalSecondsAtNextMilestone speed = " + speed + " distance = " + distance + " time = " + time + " expected = " + expected);
			var actual = new M.Controller(new Cfg.Settings("4caster", 1609.34)).CalculateTotalSecondsAtNextMilestone(NewInfo(speed, distance, time));
			Test.assertEqualMessage(actual, expected , "Expected " + expected + " but got " + actual);	
		}
		
		function ValidateGetCurrentOrAverageSpeed(speed, distance, time, expected, log) {
			log.debug("ValidateGetCurrentOrAverageSpeed speed = " + speed + " distance = " + distance + " time = " + time + " expected = " + expected);
			var actual = new M.Controller(new Cfg.Settings(null, 1609.34)).GetCurrentOrAverageSpeed(new Utils.InfoEx(NewInfo(speed, distance, time)));
			Test.assertEqualMessage(Math.round(actual * 100), Math.round(expected * 100) , "Expected " + expected + " but got " + Math.round(actual * 100)/100);	
		}
		
		function ValidateAdjustLapInfo(currentLap, currentLastLapTotalSeconds, distance, time, expectedLap, expectedLastLapTotalSeconds, log) {
			log.debug("ValidateAdjustLapInfo distance = " + distance + " time = " + time + " expectedLap = " + expectedLap + " expectedLastLapTotalSeconds = " + expectedLastLapTotalSeconds);
			var settings = new Cfg.Settings(null, 1609.34);
			settings.SetLapCount(currentLap);
			settings.SetLastLapTotalSeconds(currentLastLapTotalSeconds);
			new M.Controller(settings).AdjustLapInfo(new Utils.InfoEx(NewInfo(null, distance, time)));
			Test.assertEqualMessage(settings.GetLapCount(), expectedLap , "Expected lap = " + expectedLap + " but got " + settings.GetLapCount());
			Test.assertEqualMessage(settings.GetLastLapTotalSeconds(), expectedLastLapTotalSeconds , "Expected lap total seconds =  " + expectedLastLapTotalSeconds + " but got " + settings.GetLastLapTotalSeconds());
		}
		
		function ValidateCalculateLapSecondsAtNextMilestone(currentLap, currentLastLapTotalSeconds, speed, distance, time, expected, log) {
			log.debug("ValidateCalculateLapSecondsAtNextMilestone speed = " + speed + " distance = " + distance + " time = " + time + " expected = " + expected);
			var settings = new Cfg.Settings(null, 1609.34);
			settings.SetLapCount(currentLap);
			settings.SetLastLapTotalSeconds(currentLastLapTotalSeconds);
			var actual = new M.Controller(settings).CalculateLapSecondsAtNextMilestone(NewInfo(speed, distance, time));
			Test.assertEqualMessage(actual, expected , "Expected " + expected + " but got " + actual);	
		}
	}

	class ControllerTests {
		(:test)
		function TestGetLabel(log) {
			var actual = new M.Controller(new Cfg.Settings("label", null)).GetLabel();
			Test.assertEqualMessage(actual, "label" , "Expected label but got " + actual);
			return true;		
		}
		
		(:test)
		function TestGetDistanceToNextMilestone(log) {
			var helper = new CasterCore.ControllerTestsHelper();
			helper.ValidateGetDistanceToNextMilestone(0, 1609.34, log);
			helper.ValidateGetDistanceToNextMilestone(1609.34, 1609.34, log);
			helper.ValidateGetDistanceToNextMilestone(1000, 609.34, log);
			helper.ValidateGetDistanceToNextMilestone(2000, 1218.68, log);			
			return true;		
		}
		
		(:test)
		function TestGetCurrentOrAverageSpeed(log) {
			var helper = new CasterCore.ControllerTestsHelper();
			helper.ValidateGetCurrentOrAverageSpeed(0.0, 800.00, 240000.0, 3.333333, log);
			helper.ValidateGetCurrentOrAverageSpeed(4.4, 800.00, 240000.0, 4.4, log);		
			return true;		
		}
		
		(:test)
		function TestCalculateTotalSecondsAtNextMilestone(log) {
			var helper = new CasterCore.ControllerTestsHelper();
			helper.ValidateCalculateTotalSecondsAtNextMilestone(null, null, null, 0, log);
			helper.ValidateCalculateTotalSecondsAtNextMilestone(0.0, 0.0, 0.0, 0, log);
			helper.ValidateCalculateTotalSecondsAtNextMilestone(1.0, 0.0, 0.0, 0, log);
			helper.ValidateCalculateTotalSecondsAtNextMilestone(0.0, 1.0, 0.0, 0, log);
			helper.ValidateCalculateTotalSecondsAtNextMilestone(0.0, 0.0, 1.0, 0, log);
			helper.ValidateCalculateTotalSecondsAtNextMilestone(0.0, 800.00, 240000.0, 483, log);
			helper.ValidateCalculateTotalSecondsAtNextMilestone(0.0, 800.00, 241000.0, 485, log);
			helper.ValidateCalculateTotalSecondsAtNextMilestone(0.0, 800.00, 300000.0, 604, log);	
			helper.ValidateCalculateTotalSecondsAtNextMilestone(1.0, 1609.34, 60000.0, 1669, log);
			helper.ValidateCalculateTotalSecondsAtNextMilestone(3.0, 1000.0, 240000.0, 443, log);
			helper.ValidateCalculateTotalSecondsAtNextMilestone(4.3, 2000, 360800.0, 644, log);
			return true;		
		}
		
		(:test)
		function TestAdjustLapInfo(log) {
			var helper = new CasterCore.ControllerTestsHelper();
			helper.ValidateAdjustLapInfo(0, 0, 0, 0, 0, 0, log);
			helper.ValidateAdjustLapInfo(0, 0, 1609.33, 240000, 0, 0, log);
			helper.ValidateAdjustLapInfo(0, 0, 1609.34, 240000, 1, 240, log);
			helper.ValidateAdjustLapInfo(0, 240, 1609.35, 240000, 1, 240, log);
			helper.ValidateAdjustLapInfo(1, 240, 1609.34, 241000, 1, 240, log);
			helper.ValidateAdjustLapInfo(1, 240, 1809.34, 260000, 1, 240, log);
			helper.ValidateAdjustLapInfo(1, 240, 3218.67, 310000, 1, 240, log);
			helper.ValidateAdjustLapInfo(1, 240, 3218.68, 310000, 2, 310, log);
		    helper.ValidateAdjustLapInfo(1, 240, 3218.69, 310000, 2, 310, log);
			return true;
		}
		
		(:test)
		function TestCalculateLapSecondsAtNextMilestone(log) {
			var helper = new CasterCore.ControllerTestsHelper();
			helper.ValidateCalculateLapSecondsAtNextMilestone(0, 0.0, null, null, null, 0, log);
			helper.ValidateCalculateLapSecondsAtNextMilestone(0, 0.0, 0.0, 0.0, 0.0, 0, log);
			helper.ValidateCalculateLapSecondsAtNextMilestone(0, 0.0, 1.0, 0.0, 0.0, 0, log);
			helper.ValidateCalculateLapSecondsAtNextMilestone(0, 0.0, 0.0, 1.0, 0.0, 0, log);
			helper.ValidateCalculateLapSecondsAtNextMilestone(0, 0.0, 0.0, 0.0, 1.0, 0, log);
			helper.ValidateCalculateLapSecondsAtNextMilestone(0, 0.0, 0.0, 800.00, 240000.0, 483, log);
			helper.ValidateCalculateLapSecondsAtNextMilestone(0, 0.0, 0.0, 800.00, 241000.0, 485, log);
			helper.ValidateCalculateLapSecondsAtNextMilestone(0, 0.0, 0.0, 800.00, 300000.0, 604, log);	
			helper.ValidateCalculateLapSecondsAtNextMilestone(0, 0.0, 1.0, 1609.34, 60000.0, 1609, log);
			helper.ValidateCalculateLapSecondsAtNextMilestone(0, 0.0, 3.0, 1000.0, 240000.0, 443, log);
			helper.ValidateCalculateLapSecondsAtNextMilestone(1, 100.0, 4.3, 2000, 360800.0, 544, log);
			helper.ValidateCalculateLapSecondsAtNextMilestone(1, 200.0, 4.3, 2800, 360800.0, 258, log);
			helper.ValidateCalculateLapSecondsAtNextMilestone(1, 500.0, 5.0, 3018.68, 718000.0, 258, log);
			return true;		
		}
	}
}