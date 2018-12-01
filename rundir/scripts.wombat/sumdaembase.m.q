inherits spelskil;

function int Q4MG(obj user) {
	int Q5NC = 0x00;
	int Q4NC;
	loc Q4VS = getLocation(user);
	loc there = Q5I9(user);
	if (!isInMap(there)) {
		Q4RD(user);
		systemMessage(user, "There is no room to summon that here.");
	} else {
		faceHere(user, getDirectionInternal(Q4VS, there));
		if (hasObjVar(this, "magicItemModifier")) {
			int Q52W = getObjVar(this, "magicItemModifier");
			Q4NC = 0x06 * Q52W;
		} else {
			if (getSkillLevel(user, 0x19) < 0x0A) {
				Q4NC = 0x14;
			} else {
				Q4NC = 0x14 * getSkillLevel(user, 0x19) / 0x05;
			}
		}
		obj daemon = createGlobalNPCAt(0x0255, there, 0x00);
		if (daemon != NULL()) {
			doLocAnimation(there, 0x3728, 0x0A, 0x0A, 0x00, 0x00);
			doLocAnimation(there, 0x3728, 0x08, 0x14, 0x00, 0x00);
			sfx(there, 0x0216, 0x00);
			setType(daemon, 0x0A);
			attachScript(daemon, "destcrea");
			setObjVar(daemon, "summonDifficulty", 0x03B6);
			int Q5ND = Q558(daemon, user, 0x64, 0x01);
			callback(daemon, Q4NC, 0x08);
			changeKarma(user, (0x00 - 0x1B58));
			Q5NC = 0x01;
		} else {
			barkTo(user, user, "Whoops...something got in the way.");
		}
	}
	Q5UQ(this);
	return(Q5NC);
}
