inherits globals;

member int Q468;

trigger creation {
	setType(this, 0x01);
	Q468 = 0x01;
	callback(this, 0x01, 0x24);
	return(0x00);
}

trigger message("doAnimation") {
	list Q67G;
	doLocAnimation(getLocation(this), 0x111C, 0x02, 0x10, 0x00, 0x00);
	getMobsInRange(Q67G, getLocation(this), 0x01);
	for (int i = 0x00; i < numInList(Q67G); i++) {
		loseHP(Q67G[i], dice(0x14, 0x05));
	}
	return(0x00);
}

trigger callback(0x24) {
	list Q5DQ;
	loc Q5V2 = 0x15C3, 0x0754, 0x07;
	loc Q5V1 = 0x15BF, 0x0754, 0x07;
	if (Q468 == 0x01) {
		messageToRange(getLocation(this), 0x02, "doAnimation", Q5DQ);
	}
	if (Q468 == 0x02) {
		messageToRange(Q5V2, 0x02, "doAnimation", Q5DQ);
	}
	if (Q468 == 0x03) {
		messageToRange(Q5V1, 0x02, "doAnimation", Q5DQ);
	}
	if (Q468 == 0x04) {
		Q468 = 0x01;
	} else {
		Q468 = Q468 + 0x01;
	}
	callback(this, 0x01, 0x24);
	return(0x00);
}
