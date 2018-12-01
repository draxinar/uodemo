inherits spelskil;

function int Q4MF(obj user) {
	int Q5NC = 0x00;
	int Q4NC;
	loc Q4VS = getLocation(user);
	list Q4F6 = 0x029E, 0x028C, 0x028D, 0x028E, 0x028F, 0x0290, 0x0291, 0x0292, 0x0293, 0x0294, 0x0295, 0x0296, 0x0297, 0x0298, 0x0299, 0x029B, 0x029C, 0x029D;
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
		int Q4D5 = random(0x00, 0x11);
		obj Q4F3 = createGlobalNPCAt(Q4F6[Q4D5], there, 0x00);
		if (Q4F3 != NULL()) {
			doLocAnimation(there, 0x3728, 0x0A, 0x0A, 0x00, 0x00);
			sfx(there, 0x0215, 0x00);
			attachScript(Q4F3, "destcrea");
			setObjVar(Q4F3, "summonDifficulty", 0x00);
			int Q5ND = Q558(Q4F3, user, 0x64, 0x01);
			callback(Q4F3, Q4NC, 0x08);
			Q5NC = 0x01;
		} else {
			barkTo(user, user, "Whoops...something got in the way.");
		}
	}
	Q5UQ(this);
	return(Q5NC);
}
