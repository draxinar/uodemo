inherits globals;

trigger enterrange(0x03) {
	string Q5ZM = "Go no farther, lest ye face thy death!";
	list Q56U = Q5ZM;
	if (!hasObjVar(this, "working")) {
		if (!hasObjVar(target, "CovetousListenToStatueSpeakTwo")) {
			setObjVar(this, "working", 0x01);
			callback(this, 0x19, 0x24);
			bark(this, Q5ZM);
			messageToRange(getLocation(this), 0x05, "barknow", Q56U);
			setObjVar(target, "CovetousListenToStatueSpeakTwo", 0x01);
		}
	}
	return(0x01);
}

trigger callback(0x24) {
	if (hasObjVar(this, "working")) {
		removeObjVar(this, "working");
	}
	return(0x00);
}

trigger speech("resetme") {
	if (hasObjVar(speaker, "CovetousListenToStatueSpeakTwo")) {
		removeObjVar(speaker, "CovetousListenToStatueSpeakTwo");
	}
	return(0x00);
}
