inherits bless;

trigger creation {
	setObjVar(this, "magicItemModifier", 0x04);
	shortcallback(this, 0x01, 0x2F);
	return(0x00);
}

trigger callback(0x2F) {
	int Q54U;
	int Q4Q1 = getResource(Q54U, this, "magic", 0x03, 0x02);
	int charges = Q54U / 0x09;
	setObjVar(this, "charges", charges);
	return(0x00);
}

trigger use {
	int charges = getObjVar(this, "charges");
	if (charges <= 0x00) {
		systemMessage(user, "This magic item is out of charges.");
		return(0x00);
	}
	if (hasScript(user, "reflctor")) {
		doMobAnimation(user, 0x37B9, 0x0A, 0x05, 0x00, 0x00);
		detachScript(user, "reflctor");
	} else {
		Q4J0(user, user, 0x00);
	}
	charges = charges - 0x01;
	setObjVar(this, "charges", charges);
	returnResourcesToBank(this, 0x09, "magic");
	if (charges <= 0x00) {
		systemMessage(user, "This magic item is out of charges.");
	}
	return(0x00);
}
