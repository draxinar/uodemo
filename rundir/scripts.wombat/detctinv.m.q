inherits spelskil;

function void Q4JG(obj user, loc place) {
	loc Q4VS = getLocation(user);
	faceHere(user, getDirectionInternal(Q4VS, place));
	int Q5VE = getSkillLevelReal(user, 0x19);
	int Q4B3 = dice(0x01, 0x03E8);
	if (Q4B3 < Q5VE) {
		list Q4YN;
		getMobsInRange(Q4YN, place, 0x02);
		for (int x = 0x00; x < numInList(Q4YN); x++) {
			if (hasScript(Q4YN[x], "reminvis")) {
				doMobAnimation(Q4YN[x], 0x376A, 0x09, 0x28, 0x00, 0x00);
			}
		}
		list Q4YM;
		getObjectsInRange(Q4YM, place, 0x02);
		for (int y = 0x00; y < numInList(Q4YM); y++) {
			if (hasScript(Q4YM[y], "reminvis")) {
				doLocAnimation(getLocation(Q4YM[y]), 0x376A, 0x09, 0x14, 0x00, 0x00);
			}
		}
	}
	int Q4B0 = dice(0x01, 0x03E8);
	if ((0x03E8 - Q5VE) < Q4B0) {
		int Q4Y0 = dice(0x0A, 0x3C);
		if ((Q4Y0 + Q5VE) < 0x03E8) {
			addSkillLevel(user, 0x0E, Q4Y0);
		} else {
			setSkillLevel(user, 0x0E, 0x03E8);
		}
	}
	return();
}

trigger use {
	targetLoc(user, this);
	return(0x00);
}

trigger targetloc {
	if (!isInMap(place)) {
		return(0x00);
	}
	Q4JG(user, place);
	return(0x00);
}
