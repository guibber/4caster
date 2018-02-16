using Toybox.WatchUi as Ui;
using Toybox.Math;
using Toybox.System;

class CasterView extends Ui.SimpleDataField {
	const _MetersToMiles = 0.000621371;
    const _MillisecondsToSeconds = 0.001;
    
    function initialize() {
        SimpleDataField.initialize();
        label = "4Caster";
    }

    function compute(info) {
    	System.println(info.elapsedDistance);
    	var infoEx = new InfoEx(info);
    	System.println("Current Speed = " + infoEx.GetCurrentSpeed() + " ElapsedDistance = " + infoEx.GetElapsedDistance());
        if (ShouldCompute(infoEx)) {        	
        	return "4:10";
        }
        return "0:00";
    }    
    function ShouldCompute(infoEx) {
    	return infoEx.GetCurrentSpeed() > 0 and infoEx.GetElapsedTime() > 0;
    }
}