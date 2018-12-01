inherits spelskil;

function int Q46G(loc place, int range) {
	list Q5FJ;
	getObjectsInRange(Q5FJ, place, range);
	int num = numInList(Q5FJ);
	for (int i = 0x00; i < num; i++) {
		obj it = Q5FJ[i];
		if (isMultiComp(it)) {
			return(0x01);
		}
	}
	return(0x00);
}

function loc Q4TC(obj user, loc place) {
	loc Q4OT = 0x00, 0x00, (0x00 - 0x80);
	if (!isInMap(place)) {
		return(Q4OT);
	}
	int Q4OU = 0x00;
	if (getDistanceInTiles(getLocation(user), place) > 0x0B) {
		systemMessage(user, "That location is too far away");
		Q4OU = 0x01;
	}
	if (!Q4OU && (getEncumbrance(user) > 0x64)) {
		systemMessage(user, "Thou art too encumbered to move.");
		Q4OU = 0x01;
	}
	if (!Q4OU && (canSeeLoc(user, place) != 0x01)) {
		systemMessage(user, "Target cannot be seen.");
		Q4OU = 0x01;
	}
	if (!Q4OU) {
		loc target = place;
		list Q5HS;
		getMobsAt(Q5HS, target);
		int Q4XW = getHeight(user);
		int Q48V = getZ(target);
		int Q63L = Q48V + 0x08;
		int Q4U1 = findGoodZ(target, Q48V, Q63L, Q4XW, 0x01);
		setZ(target, Q4U1);
		if (Q4U1 == (0x00 - 0x80)) {
			systemMessage(user, "Cannot teleport to that spot.");
			return(Q4OT);
		}
		if ((0x07 == canExistAt(target, Q4XW, 0x01)) && (!Q4ZQ(target))) {
			if (0x00 == numInList(Q5HS)) {
				if (Q46G(target, 0x05)) {
					systemMessage(user, "Cannot teleport to that spot.");
					return(Q4OT);
				}
				return(target);
			} else {
				systemMessage(user, "Someone is standing there!");
				return(Q4OT);
			}
		} else {
			systemMessage(user, "Cannot teleport to that spot.");
			return(Q4OT);
		}
	}
	return(Q4OT);
}

function int Q4MM(obj user, loc there) {
	int Q5NC = 0x00;
	there = Q4TC(user, there);
	if (getZ(there) != (0x00 - 0x80)) {
		int Q4NA;
		loc Q4VS = getLocation(user);
		int Q5ZL = teleport(user, there);
		if (Q5ZL) {
			doLocAnimation(Q4VS, 0x3728, 0x0A, 0x0A, 0x00, 0x00);
			doLocAnimation(there, 0x3728, 0x0A, 0x0A, 0x00, 0x00);
			sfx(there, 0x01FE, 0x00);
			Q5NC = 0x01;
		} else {
			bark(user, "I can't teleport there!");
		}
	}
	Q5UQ(this);
	return(Q5NC);
}
