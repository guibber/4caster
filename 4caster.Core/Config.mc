module CasterCore {
	module Config {
		class Settings {
			var mLabel = "";
			var mMilestoneMeters = 1609.34;
			var mLapCount = 0;
			var mLastLapTotalSeconds = 0;
			
			function initialize(label, milestoneMeters) {
		        mLabel = label;
		    }
		    
		    function GetLabel() {
		    	return mLabel;
		    }
		    
		    function GetMilestoneMeters() {
		    	return mMilestoneMeters;
		    }
		    
		    function GetLapCount() {
		    	return mLapCount;
		    }
		    
		    function GetLastLapTotalSeconds() {
		    	return mLastLapTotalSeconds;
		    }
		    
		    function SetLapCount(value) {
		    	mLapCount = value;
		    }
		    
		    function SetLastLapTotalSeconds(value) {
		    	mLastLapTotalSeconds = value;
		    }
		}
	}	
}
