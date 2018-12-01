trigger creation {
	setObjVar(this, "isLocked", 0x0100);
	return(0x00);
}

trigger use {
	if (hasObjVar(this, "isLocked")) {
		bark(this, "It appears to be locked.");
		return(0x00);
	}
	return(0x01);
}

trigger message("unlock") {
	if (hasObjVar(this, "isLocked")) {
		removeObjVar(this, "isLocked");
	}
	return(0x00);
}

trigger message("reset") {
	if (!hasObjVar(this, "isLocked")) {
		setObjVar(this, "isLocked", 0x0100);
	}
	return(0x00);
}
