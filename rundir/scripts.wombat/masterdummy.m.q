inherits sndfx;

trigger creation {
	int Q615 = getObjType(this);
	if ((Q615 > 0x1074) && (Q615 < 0x1078)) {
		setType(this, 0x1074);
	}
	if ((Q615 > 0x1070) && (Q615 < 0x1074)) {
		setType(this, 0x1070);
	}
	if ((Q615 > 0x1EC0) && (Q615 < 0x1EC3)) {
		setType(this, 0x1EC0);
	}
	if ((Q615 > 0x1EC3) && (Q615 < 0x1EC5)) {
		setType(this, 0x1EC3);
	}
	return(0x01);
}

trigger use {
	if (isDead(user)) {
		return(0x00);
	}
	if (hasObjVar(this, "isSwinging")) {
		int Q4CX = getObjType(this);
		if ((Q4CX == 0x1070) || (Q4CX == 0x1074) || (Q4CX == 0x1EC0) || (Q4CX == 0x1EC3)) {
			removeObjVar(this, "isSwinging");
		}
	}
	if (hasObjVar(this, "isSwinging")) {
		ebarkTo(this, user, "You have to wait until it stops swinging.");
		return(0x00);
	}
	setObjVar(this, "isSwinging", 0x01);
	callback(this, 0x03, 0x42);
	if (getDistanceInTiles(getLocation(this), getLocation(user)) > 0x01) {
		ebarkTo(this, user, "You are too far away to do that.");
		return(0x01);
	}
	faceHere(user, getDirectionInternal(getLocation(user), getLocation(this)));
	Q4CX = getObjType(this);
	if ((Q4CX == 0x1070) || (Q4CX == 0x1074)) {
		int Q56E;
		int Q476;
		list Q5TL;
		int Q4V3 = 0x01;
		obj weapon = getWeapon(user);
		if (weapon == NULL()) {
			appendToList(Q5TL, 0x2B);
			Q56E = 0x07;
			Q476 = 0x09;
		}
		if (getWeaponHandedness(weapon) == 0x04) {
			Q4V3 = 0x02;
		}
		if (isPiercing(weapon)) {
			appendToList(Q5TL, 0x2A);
			if (Q4V3 == 0x01) {
				Q56E = 0x07;
				Q476 = 0x0A;
			} else {
				Q56E = 0x07;
				Q476 = 0x0E;
			}
		}
		if (isBashing(weapon)) {
			appendToList(Q5TL, 0x29);
			if (Q4V3 == 0x01) {
				Q56E = 0x07;
				Q476 = 0x0B;
			} else {
				Q56E = 0x07;
				Q476 = 0x0C;
			}
		}
		if (isSlashing(weapon)) {
			appendToList(Q5TL, 0x28);
			if (Q4V3 == 0x01) {
				Q56E = 0x07;
				Q476 = 0x09;
			} else {
				Q56E = 0x07;
				Q476 = 0x0D;
			}
		}
		if (getItemAtSlot(user, 0x19) != NULL()) {
			Q56E = 0x05;
			if (Q4V3 == 0x01) {
				Q476 = 0x1A;
			} else {
				Q476 = 0x1D;
			}
		}
		if (isRanged(weapon)) {
			ebarkTo(this, user, "You can't practice ranged weapons on this.");
			return(0x01);
		}
		if (!isHuman(user)) {
			Q56E = 0x04;
			Q476 = random(0x04, 0x06);
		}
		animateMobile(user, Q476, Q56E, 0x01, 0x00, 0x00);
		int Q615 = getObjType(this);
		if (Q615 == 0x1070) {
			setType(this, 0x1071);
		}
		if (Q615 == 0x1074) {
			setType(this, 0x1075);
		}
		list Q5U7 = 0x013A, 0x013C, 0x013F, 0x0141, 0x0144, 0x0148;
		sfx(getLocation(this), Q5U7[random(0x00, 0x05)], 0x00);
		int Q4Q1;
		string debug;
		if (numInList(Q5TL) < 0x01) {
			return(0x01);
		}
		for (int i = 0x00; i < numInList(Q5TL); i++) {
			if (getSkillSuccessChance(user, Q5TL[i], 0x00, 0x32) >= 0x03E8) {
				ebarkTo(this, user, "Your skill cannot improve any further by simply practicing with a dummy.");
				callback(this, 0x03, 0x42);
				return(0x01);
			}
			Q4Q1 = testAndLearnSkill(user, Q5TL[i], 0x00, 0x32);
			if (!random(0x00, 0x09)) {
				Q4Q1 = testAndLearnSkill(user, 0x1B, 0x00, 0x32);
			}
		}
	}
	if ((Q4CX == 0x1EC0) || (Q4CX == 0x1EC3)) {
		if (getItemAtSlot(user, 0x19) != NULL()) {
			ebarkTo(this, user, "You can't practice on this while on horseback.");
			return(0x01);
		}
		if (!isHuman(user)) {
			return(0x01);
		}
		Q615 = getObjType(this);
		sfx(getLocation(this), 0x4F, 0x00);
		if (getSkillSuccessChance(user, 0x21, 0x00, 0x32) >= 0x03E8) {
			ebarkTo(this, user, "Your ability to steal cannot improve any further by simply practicing on a dummy.");
			callback(this, 0x03, 0x42);
			return(0x01);
		}
		if (testAndLearnSkill(user, 0x21, 0x00, 0x32) <= 0x00) {
			ebarkTo(this, user, "You carelessly bump the dip and start it swinging.");
			sfx(getLocation(this), 0x41, 0x00);
			sfx(getLocation(this), 0x41, 0x00);
			if (Q615 == 0x1EC0) {
				setType(this, 0x1EC1);
			}
			if (Q615 == 0x1EC3) {
				setType(this, 0x1EC4);
			}
		} else {
			ebarkTo(this, user, "You successfully avoid disturbing the dip while searching it.");
		}
	}
	loseFatigue(user, 0x02);
	return(0x01);
}

trigger callback(0x42) {
	removeObjVar(this, "isSwinging");
	int Q615 = getObjType(this);
	if ((Q615 > 0x1074) && (Q615 < 0x1078)) {
		setType(this, 0x1074);
	}
	if ((Q615 > 0x1070) && (Q615 < 0x1074)) {
		setType(this, 0x1070);
	}
	if ((Q615 > 0x1EC0) && (Q615 < 0x1EC3)) {
		setType(this, 0x1EC0);
	}
	if ((Q615 > 0x1EC3) && (Q615 < 0x1EC5)) {
		setType(this, 0x1EC3);
	}
	return(0x01);
}

trigger time("hour:**") {
	shortcallback(this, 0x01, 0x42);
	return(0x01);
}
