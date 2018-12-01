inherits spelskil;

member int count;

member list Q488;

function void Q4JU(obj Q486) {
	return();
}

function int Q50E(obj caster, obj victim) {
	if (!Q50H(caster, victim)) {
		return(0x00);
	}
	if (isGuard(victim)) {
		return(0x00);
	}
	return(0x01);
}

function int Q4JK(obj user) {
	int Q5NC = 0x00;
	loc Q4VS = getLocation(user);
	count = 0x00;
	sfx(Q4VS, 0x020D, 0x00);
	clearList(Q488);
	list Q5KB;
	getMobsInRange(Q5KB, Q4VS, 0x0A);
	for (int Q61N = 0x00; Q61N < numInList(Q5KB); Q61N++) {
		obj victim = Q5KB[Q61N];
		if (Q50G(victim)) {
			if (Q50E(user, victim)) {
				appendToList(Q488, victim);
			}
		}
	}
	obj Q68A;
	int Q45Y;
	int Q527;
	for (Q61N = 0x00; Q61N < numInList(Q488); Q61N++) {
		Q5NC = 0x01;
		Q68A = Q488[Q61N];
		Q45Y = getCurHP(Q68A) - (getMaxHP(Q68A) / 0x02);
		if (isNPC(Q68A)) {
			Q45Y = Q45Y / 0x04;
		}
		disableBehaviors(Q68A);
		Q4JU(Q68A);
		Q5UK(user, Q68A, 0x01, 0x00);
		if (Q45Y > 0x00) {
			Q527 = Q428(this, Q45Y, user, Q68A, 0x08, 0x00);
			Q5NC = 0x01;
		}
	}
	shortcallback(this, 0x02, 0x36);
	Q5UQ(this);
	return(0x01);
}

trigger callback(0x36) {
	obj Q692;
	if (count < 0x03) {
		for (int Q61N = 0x00; Q61N < numInList(Q488); Q61N++) {
			Q692 = Q488[Q61N];
			if (isValid(Q692)) {
				Q4JU(Q692);
			}
		}
		shortcallback(this, 0x02, 0x36);
		count++;
		return(0x00);
	} else {
		for (Q61N = 0x00; Q61N < numInList(Q488); Q61N++) {
			Q692 = Q488[Q61N];
			if (isValid(Q692)) {
				enableBehaviors(Q692);
			}
		}
	}
	Q5UQ(this);
	return(0x00);
}
