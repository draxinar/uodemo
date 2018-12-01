trigger 0x03E8enterrange(0x07) {
	if (isPlayer(target)) {
		list args = 0x07;
		multimessage(target, "foundme", args);
	}
	return(0x01);
}

trigger gotattacked {
	if (isPlayer(attacker)) {
		list args = 0x07;
		multimessage(attacker, "usedme", args);
	}
	return(0x01);
}

trigger death {
	attachScript(corpse, 