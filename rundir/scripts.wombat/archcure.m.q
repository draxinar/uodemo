inherits archcurebase;

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
	Q489(user, this, 0x02);
	return(0x00);
}

trigger targetloc {
	if (!Q4C8(user, this)) {
		return(0x01);
	}
	if (!isInMap(place)) {
		return(0x00);
	}
	if (canSeeLoc(user, place) == 0x01) {
		if (!Q5YC(user, this)) {
			return(0x00);
		}
		if (Q4LT(user, place, this)) {
			Q4IV(user, place, 0x00);
		} else {
			Q4RD(user);
		}
	} else {
		systemMessage(user, "Target cannot be seen.");
	}
	return(0x00);
}

trigger creation {
	return(0x00);
}
