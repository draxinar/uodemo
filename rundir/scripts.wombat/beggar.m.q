inherits globals;

trigger enterrange(0x03) {
	if (isDead(target)) {
		return(0x01);
	}
	if (isPlayer(target)) {
		int Q5IR;
		if (hasObjVar(target, "guildMember")) {
			Q5IR = getObjVar(this, "guildMember");
		}
		if (Q5IR == 0x03) {
			return(0x01);
		} else {
			if (canSeeObj(this, target)) {
				obj lastFollowed;
				if (hasObjVar(this, "lastFollowed")) {
					lastFollowed = getObjVar(this, "lastFollowed");
				}
				if (lastFollowed != target) {
					loc Q484 = getLocation(this);
					loc Q5YL = getLocation(target);
					int Q4ID = getDirectionInternal(Q484, Q5YL);
					faceHere(this, Q4ID);
					bark(this, "Spare some gold friend?");
					followNpc(this, target, 0x08);
					callback(this, 0x0F, 0x1B);
					setObjVar(this, "lastFollowed", target);
				}
			}
		}
	}
	return(0x01);
}

trigger sawdeath {
	if (hasObjVar(this, "lastFollowed")) {
		obj lastFollowed = getObjVar(this, "lastFollowed");
		if (victim == lastFollowed) {
			stopFollowing(this);
		}
	}
	return(0x01);
}

trigger callback(0x1B) {
	if (!hasObjVar(this, "lastFollowed")) {
		return(0x01);
	}
	obj victim = getObjVar(this, "lastFollowed");
	obj Q52I = getLeader(this);
	if (Q52I == NULL()) {
		return(0x00);
	}
	if (!isValid(victim) || (getDistanceInTiles(getLocation(this), getLocation(victim)) > 0x12)) {
		return(0x00);
	}
	int Q5L6 = random(0x01, 0x04);
	switch(Q5L6) {
	case 0x01
		barkTo(this, victim, "Just a few coins.");
		break;
	case 0x02
		barkTo(this, victim, "Surely thou can spare something.");
		break;
	case 0x03
		barkTo(this, victim, "I haven't eaten in days.");
		break;
	case 0x04
		barkTo(this, victim, "I have children to feed.");
		break;
	case 0x05
		barkTo(this, victim, "");
		break;
	case 0x06
		barkTo(this, victim, "");
		break;
	case 0x07
		barkTo(this, victim, "");
		break;
	case 0x08
		barkTo(this, victim, "");
		break;
	}
	callback(this, 0x0F, 0x1B);
	return(0x00);
}
