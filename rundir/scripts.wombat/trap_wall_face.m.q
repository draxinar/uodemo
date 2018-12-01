inherits sndfx;

member obj Q64Q;

trigger enterrange(0x00) {
	if (isDead(target)) {
		return(0x01);
	}
	Q64Q = target;
	list args;
	message(this, "activate", args);
	return(0x01);
}

trigger message("activate") {
	int Q62A = getObjType(this);
	loc Q61U = getLocation(this);
	if (!hasObjVar(this, "disarmed")) {
		switch(Q62A) {
		case 0x10F5
			doLocAnimation(Q61U, 0x10F6, 0x09, 0x10, 0x00, 0x00);
			break;
		case 0x10FC
			doLocAnimation(Q61U, 0x10FD, 0x09, 0x10, 0x00, 0x00);
			break;
		case 0x110F
			doLocAnimation(Q61U, 0x1110, 0x09, 0x10, 0x00, 0x00);
			break;
		default
			break;
		}
		sfx(Q61U, 0x54, 0x05);
		shortCallback(this, 0x02, 0x2F);
	}
	return(0x01);
}

trigger callback(0x2F) {
	loc Q61U = getLocation(this);
	list Q64R;
	getMobsInRange(Q64R, Q61U, 0x01);
	int Q5E4 = numInList(Q64R);
	for (int i = 0x00; i < Q5E4; i++) {
		int Q4GH = dice(0x03, 0x0F);
		obj victim = Q64R[i];
		sfx(Q61U, 0x42, 0x05);
		loseHP(victim, Q4GH);
	}
	return(0x00);
}
