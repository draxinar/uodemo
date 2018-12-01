trigger creation {
	setType(this, 0x01);
	return(0x00);
}

trigger enterrange(0x03) {
	if (!hasObjVar(this, "disarmed")) {
		doLocAnimation(getLocation(this), 0x1D99, 0x02, 0x30, 0x00, 0x00);
	}
	return(0x01);
}

trigger enterrange(0x00) {
	if (!hasObjVar(this, "disarmed")) {
		doLocAnimation(getLocation(this), 0x1D99, 0x02, 0x30, 0x00, 0x00);
		loseHP(target, dice(0x0A, 0x07));
	}
	return(0x01);
}
