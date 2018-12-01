inherits spelskil;

member int Q4W8;

trigger message("hitsomething") {
	obj caster = Q4RM(this);
	obj Q4U2 = args[0x00];
	if (caster == Q4U2) {
		Q4W8 = 0x01;
	}
	return(0x01);
}

trigger creation {
	shortCallback(this, 0x01, 0x2F);
	return(0x01);
}

function void Q41M(obj Q4P2, obj target, int Q463) {
	if (Q41L(Q4P2, target)) {
		sfx(getLocation(target), 0x0208, 0x00);
		obj caster = Q4RM(Q4P2);
		if ((Q4W8) || (target == caster)) {
			caster = NULL();
		} else {
			list Q5DT;
			appendToList(Q5DT, caster);
			messageToRange(getLocation(this), 0x04, "hitsomething", Q5DT);
		}
		Q556(target);
		int Q527 = Q427(NULL(), Q463, this, target, 0x04, 0x00);
	}
	return();
}

trigger enterrange(0x00) {
	Q41M(this, target, 0x04);
	callback(this, 0x01, 0x2F);
	return(0x01);
}

trigger callback(0x2F) {
	loc Q4VS = getLocation(this);
	list Q5HR;
	getMobsInRange(Q5HR, Q4VS, 0x00);
	for (int i = 0x00; i < numInList(Q5HR); i++) {
		obj target = Q5HR[i];
		Q41M(this, target, 0x02);
	}
	if (numInList(Q5HR) > 0x00) {
		callback(this, 0x01, 0x2F);
	} else {
		setObjVar(this, "defensive", 0x01);
	}
	return(0x01);
}
