inherits sndfx;

trigger use {
	systemMessage(user, "What do you want to pick?");
	targetObj(user, this);
	return(0x00);
}

trigger targetobj {
	if (usedon == NULL()) {
		return(0x00);
	}
	if (!hasObjVar(usedon, "isLocked")) {
		systemMessage(user, "This does not appear to be locked.");
		return(0x00);
	}
	int Q53M = getObjVar(usedon, "isLocked");
	loc Q4VS = getLocation(user);
	loc there = getLocation(usedon);
	if (getDistanceInTiles(Q4VS, there) > 0x03) {
		bark(user, "I am too far away to do that.");
		return(0x00);
	}
	if (Q53M == 0x0100) {
		systemMessage(user, "You don't see how that lock can be manipulated.");
		return(0x00);
	}
	if (Q53M == 0x00) {
		systemMessage(user, "This lock cannot be picked by normal means...");
		return(0x00);
	}
	int Q5Z4 = skillTest(user, 0x18);
	int Q4AY = getSkillLevelRealStat(user, 0x18) / 0x04;
	int Q64O = getSkillLevelRealStat(user, 0x0E) / 0x04;
	int Q64P = 0x00;
	int Q64N = 0x00;
	int Q64M = 0x00;
	int Q5NX;
	int mod;
	if (hasObjVar(usedon, "trapLevel")) {
		Q64P = 0x01;
		int Q52T = getObjVar(usedon, "trapLevel");
		Q5NX = random(0x00, 0xFA);
		mod = Q52T * 0x0A;
		if (Q5NX < (Q64O - mod)) {
			Q64N = 0x01;
		} else {
			Q4AY = Q4AY / 0x05;
		}
	}
	list Q63G = user, usedon;
	if (Q64N) {
		Q5NX = random(0x00, 0xFA);
		mod = Q52T * 0x0A;
		if (Q5NX < (Q4AY - mod)) {
			barkTo(usedon, user, "You notice a trap and carefully disarm it.");
			message(usedon, "removeTrap", Q63G);
		} else {
			barkTo(usedon, user, "You fail to disable the trap.");
			Q4AY = 0x00;
		}
	}
	int Q541 = Q53M - 0x0A;
	if (Q541 < 0x00) {
		Q541 = 0x01;
	}
	int Q4QI = random(Q541, Q53M);
	if (Q4QI > Q4AY) {
		if (Q4QI >= (Q53M - 0x02)) {
			barkTo(usedon, user, "You broke the lockpick.");
			sfx(there, 0x013F, 0x00);
			destroyOne(this);
		}
		barkTo(usedon, user, "You are unable to pick the lock.");
		return(0x00);
	}
	sfx(there, 0x0241, 0x00);
	removeObjVar(usedon, "isLocked");
	barkTo(usedon, user, "The lock quickly yields to your skill.");
	if ((hasObjVar(usedon, "playerMade"))) {
		callback(usedon, 0x0258, 0x25);
	}
	return(0x00);
}
