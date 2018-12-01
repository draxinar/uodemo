inherits itemmanip;

forward void Q4S7(obj , loc );

trigger use {
	systemMessage(user, "Where do you wish to dig?");
	targetLoc(user, this);
	return(0x00);
}

trigger targetloc {
	if (!isInMap(place)) {
		return(0x00);
	}
	if (getDistanceInTiles(getLocation(user), place) > 0x04) {
		systemMessage(user, "That is too far away.");
		return(0x00);
	}
	if (objtype == 0x00) {
		int Q62L = getTileAt(place);
		if (Q4ZJ(Q62L)) {
			Q4S7(user, place);
		} else {
			systemMessage(user, "You can't mine there.");
		}
	} else {
		if (Q4ZI(objtype)) {
			Q4S7(user, place);
		} else {
			systemMessage(user, "You can't mine that.");
		}
	}
	return(0x00);
}

function void Q579(obj user) {
	if (getItemAtSlot(user, 0x19) != NULL()) {
		systemMessage(user, "You can't mine while riding.");
		return();
	}
	if (getObjType(user) < 0x0190) {
		systemMessage(user, "You can't mine while polymorphed.");
		return();
	}
	animateMobile(user, 0x0B, 0x14, 0x01, 0x00, 0x00);
	shortCallback(this, 0x04, 0x73);
	return();
}

function void Q4S7(obj user, loc place) {
	obj Q4D6 = getChunkEgg(place);
	int Q56Z = 0x00;
	int Q4Q1 = getResource(Q56Z, Q4D6, "metal", 0x03, 0x02);
	if (Q56Z <= 0x00) {
		systemMessage(user, "There is no metal here to mine.");
		return();
	}
	setObjVar(this, "user", user);
	setObjVar(this, "mineLoc", place);
	removeCallback(this, 0x72);
	removeCallback(this, 0x73);
	Q579(user);
	return();
}

trigger callback(0x73) {
	obj user = getObjVar(this, "user");
	sfx(getLocation(user), 0x0125, 0x00);
	if (getDistanceInTiles(getLocation(user), getObjVar(this, "mineLoc")) > 0x04) {
		systemMessage(user, "You have moved too far away to continue mining.");
	} else {
		shortCallback(this, 0x04, 0x72);
	}
	return(0x00);
}

trigger callback(0x72) {
	obj user = getObjVar(this, "user");
	obj Q4D6 = getChunkEgg(getObjVar(this, "mineLoc"));
	int Q56Z = 0x00;
	int Q4Q1 = getResource(Q56Z, Q4D6, "metal", 0x03, 0x02);
	removeObjVar(this, "user");
	removeObjVar(this, "mineLoc");
	if (Q56Z <= 0x00) {
		systemMessage(user, "Someone has gotten to the metal before you.");
		return(0x00);
	}
	if (!testSkill(user, 0x2D)) {
		systemMessage(user, "You loosen some rocks but fail to find any useable ore.");
		return(0x00);
	}
	int Q65M;
	switch(Q56Z / 0x02) {
	case 0x00
		Q65M = 0x19B7;
		break;
	case 0x01
		Q65M = 0x19B8 + (0x02 * random(0x00, 0x01));
		Q56Z = 0x02;
		break;
	default
		Q65M = 0x19B9;
		Q56Z = 0x04;
		break;
	}
	obj ore = createNoResObjectAt(Q65M, getLocation(user));
	transferResources(ore, Q4D6, Q56Z, "metal");
	obj Q47G = getBackpack(user);
	if (canHold(Q47G, ore)) {
		systemMessage(user, "You dig some ore and put it in your backpack.");
		Q4Q1 = putObjContainer(ore, Q47G);
	} else {
		systemMessage(user, "You dig some ore and put it at your feet.");
	}
	if (Q46J(user, this)) {
		deleteObject(this);
	}
	return(0x00);
}
