using Toybox.WatchUi as Ui;
using CasterCore.Utils as Utils;
using CasterCore.Config as Cfg;
using CasterCore.Standard as Std;

module CasterCore {
	module Standard {
		function BuildView(settings) {
			return new Std.View(new Std.Controller(settings));
		}
		
		function BuildLapView(settings) {
			return new Std.LapView(new Std.Controller(settings));
		}
		
		function BuildDataField() {
			return new Std.DataField(Std.BuildView(new Cfg.Settings("4caster", 1609.34)));
		}
		
		function BuildLapDataField() {
			return new Std.DataField(Std.BuildLapView(new Cfg.Settings("4caster-L", 1609.34)));
		}
		
		class DataField extends Ui.SimpleDataField {
			var mView = null;
			
			function initialize(view) {
		        SimpleDataField.initialize();
		        mView = view;
		        label = mView.GetLabel();
		    }
		
		    function compute(info) {
		    	return mView.GetComputeViewString(info);
		    }
		}
		
		class View {
			var mController = null;
			
			function initialize(controller) {
		        mController = controller;
		    }
		    
		    function GetLabel() {
		    	return mController.GetLabel();
		    }
		    
		    function GetComputeViewString(info) {
		    	return FormatTimeFromSeconds(mController.CalculateTotalSecondsAtNextMilestone(info));
		    }
		    
		    function FormatTimeFromSeconds(seconds) {
		    	var hours = Math.floor(seconds / 3600.0);
		    	var minutes = Math.floor((seconds - (hours * 3600.0)) / 60.0);
		    	var remainder = Math.floor(seconds - (hours * 3600.0) - (minutes * 60.0));
		    	return (hours > 0) 
		    		? Lang.format("$1$:$2$:$3$", [hours.format("%d"), minutes.format("%02d"), remainder.format("%02d")])
		    		: Lang.format("$1$:$2$", [minutes.format("%d"), remainder.format("%02d")]);
		    }
		}
		
		class LapView {
			var mController = null;
			
			function initialize(controller) {
		        mController = controller;
		    }
		    
		    function GetLabel() {
		    	return mController.GetLabel();
		    }
		    
		    function GetComputeViewString(info) {
		    	return FormatTimeFromSeconds(mController.CalculateLapSecondsAtNextMilestone(info));
		    }
		    
		    function FormatTimeFromSeconds(seconds) {
		    	var hours = Math.floor(seconds / 3600.0);
		    	var minutes = Math.floor((seconds - (hours * 3600.0)) / 60.0);
		    	var remainder = Math.floor(seconds - (hours * 3600.0) - (minutes * 60.0));
		    	return (hours > 0) 
		    		? Lang.format("$1$:$2$:$3$", [hours.format("%d"), minutes.format("%02d"), remainder.format("%02d")])
		    		: Lang.format("$1$:$2$", [minutes.format("%d"), remainder.format("%02d")]);
		    }
		}
		
		class Controller {
			var mSettings = null;
			
			function initialize(settings) {
		        mSettings = settings;
		    }
		    
		    function GetLabel() {
		    	return mSettings.GetLabel();
		    }

			function GetSafeDivisor(value) {
				return value > 0 ? value : 1;
			}
		    
		    function CalculateTotalSecondsAtNextMilestone(info) {
		    	var infoEx = new Utils.InfoEx(info);
    			System.println("Current Speed = " + infoEx.GetCurrentSpeed() + " ElapsedDistance = " + infoEx.GetElapsedDistance() + " TimerTime = " + infoEx.GetTimerTime() + " ElapsedTime = " + infoEx.GetElapsedTime());
		    	if (ShouldCompute(infoEx)) {
        			return Math.round(GetTotalSecondsAtNextMilestone(infoEx)).toNumber();
        		}
        		return 0;
		    }
		    
		    function CalculateLapSecondsAtNextMilestone(info) {
		    	var infoEx = new Utils.InfoEx(info);
    			System.println("Current Speed = " + infoEx.GetCurrentSpeed() + " ElapsedDistance = " + infoEx.GetElapsedDistance() + " TimerTime = " + infoEx.GetTimerTime() + " ElapsedTime = " + infoEx.GetElapsedTime());
    			AdjustLapInfo(infoEx);
		    	if (ShouldCompute(infoEx)) {
        			return Math.round(GetTotalSecondsAtNextMilestone(infoEx) - mSettings.GetLastLapTotalSeconds()).toNumber();
        		}
        		return 0;
		    }
		    
		    function AdjustLapInfo(infoEx) {
		    	var lapState = mSettings.GetLapCount();
		    	var currentLap = Math.floor(infoEx.GetElapsedDistance() / GetSafeDivisor(mSettings.GetMilestoneMeters())).toNumber();
		    	if (currentLap > lapState) {
		    		mSettings.SetLapCount(currentLap);
		    		mSettings.SetLastLapTotalSeconds(infoEx.GetTimerTime() / 1000);
		    	}
		    }
		    
		    function ShouldCompute(infoEx) {
    			return infoEx.GetTimerTime() > 0 and infoEx.GetElapsedDistance() > 0;
    		}
    		
    		function GetSecondsLeftUntilMilestone(infoEx) {
		    	return GetDistanceToNextMilestone(infoEx.GetElapsedDistance()) / GetSafeDivisor(GetCurrentOrAverageSpeed(infoEx));
		    }
		    
		    function GetTotalSecondsAtNextMilestone(infoEx) {
		    	return GetSecondsLeftUntilMilestone(infoEx) + (infoEx.GetTimerTime() / 1000);
		    }
		    
		    function GetDistanceToNextMilestone(distance) {
		    	return (((Math.floor(distance / GetSafeDivisor(mSettings.GetMilestoneMeters())) + 1) * mSettings.GetMilestoneMeters()) - distance);
		    }
		    
		    function GetCurrentOrAverageSpeed(infoEx) {
		    	return infoEx.GetCurrentSpeed() > 0 ? infoEx.GetCurrentSpeed() : infoEx.GetElapsedDistance() / GetSafeDivisor((infoEx.GetTimerTime() / 1000));
		    }
		}
	}	
}
