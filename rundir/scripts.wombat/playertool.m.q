inherits globals;

trigger creation {
	overloadWeight(this, 0x5A);
	callback(this, 0x1388, 0x4C);
	return(0x01);
}

trigger callback(0x4C) {
	list Q5J1;
	getPlayersInRange(Q5J1, getLocation(this), 0x0F);
	if (numInList(Q5J1) > 0x00) {
		callback(this, 0x1388, 0x4C);
		return(0x00);
	}
	deleteObject(this);
	return(0x01);
}

trigger enterrange(0x05) {
	if (!isPlayer(target)) {
		return(0x01);
	}
	callback(this, 0x1388, 0x4C);
	return(0x01);
}
