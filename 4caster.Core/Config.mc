module CasterCore {
	(:Config)
	module Config {
		class Settings {
			var mLabel = "";
			var mMilestoneMeters = 1609.34; 
			
			function initialize(label, milestoneMeters) {
		        mLabel = label;
		    }
		    
		    function GetLabel() {
		    	return mLabel;
		    }
		    
		    function GetMilestoneMeters() {
		    	return mMilestoneMeters;
		    }
		}
	}	
}
