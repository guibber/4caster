module CasterCore {
	(:Utils)
	module Utils {
		class InfoEx {
			var mInfo = null;
			function initialize(info) {
		        mInfo = info;
		    }
		    
		    function GetCurrentSpeed() {
		    	return mInfo.currentSpeed != null ? mInfo.currentSpeed : 0.0;
		    }
		    
		    function GetElapsedDistance() {
		    	return mInfo.elapsedDistance != null ? mInfo.elapsedDistance : 0.0;
		    }
		    
		    function GetElapsedTime() {
		    	return mInfo.elapsedTime != null ? mInfo.elapsedTime : 0.0;
		    }
		
		    function GetTimerTime() {
		    	return mInfo.timerTime != null ? mInfo.timerTime : 0.0;
		    }    
		}
	}
	
	(:Config)
	module Config {
		enum {
			DisplayModeStandard,
			DisplayModeLaps
		}
		
		class Settings {
			var mLabel = "";
			var mDisplayMode = DisplayModeStandard;
			var mMilestoneMeters = 1609.34; 
			
			function initialize(label, displayMode, milestoneMeters) {
		        mLabel = label;
		        mDisplayMode = displayMode;
		    }
		    
		    function GetLabel() {
		    	return mLabel;
		    }
		    
		    function GetDisplayMode() {
		    	return mDisplayMode;
		    }
		    
		    function GetMilestoneMeters() {
		    	return mMilestoneMeters;
		    }
		}
	}	
}
