inherits globals;

trigger creation {
	callback(this, (0x3C * 0x3C * 0x18 * 0x07), 0x91);
	return(0x00);
}

trigger callback(0x91) {
	deleteObject(this);
	return(0x00);
}
