inherits sumearthbase;

trigger use {
	Q4M9(this, user);
	return(0x00);
}

trigger message("castspell") {
	obj user = Q4BB(this, args);
	if (!isValid(user)) {
		return(0x00);
	}
	if (!Q5YC(user, this)) {
		return(0x00);
	}
	if (Q4LT(user, getLocation(user), this)) {
		Q4MI(user);
	} else {
		Q4RD(user);
	}
	return(0x00);
}

trigger creation {
	return(0x00);
}
