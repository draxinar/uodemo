trigger creation {
	overloadWeight(this, 0x02);
	if (isWeapon(this)) {
		int Q68O = 0x00;
		if (isSlashing(this)) {
			Q68O = 0x01;
		}
		if (isBashing(this)) {
			Q68O = 0x02;
		}
		if (isPiercing(this)) {
			Q68O = 0x03;
		}
		if (isRanged(this)) {
			Q68O = 0x04;
		}
		if (Q68O > 0x00) {
			int Q5Z4 = 0x3C + Q68O;
			int Q527 = applyWeaponTemplate(this, Q5Z4);
		}
		string Q5C2;
		Q5C2 = getWeaponName(this) + " (practice weapon)";
		setObjVar(this, "lookAtText", Q5C2);
	}
	return(0x01);
}
