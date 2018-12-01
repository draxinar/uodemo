inherits spelskil;

function void Q4IY(obj user, obj usedon) {
	int Q4NC;
	loc Q4VS = getLocation(user);
	loc there = getLocation(usedon);
	faceHere(user, getDirectionInternal(Q4VS, there));
	if (hasObjVar(this, "magicItemModifier")) {
		int Q52W = getObjVar(this, "magicItemModifier");
		Q4NC = 0x06 * Q52W;
	} else {
		Q4NC = 0x01 + (0x05 * (getSkillLevel(user, 0x19)));
	}
	sfx(there, 0x01E9, 0x00);
	openGump(usedon, 0x1392);
	attachScript(usedon, "rembirdi");
	callback(usedon, Q4NC, 0x2B);
	int Q47S = getObjType(this);
	callback(this, 0x00, 0x48);
	return();
}

trigger use {
	targetObj(user, this);
	return(0x00);
}

trigger targetobj {
	if (usedon == NULL()) {
		return(0x00);
	}
	if (Q5UM(user, usedon, 0x0C)) {
		if (!Q5YC(user, this)) {
			return(0x00);
		}
		if (Q4LT(user, getLocation(usedon), this)) {
			Q4IY(user, usedon);
		} else {
			Q4RD(user);
		}
	}
	return(0x00);
}

trigger creation {
	return(0x00);
}
