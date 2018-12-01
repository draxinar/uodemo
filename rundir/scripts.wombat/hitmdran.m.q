inherits manadranbase;

trigger creation {
	shortcallback(this, 0x01, 0x2F);
	return(0x01);
}

trigger callback(0x2F) {
	int Q54U;
	int Q4Q1 = getResource(Q54U, this, "magic", 0x03, 0x02);
	int charges = Q54U / 0x0F;
	setObjVar(this, "charges", charges);
	return(0x01);
}

trigger ishitting {
	int charges = getObjVar(this, "charges");
	if (charges <= 0x00) {
		return(0x01);
	}
	obj Q68V = getTopmostContainer(this);
	if (hasScript(victim, "reflctor")) {
		doMobAnimation(victim, 0x37B9, 0x0A, 0x05, 0x00, 0x00);
		Q4KQ(victim, Q68V, 0x01);
		detachScript(victim, "reflctor");
	} else {
		Q4KQ(Q68V, victim, 0x00);
	}
	charges = charges - 0x01;
	setObjVar(this, "charges", charges);
	returnResourcesToBank(this, 0x0F, "magic");
	if (charges <= 0x00) {
		systemMessage(Q68V, "This magic item is out of charges.");
	}
	return(0x01);
}
