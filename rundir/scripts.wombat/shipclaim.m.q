inherits shipstuff;

trigger objectloaded {
	if (hasScript(this, "spellbook")) {
		detachScript(this, "spellbook");
	}
	return(0x01);
}

trigger targetloc {
	if (!isInMap(place)) {
		return(0x00);
	}
	if (hasObjVar(this, "claimloc")) {
		loc claimloc = getObjVar(this, "claimloc");
		if (getDistanceInTiles(place, claimloc) > 0x64) {
			barkTo(user, user, "You are too far away from the location at which the ship was docked.");
			return(0x01);
		}
	}
	int Q5SR = 0x00;
	if (getDistanceInTiles(place, getLocation(user)) > 0x06) {
		barkTo(user, user, "That location is too far away.");
		return(0x01);
	}
	if (!hasObjVar(this, "myshiptype")) {
		Q5SR = 0x00;
	} else {
		Q5SR = getObjVar(this, "myshiptype");
	}
	obj Q5AO = NULL();
	if (hasObjVar(this, "shipobj")) {
		Q5AO = getObjVar(this, "shipobj");
	}
	Q5NG = 0x00 - 0x05;
	int Q5NC = 0x00 - 0x01;
	if (Q5AO != NULL()) {
		Q5NC = canMultiExistAt(Q5AO, place, Q43W);
	}
	if (Q5NC <= 0x00) {
		string Q58D = Q592(Q5NG, "ship", "water");
		barkTo(user, user, Q58D);
		return(0x01);
	}
	int Q527 = teleport(Q5AO, place);
	deleteObject(this);
	return(0x01);
}

trigger use {
	int Q5SR;
	if (!hasObjVar(this, "myshiptype")) {
		Q5SR = 0x00;
	} else {
		Q5SR = getObjVar(this, "myshiptype");
	}
	int multi = Q5SS(Q5SR, 0x00);
	barkTo(user, user, "Where do you wish to place the ship?");
	targetlocmulti(user, this, multi, 0x00, 0x00, 0x00);
	return(0x00);
}

trigger creation {
	int Q5AU = 0x00;
	if (!hasObjVar(this, "myshiptype")) {
		setObjVar(this, "myshiptype", Q5AU);
	} else {
		Q5AU = getObjVar(this, "myshiptype");
	}
	setObjVar(this, "mybasevalue", Q5S0(Q5AU));
	setObjVar(this, "fakeCont", 0x01);
	return(0x01);
}

trigger give {
	return(0x00);
}

trigger decay {
	return(0x00);
}

trigger shop {
	obj Q5AO = NULL();
	if (hasObjVar(this, "shipobj")) {
		Q5AO = getObjVar(this, "shipobj");
	}
	if (isValid(Q5AO)) {
		deleteObject(Q5AO);
	}
	return(0x01);
}
