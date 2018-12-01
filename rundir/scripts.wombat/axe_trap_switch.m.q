trigger creation {
	int switchState = 0x00;
	setType(this, 0x1092);
	setObjVar(this, "switchState", switchState);
	return(0x00);
}

trigger use {
	loc Q47E = 0x1458, 0x022D, (0x00 - 0x14);
	list Q5DQ;
	int switchState = getObjVar(this, "switchState");
	if (switchState == 0x00) {
		setObjVar(this, "switchState", 0x01);
		callback(this, 0x1E, 0x01);
		setType(this, 0x1091);
		messageToRange(Q47E, 0x01, "axe_disarm", Q5DQ);
		return(0x00);
	} else {
		setObjVar(this, "switchState", 0x00);
		setType(this, 0x1092);
		messageToRange(Q47E, 0x01, "axe_reload", Q5DQ);
		return(0x00);
	}
	return(0x00);
}

trigger callback(0x01) {
	loc Q47E = 0x1458, 0x022D, (0x00 - 0x14);
	list Q5DQ;
	setObjVar(this, "switchState", 0x00);
	setType(this, 0x1092);
	messageToRange(Q47E, 0x01, "axe_reload", Q5DQ);
	return(0x00);
}
