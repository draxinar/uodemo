inherits globals;

trigger message("vanish") {
	int Q5A2 = getObjType(this);
	if (Q5A2 == 0x01) {
		return(0x00);
	} else {
		setObjVar(this, "vanished", Q5A2);
		setType(this, 0x01);
		callback(this, 0x1E, 0x24);
	}
	return(0x00);
}

trigger callback(0x24) {
	int Q5A2 = getObjVar(this, "vanished");
	setType(this, Q5A2);
	return(0x00);
}
