inherits itemmanip;

trigger use {
	if (isAtHome(this)) {
		systemMessage(user, "That ore belongs to someone else.");
		return(0x00);
	}
	if (hasObjVar(this, "inUse")) {
		systemMessage(user, "Someone is using that ore.");
		return(0x00);
	} else {
		setObjVar(this, "inUse", 0x01);
		attachscript(this, "removeinuse");
		callback(this, 0x1E, 0x1B);
	}
	int Q4Q1;
	int Q4YO;
	Q4Q1 = getResource(Q4YO, this, "metal", 0x03, 0x02);
	if (Q4YO > 0x04) {
		systemMessage(user, "Select the forge on which to smelt the ore, or another pile of ore with which to combine it.");
	} else {
		systemMessage(user, "Select another pile of ore with which to combine this.");
	}
	targetObj(user, this);
	return(0x00);
}

trigger targetobj {
	removeObjVar(this, "inUse");
	if (usedon == NULL()) {
		return(0x00);
	}
	if (getDistanceInTiles(getLocation(user), getLocation(usedon)) > 0x03) {
		systemMessage(user, "That is too far away.");
		return(0x00);
	}
	if (getDistanceInTiles(getLocation(this), getLocation(usedon)) > 0x03) {
		systemMessage(user, "The ore is too far away.");
		return(0x00);
	}
	if (!canSeeObj(user, usedon)) {
		systemMessage(user, "You can't see that.");
		return(0x00);
	}
	int Q4Q1;
	int Q4YO;
	Q4Q1 = getResource(Q4YO, this, "metal", 0x03, 0x02);
	int Q4Z5 = 0x00;
	int Q4ZU = 0x00;
	obj ore = this;
	int Q62A = getObjType(this);
	int Q66P = getObjType(usedon);
	if (Q66P == 0x0FB1) {
		Q4Z5 = 0x01;
	}
	if (Q66P >= 0x197A) {
		if (Q66P <= 0x19A9) {
			Q4Z5 = 0x01;
		}
	}
	if (Q66P > 0x19B6) {
		if (Q66P < 0x19BB) {
			Q4ZU = 0x01;
			if (isInContainer(this)) {
				obj Q61O = getTopmostContainer(this);
				int Q62E = getWeight(Q61O) + getWeight(usedon);
			}
			if (isInContainer(usedon)) {
				obj Q66Q = getTopmostContainer(usedon);
				int Q66T = getWeight(Q66Q) + getWeight(this);
			}
			if ((Q62E > 0x03E8) || (Q66T > 0x03E8)) {
				ebarkTo(user, user, "The weight is too great to combine in a container.");
				return(0x00);
			}
		}
	}
	if (Q4ZU) {
		ore = this;
		if (Q62A == 0x19B9) {
			Q4Q1 = getResource(Q4YO, ore, "metal", 0x03, 0x02);
			transferResources(usedon, ore, Q4YO, "metal");
		}
		if (Q62A == 0x19B8) {
			switch(Q66P) {
			case 0x19B9
			case 0x19B8
				Q4Q1 = getResource(Q4YO, usedon, "metal", 0x03, 0x02);
				transferResources(ore, usedon, Q4YO, "metal");
				break;
			case 0x19B7
			case 0x19BA
				Q4Q1 = getResource(Q4YO, ore, "metal", 0x03, 0x02);
				transferResources(usedon, ore, Q4YO, "metal");
				break;
			default
				return(0x00);
				break;
			}
		}
		if (Q62A == 0x19BA) {
			switch(Q66P) {
			case 0x19B9
			case 0x19B8
				Q4Q1 = getResource(Q4YO, usedon, "metal", 0x03, 0x02);
				transferResources(ore, usedon, Q4YO, "metal");
				break;
			case 0x19B7
			case 0x19BA
				Q4Q1 = getResource(Q4YO, ore, "metal", 0x03, 0x02);
				transferResources(usedon, ore, Q4YO, "metal");
				break;
			default
				return(0x00);
				break;
			}
		}
		if (Q62A == 0x19B7) {
			switch(Q66P) {
			case 0x19B9
			case 0x19B8
			case 0x19BA
				Q4Q1 = getResource(Q4YO, usedon, "metal", 0x03, 0x02);
				transferResources(ore, usedon, Q4YO, "metal");
				break;
			case 0x19B7
				Q4Q1 = getResource(Q4YO, ore, "metal", 0x03, 0x02);
				transferResources(usedon, ore, Q4YO, "metal");
				break;
			default
				return(0x00);
				break;
			}
		}
		Q4Q1 = getResource(Q4YO, ore, "metal", 0x03, 0x02);
		if (Q4YO < 0x01) {
			deleteObject(ore);
		}
		Q4Q1 = getResource(Q4YO, usedon, "metal", 0x03, 0x02);
		if (Q4YO < 0x01) {
			deleteObject(usedon);
		}
		if (hasObjVar(this, "inUse")) {
			removeObjVar(this, "inUse");
		}
		return(0x00);
	}
	if (Q4Z5) {
		obj Q47G = getBackpack(user);
		ore = this;
		int Q5GQ = getObjType(ore);
		int Q4Y6 = 0x1BF2;
		Q4Q1 = getResource(Q4YO, ore, "metal", 0x03, 0x02);
		int count = Q4YO / 0x02;
		if (count < 0x01) {
			systemMessage(user, "There is not enough metal-bearing ore in this pile to make an ingot.");
			if (hasObjVar(this, "inUse")) {
				removeObjVar(this, "inUse");
			}
			return(0x00);
		}
		if (testSkill(user, 0x2D)) {
			obj Q5BW = createNoResObjectIn(Q4Y6, Q47G);
			transferResources(Q5BW, ore, count, "metal");
			returnResourcesToBank(ore, count, "metal");
			Q4Q1 = putObjContainer(Q5BW, Q47G);
			Q4Q1 = getResource(Q4YO, ore, "metal", 0x03, 0x02);
			if (Q4YO < 0x01) {
				deleteObject(ore);
			}
			systemMessage(user, "You smelt the ore removing the impurities and put the metal in your backpack.");
		} else {
			if (count == 0x01) {
				systemMessage(user, "You burn away the impurities but are left with no useable metal.");
				deleteObject(ore);
				return(0x01);
			}
			returnResourcesToBank(ore, count, "metal");
			systemMessage(user, "You burn away the impurities but are left with less useable metal.");
			Q4Q1 = getResource(Q4YO, ore, "metal", 0x03, 0x02);
			if (Q4YO < 0x01) {
				deleteObject(ore);
			}
		}
	}
	return(0x01);
}

trigger callback(0x1B) {
	if (hasObjVar(this, "inUse")) {
		removeObjVar(this, "inUse");
	}
	return(0x01);
}
