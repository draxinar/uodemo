inherits cook;

trigger use {
	systemMessage(user, "What should I cook this on?");
	targetObj(user, this);
	return(0x01);
}

trigger targetobj {
	if (usedon == NULL()) {
		return(0x00);
	}
	if (hasObjVar(this, "NAME")) {
		string name;
		name = getObjVar(this, "NAME");
		if (name == "cake mix") {
			Q4E9(user, usedon, 0x09E9)return(0x01);
		} else {
			barkTo(this, user, "name incorrect");
			return(0x01);
		}
	}
	Q4E9(user, usedon, 0x160B);
	return(0x01);
}

trigger lookedat {
	if (hasObjVar(this, "NAME")) {
		string Q676 = getObjVar(this, "NAME");
		barkTo(this, looker, Q676);
		return(0x00);
	}
	return(0x01);
}
