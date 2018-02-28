using Toybox.WatchUi as Ui;
using Toybox.System;
using CasterCore.Utils as Utils;

class CasterView extends Ui.SimpleDataField {
	
	var mSettings = null;
	
	function initialize(settings) {
        SimpleDataField.initialize();
        mSettings = settings;
        label = mSettings.GetLabel();
    }

    function compute(info) {
    	var infoEx = new Utils.InfoEx(info);
    	System.println("Current Speed = " + infoEx.GetCurrentSpeed() + " ElapsedDistance = " + infoEx.GetElapsedDistance() + " TimerTime = " + infoEx.GetTimerTime() + " ElapsedTime = " + infoEx.GetElapsedTime());
        if (ShouldCompute(infoEx)) {
        	return FormatTimeFromSeconds(GetTotalSecondsAtNextMilestone(infoEx));
        }
        return "0:00";
    }
    
    function GetSecondsLeftUntilMilestone(infoEx) {
    	return GetDistanceToNextMilestone(infoEx.GetElapsedDistance()) / GetCurrentOrAverageSpeed(infoEx);
    }
    
    function GetTotalSecondsAtNextMilestone(infoEx) {
    	return GetSecondsLeftUntilMilestone(infoEx) + (infoEx.GetTimerTime() / 1000);
    }
        
    function ShouldCompute(infoEx) {
    	return infoEx.GetTimerTime() > 0 and
    		   infoEx.GetElapsedDistance() > 0;
    }
    
    function GetDistanceToNextMilestone(distance) {
    	return (((Math.floor(distance / mSettings.GetMilestoneMeters()) + 1) * mSettings.GetMilestoneMeters()) - distance);
    }
    
    function FormatTimeFromSeconds(seconds) {
    	var hours = Math.floor(seconds / 3600.0);
    	var minutes = Math.floor((seconds - (hours * 3600.0)) / 60.0);
    	var remainder = Math.floor(seconds - (hours * 3600.0) - (minutes * 60.0));
    	return (hours > 0) 
    		? Lang.format("$1$:$2$:$3$", [hours.format("%d"), minutes.format("%02d"), remainder.format("%02d")])
    		: Lang.format("$1$:$2$", [minutes.format("%d"), remainder.format("%02d")]);
    }
    
    function GetCurrentOrAverageSpeed(infoEx) {
    	return infoEx.GetCurrentSpeed() > 0 ? infoEx.GetCurrentSpeed() : infoEx.GetElapsedDistance() / (infoEx.GetTimerTime() / 1000);
    }
}