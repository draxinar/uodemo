inherits sk_table;

trigger message("canUseSkill") {
	return(0x00);
}

trigger callback(0x4D) {
	detachScript(this, "evaluate");
	return(0x00);
}

trigger message("useSkill") {
	callback(this, 0x0A, 0x4D);
	systemMessage(this, "What would you like to evaluate?");
	targetObj(this, this);
	return(0x00);
}

trigger targetobj {
	if (usedon == NULL()) {
		return(0x00);
	}
	if (!isMobile(usedon)) {
		return(0x00);
	}
	if (usedon == user) {
		barkTo(user, user, "Hmm, that person looks really silly.");
		return(0x00);
	}
	loc Q4VS = getLocation(user);
	loc there = getLocation(usedon);
	if (getDistanceInTiles(Q4VS, there) > 0x08) {
		return(0x00);
	}
	int skill = getSkillLevel(user, 0x10);
	int Q5TU = getIntelligence(usedon);
	skill = 0x64 - skill;
	skill = skill / 0x05;
	Q5TU = random(Q5TU - skill, Q5TU + skill);
	string Q496;
	if (!skillTest(user, 0x10)) {
		Q496 = "You cannot quite judge ");
		concat(Q496, getHisHer(usedon));
		concat(Q496, " mental abilities.");
		barkTo(user, user, Q496);
		return(0x00);
	}
	handleWatchingSkill(user, 0x10);
	Q5TU = Q5TU / 0x0A;
	Q496 = "slightly less intelligent than a rock";
	if (Q5TU == 0x01) {
		Q496 = "fairly stupid";
	}
	if (Q5TU == 0x02) {
		Q496 = "not the brightest";
	}
	if (Q5TU == 0x03) {
		Q496 = "about average";
	}
	if (Q5TU == 0x04) {
		Q496 = "moderately intelligent";
	}
	if (Q5TU == 0x05) {
		Q496 = "very intelligent";
	}
	if (Q5TU == 0x06) {
		Q496 = "extremely intelligent";
	}
	if (Q5TU == 0x07) {
		Q496 = "extraordinarily intelligent";
	}
	if (Q5TU == 0x08) {
		Q496 = "like a formidable intellect, well beyond even the extraordinary";
	}
	if (Q5TU == 0x09) {
		Q496 = "like a definite genius";
	}
	if (Q5TU > 0x09) {
		Q496 = "superhumanly intelligent in a manner you cannot comprehend";
	}
	string Q497 = getHeShe(usedon);
	toUpper(Q497, 0x00, 0x01);
	concat(Q497, " looks ");
	concat(Q497, Q496);
	concat(Q497, ".");
	barkTo(usedon, user, Q497);
	return(0x00);
}
