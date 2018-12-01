inherits sndfx;

trigger enterrange(0x03) {
	doLocAnimation(getLocation(this), 0x3709, 0x01, 0x38, 0x00, 0x00);
	sfx(getLocation(this), 0x0225, 0x00);
	return(0x01);
}

trigger enterrange(0x00) {
	doLocAnimation(getLocation(this), 0x3709, 0x01, 0x0100, 0x00, 0x00);
	loseHP(target, dice(0x08, 0x08));
	sfx(getLocation(this), 0x0225, 0x00);
	return(0x01);
}
