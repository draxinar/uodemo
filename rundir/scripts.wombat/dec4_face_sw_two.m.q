inherits globals;

trigger use {
	loc trapLocation = 0x14B9, 0x02A2, (0x00 - 0x14);
	list Q5DQ;
	if (!hasObjVar(this, "working")) {
		setObjVar(this, "working", 0x01);
		doLocAnimation(trapLocation, 0x10F6, 0x02, 0x08, 0x00, 0x00);
		loseHP(user, dice(0x04, 0x05));
		setType(this, 0x1090);
		callback(this, 0x02, 0x24);
	}
	return(0x00);
}

trigger callback(0x24) {
	if (hasObjVar(this, "working")) {
		removeObjVar(this, "working");
	}
	if (getObjType(this) == 0x1090) {
		setType(this, 0x108F);
	}
	return(0x00);
}
