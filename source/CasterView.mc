using Toybox.WatchUi as Ui;
using Toybox.System;

class CasterView extends Ui.SimpleDataField {
	const _MetersToMiles = 0.000621371;
    const _MillisecondsToSeconds = 0.001;
    const _MilestoneSize = 1609.34;
    
    function initialize() {
        SimpleDataField.initialize();
        label = "4caster";
    }

    function compute(info) {
    	var infoEx = new InfoEx(info);
    	System.println("Current Speed = " + infoEx.GetCurrentSpeed() + " ElapsedDistance = " + infoEx.GetElapsedDistance());
        if (ShouldCompute(infoEx)) {
        	var speed = GetCurrentOrAverageSpeed(infoEx);        	
        	var secondsLeft = GetDistanceToNextMilestone(infoEx.GetElapsedDistance()) / speed;
        	var totalSeconds = secondsLeft + (infoEx.GetElapsedTime() / 1000);      	
        	return FormatTimeFromSeconds(totalSeconds);
        }
        return "0:00";
    }
        
    function ShouldCompute(infoEx) {
    	return infoEx.GetElapsedTime() > 0 and
    		   infoEx.GetElapsedDistance() > 0;
    }
    
    function GetDistanceToNextMilestone(distance) {
    	var cnt = Math.floor(distance / _MilestoneSize) + 1;    	
    	return ((cnt * _MilestoneSize) - distance);
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
    	return infoEx.GetCurrentSpeed() > 0 ? infoEx.GetCurrentSpeed() : infoEx.GetElapsedDistance() / (infoEx.GetElapsedTime() / 1000);
    }
}