inherits magctrapbase;

trigger use {
	Q4M9(this, user);
	return(0x00);
}

trigger message("castspell") {
	obj user = Q4BB(this, args);
	if (!isValid(user)) {
		return(0x00);
	}
	Q5RD(user, this);
	targetObj(user, this);
	return(0x00);
}

trigger targetobj {
	if (!Q4C8(user, this)) {
		return(0x01);
	}
	if (usedon == NULL()) {
		return(0x00);
	}
	if (Q49V(user, usedon, 0x00)) {
		if (isMobile(usedon)) {
			barkToHued(user, user, 0x22, "You cannot cast this on a being.");
			return(0x00);
		}
		if (!Q5YC(user, this)) {
			return(0x00);
		}
		if (Q4LT(user, getLocation(usedon), this)) {
			Q4KO(user, usedon);
		} else {
			Q4RD(user);
		}
	}
	return(0x00);
}

trigger creation {
	return(0x00);
}
