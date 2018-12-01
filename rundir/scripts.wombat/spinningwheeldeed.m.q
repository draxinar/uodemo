inherits globals;

trigger use {
	systemMessage(user, "Choose a location to create your spinning wheel.");
	systemMessage(user, "You will not be able to put it in your backpack afterwards.");
	targetLoc(user, this);
	return(0x01);
}

trigger targetobj {
	if (usedon == NULL()) {
		return(0x00);
	}
	systemMessage(user, "Targetobj called");
	setObjVar(this, "ObjSelected", 0x01);
	loc Q5YL = getLocation(usedon);
	int Q5VA = getTileHeight(0x1019);
	setZ(Q5YL, getZ(Q5YL) + getHeight(usedon));
	int Q4OF = canExistAt(Q5YL, Q5VA, 0x01);
	obj Q4F1;
	if (Q4OF == 0x07) {
		Q4F1 = requestCreateObjectAt(0x1019, Q5YL);
		if (Q4F1 != NULL()) {
			deleteObject(this);
		} else {
			systemMessage(user, "Can't create a spinning wheel there.");
			return(0x00);
		}
	} else {
		systemMessage(user, "Can't create a spinning wheel there.");
		return(0x00);
	}
	return(0x01);
}

trigger targetloc {
	if (!isInMap(place)) {
		return(0x00);
	}
	systemMessage(user, "Targetloc called");
	if (!(hasObjVar(this, "ObjSelected"))) {
		int Q4VQ = getTileHeight(0x1019);
		int Q4OF = canExistAt(place, Q4VQ, 0x01);
		obj Q4F1;
		if (Q4OF == 0x07) {
			Q4F1 = requestCreateObjectAt(0x1019, place);
			if (Q4F1 != NULL()) {
				deleteObject(this);
			} else {
				systemMessage(user, "Can't create a spinning wheel there.");
				return(0x00);
			}
		} else {
			systemMessage(user, "Can't create a spinning wheel there.");
			return(0x00);
		}
	}
	removeObjVar(this, "ObjSelected");
	return(0x01);
}
