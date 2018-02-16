class CasterViewTestsHelper {
	function NewInfo(speed, distance, time) {
		var info = new Activity.Info();
		info.currentSpeed = speed;
		info.elapsedDistance = distance;
		info.elapsedTime = time;
		return info;
	}
	
	function ValidateReturnsZeros(speed, distance, time, log) {
		log.debug("ValidateReturnsZeros with speed = " + speed + " distance = " + distance + " time = " + time);
		var obj = new CasterView();		
		var actual = obj.compute(NewInfo(speed, distance, time));		
		Test.assertEqualMessage(actual, "0:00" , "Expected 0:00 but got " + actual);
		return true;
	}
}