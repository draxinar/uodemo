inherits grtheal;

trigger creation {
	setObjVar(this, "magicItemBonus", 0x00);
	shortcallback(this, 0x01, 0x2F);
	return(0x00);
}

trigger callback(0x2F) {
	int Q54U;
	int Q4Q1 = getResource(Q54U, this, "magic", 0x03, 0x02);
	int charges = Q54U / 0x03;
	setObjVar(this, "charges", charges);
	return(0x00);
}

trigger use {
	int charges = getObjVar(this, "charges");
	if (charges <= 0x00) {
		systemMessage(user, "This magic item is out of charges.");
		return(0x00);
	}
	Q4K5(user, user);
	charges = charges - 0x01;
	setObjVar(this, "charges", charges);
	returnResourcesToBank(this, 0x0F, "magic");
	if (charges <= 0x00) {
		systemMessage(user, "This magic item is out of charges.");
	}
	return(0x00);
}
