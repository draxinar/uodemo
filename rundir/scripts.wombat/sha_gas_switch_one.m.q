inherits globals;

member loc trapLocation;

member list Q5DQ;

trigger creation {
	trapLocation = 0x15DE, 0x3F, 0x00;
	return(0x00);
}

trigger use {
	if (!hasObjVar(this, "switchWorking")) {
		setObjVar(this, "switchWorking", Q5DQ);
		messageToRange(trapLocation, 0x05, "disarm", Q5DQ);
		callback(this, 0xF0, 0x26);
		return(0x01);
	}
	return(0x00);
}

trigger callback(0x26) {
	if (hasObjVar(this, "switchWorking")) {
		removeObjVar(this, "switchWorking");
		messageToRange(trapLocation, 0x05, "reset", Q5DQ);
	}
	return(0x00);
}
