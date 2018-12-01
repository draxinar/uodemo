inherits sndfx;

trigger message("canUseSkill") {
	return(0x00);
}

trigger callback(0x4D) {
	detachScript(this, "seance");
	return(0x00);
}

trigger message("useSkill") {
	callback(this, 0x0A, 0x4D);
	if (!skillTest(this, 0x20)) {
		systemMessage(this, "You fail your attempt at contacting the netherworld.");
		return(0x00);
	}
	systemMessage(this, "You establish contact with the netherworld.");
	sfx(getLocation(this), 0x024A, 0x00);
	int Q5QK = getSkillLevel(this, 0x20);
	Q5QK = (0x03 * Q5QK) + getIntelligence(this);
	setObjVar(this, "seance_setting", 0x01);
	seance(this, 0x01);
	attachScript(this, "seance_user");
	callback(this, Q5QK, 0x47);
	return(0x00);
}
