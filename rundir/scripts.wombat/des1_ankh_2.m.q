inherits globals;

trigger use {
	int Q5L8 = random(0x01, 0x04);
	string Q4H1 = Q5L8;
	if (!hasObjVar(user, "usedDespiseLvlOneAnkh")) {
		setObjVar(user, "usedDespiseLvlOneAnkh", Q5L8);
		attachScript(user, "des1_ankh_user");
		doLocAnimation(getLocation(user), 0x373A, 0x01, 0x10, 0x00, 0x00);
		if ((Q5L8 == 0x01) || (Q5L8 == 0x04)) {
			setCurHP(user, getMaxHP(user));
			barkTo(user, user, "A sense of warmth fills your body!");
		}
		if ((Q5L8 == 0x02) || (Q5L8 == 0x04)) {
			setCurMana(user, getMaxMana(user));
			barkTo(user, user, "A feeling of power surges through your veins!");
		}
		if ((Q5L8 == 0x03) || (Q5L8 == 0x04)) {
			setCurFatigue(user, getMaxFatigue(user));
			barkTo(user, user, "You feel as though you've slept for days!");
		}
	}
	return(0x00);
}
