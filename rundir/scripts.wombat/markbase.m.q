inherits spelskil;

function int Q4A2(obj it) {
	int objtype = getObjType(it);
	switch(objtype) {
	case 0x1F14
	case 0x1F15
	case 0x1F16
	case 0x1F17
		return(0x01);
		break;
	default
		return(0x00);
		break;
	}
	return(0x00);
}

function int Q43D(obj user, obj usedon) {
	if (usedon == NULL()) {
		return(0x00);
	}
	if (!isValid(usedon)) {
		bark(user, "I cannot mark that object.");
		return(0x00);
	}
	if ((containedBy(usedon) == NULL()) && (canSeeObj(user, usedon) != 0x01)) {
		bark(user, "I cannot see that object.");
		return(0x00);
	}
	if (isMobile(usedon) || (!Q4A2(usedon))) {
		bark(user, "I cannot mark that object.");
		return(0x00);
	}
	if (isOnAnyMulti(user)) {
		bark(user, "You can not mark an object at that location.");
		return(0x00);
	}
	return(0x01);
}

function int Q4KT(obj user, obj usedon) {
	int Q5NC = 0x00;
	if (Q43D(user, usedon)) {
		loc Q4VS = getLocation(user);
		if (Q50L(Q4VS)) {
			Q5NC = 0x01;
			setObjVar(usedon, "markLoc", Q4VS);
			list Q5DR;
			message(usedon, "marked", Q5DR);
			doLocAnimation(getLocation(usedon), 0x3779, 0x0A, 0x0F, 0x00, 0x00);
			sfx(Q4VS, 0x01FA, 0x00);
		} else {
			systemMessage(user, "Thy spell doth not appear to work...");
		}
	}
	Q5UQ(this);
	return(Q5NC);
}
