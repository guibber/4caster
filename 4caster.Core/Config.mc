module CasterCore {
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
