inherits sndfx;

trigger creation {
	callback(this, 0x02, 0x66);
	return(0x00);
}

trigger callback(0x66) {
	if (hasObjVar(this, "valueless")) {
		removeObjVar(this, "valueless");
	}
	return(0x00);
}

trigger use {
	if (isInContainer(this)) {
		return(0x00);
	}
	loc Q4VS = getLocation(this);
	int newType;
	obj Q5BL;
	int Q62A = getObjType(this);
	switch(Q62A) {
	case 0x0A55
	case 0x0A56
		if (hasObjVar(user, "timeInCamp")) {
			int Q633 = getObjVar(user, "timeInCamp");
			if (Q633 > 0x0F) {
				list Q59P;
				appendToList(Q59P, 0x00);
				appendToList(Q59P, "Using a bedroll in the safety of a camp will log you out of the game safely. If this is what you wish to do, click in the box at left, and then select Continue. Otherwise, hit the Cancel button to avoid logging out.");
				selectType(user, this, 0x39, "Logging out via camping.", Q59P);
			}
		}
		int bedroll = getObjType(this);
		sfx(Q4VS, 0x57, 0x00);
		if (bedroll == 0x0A55) {
			if (random(0x01, 0x02) == 0x01) {
				newType = 0x0A58;
			} else {
				newType = 0x0A57;
			}
		}
		if (bedroll == 0x0A56) {
			if (random(0x01, 0x02) == 0x01) {
				newType = 0x0A59;
			} else {
				newType = 0x0A57;
			}
		}
		setType(this, newType);
		break;
	case 0x0A57
	case 0x0A58
	case 0x0A59
		sfx(Q4VS, 0x57, 0x00);
		if (random(0x01, 0x02) == 0x01) {
			Q5BL = createNoResObjectAt(0x0A55, Q4VS);
			attachScript(Q5BL, "2645");
		} else {
			Q5BL = createNoResObjectAt(0x0A56, Q4VS);
			attachScript(Q5BL, "2646");
		}
		deleteObject(this);
		break;
	}
	return(0x00);
}

trigger typeselected(0x39) {
	if (listindex == 0x00) {
		return(0x00);
	}
	switch(objtype) {
	case 0x00
		if (hasObjVar(user, "campFireId")) {
			removeObjVar(user, "campFireId");
		}
		if (hasObjVar(user, "timeInCamp")) {
			removeObjVar(user, "timeInCamp");
		}
		setType(this, 0x0A58);
		int Q4Q1 = putObjContainer(this, getBackpack(user));
		safeLogOut(user);
		return(0x00);
		break;
	default
		return(0x00);
	}
	return(0x00);
}
