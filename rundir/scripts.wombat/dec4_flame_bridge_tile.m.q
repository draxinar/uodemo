inherits globals;

trigger leaverange(0x02) {
	int Q5YO = getX(getLocation(target));
	int Q62F = getX(getLocation(this));
	list Q67G;
	if (!hasObjVar(this, "working") && (Q5YO < Q62F)) {
		setObjVar(this, "working", 0x01);
		doLocAnimation(getLocation(this), 0x3709, 0x02, 0x38, 0x00, 0x00);
		setType(this, 0x3727);
		callback(this, 0x01, 0x24);
		clearList(Q67G);
		getMobsAt(Q67G, getLocation(this));
		for (int i = 0x00; i < numInList(Q67G); i++) {
			loseHP(Q67G[i], 0x03E8);
		}
	}
	return(0x01);
}

trigger callback(0x24) {
	if (hasObjVar(this, "working")) {
		removeObjVar(this, "working");
	}
	deleteObject(this);
	return(0x00);
}
