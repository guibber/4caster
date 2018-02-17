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
        	var secondsLeft = GetDistanceToNextMilestone(infoEx.GetElapsedDistance()) / infoEx.GetCurrentSpeed();
        	var totalSeconds = secondsLeft + infoEx.GetElapsedTime();      	
        	return "4:10";
        }
        return "0:00";
    }
        
    function ShouldCompute(infoEx) {
    	return infoEx.GetCurrentSpeed() > 0 and
    		   infoEx.GetElapsedTime() > 0 and
    		   infoEx.GetElapsedDistance() > 0;
    }
    
    function GetDistanceToNextMilestone(distance) {
    	var cnt = Math.floor(distance / _MilestoneSize) + 1;    	
    	return ((cnt * _MilestoneSize) - distance);
    }
    
    function FormatTimeFromSeconds(seconds) {
    	var minutes = Math.floor(seconds / 60.0);
    	var remainder = Math.floor(seconds - (minutes * 60.0));
    	return Lang.format("$1$:$2$", [minutes.format("%d"), remainder.format("%02d")]);
    }
}