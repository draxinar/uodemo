inherits globals;

trigger creation {
	
member obj victim = getObjVar(this, "beggingVictim");
	removeObjVar(this, "beggingVictim");
	
member obj beggar = getObjVar(this, "beggingBeggar");
	removeObjVar(this, "beggingBeggar");
	return(0x00);
}

function void Q4IX(obj beggar, obj victim) {
	removeObjVar(this, "beggingVictim");
	removeObjVar(this, "beggingBeggar");
	int Q45Y = getMoney(victim) / 0x0A;
	if (Q45Y > 0x0A) {
		Q45Y = 0x0A;
	}
	if (!getCompileFlag(0x01)) {
		Q45Y = Q45Y + (getNotoriety(beggar) / 0x0A);
	} else {
		int mod = Q45Y + getAdjKarma(beggar) / 0x07D0;
		Q45Y = Q45Y + mod;
	}
	if (Q45Y < 0x01) {
		bark(victim, "Thou dost not look trustworthy... no gold for thee today!");
		return();
	}
	if (Q45Y > getMoney(victim)) {
		bark(victim, "I have not enough money to give thee any!");
		return();
	}
	obj Q606 = transferGenericToContainer(this, victim, 0x0EED, Q45Y);
	if (Q606 == NULL()) {
		bark(victim, "I have not enough money to give thee any!");
		return();
	}
	obj Q4Q1 = giveItem(beggar, Q606);
	if (Q4Q1 == NULL()) {
		bark(victim, "I have not enough money to give thee any!");
		return();
	}
	string Q496 = "Here, have ");
	string Q463 = Q45Y;
	concat(Q496, Q463);
	concat(Q496, " gold coin");
	if (Q45Y > 0x01) {
		concat(Q496, "s.");
	} else {
		concat(Q496, ".");
	}
	toUpper(Q496, 0x00, 0x01);
	bark(beggar, Q496);
	if (Q4Q1 == NULL()) {
		int bar = teleport(Q606, getLocation(beggar));
	}
	detachScript(this, "beggingpathfind");
	return();
}

trigger pathfound(0x12) {
	bark(this, "Let me see...");
	Q4IX(this, victim);
	return(0x00);
}

trigger pathnotfound(0x12) {
	bark(this, "I dare not approach thee too closely, lest others think me an easy mark...");
	Q4IX(this, victim);
	return(0x00);
}
