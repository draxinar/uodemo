inherits globals;

trigger creation {
	setType(this, 0x11A1);
	return(0x00);
}

trigger enterrange(0x00) {
	list Q5DQ;
	if (!hasObjVar(this, "disarmed")) {
		loseHP(target, dice(0x14, 0x05));
	}
	return(0x01);
}

trigger message("fs_disarm") {
	int Q5DQ;
	if (!hasObjVar(this, "disarmed")) {
		setType(this, 0x11A0);
		setObjVar(this, "disarmed", Q5DQ);
	}
	return(0x00);
}

trigger message("fs_reload") {
	int Q5DQ;
	if (hasObjVar(this, "disarmed")) {
		setType(this, 0x11A1);
		removeObjVar(this, "disarmed");
	}
	return(0x00);
}
