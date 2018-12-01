inherits sndfx;

function int Q4SW(int Q52T) {
	return((Q52T - 0x01) * 0x03E8 / 0x07);
}

function void Q4J5(obj user, int Q68O) {
	int Q65M = getObjType(user);
	if (Q65M < 0xC8) {
		if (Q65M == 0x16) {
			animateMobile(user, 0x04 + Q68O - 0x01, 0x04, 0x01, 0x00, 0x00);
			return();
		}
		if ((Q65M != 0x18) && (Q65M != 0x09) && (Q65M != 0x0A) && (Q65M != 0x04)) {
			return();
		}
		switch(Q68O) {
		case 0x01
			animateMobile(user, 0x0C, 0x07, 0x01, 0x00, 0x00);
			break;
		case 0x02
		case 0x03
			animateMobile(user, 0x0D, 0x07, 0x01, 0x00, 0x00);
			break;
		}
	} else {
		if (Q65M >= 0x0190) {
			if (getItemAtSlot(user, 0x19) != NULL()) {
				return();
			}
			switch(Q68O) {
			case 0x01
				animateMobile(user, 0x10, 0x07, 0x01, 0x00, 0x00);
				break;
			case 0x02
			case 0x03
				animateMobile(user, 0x11, 0x06, 0x01, 0x00, 0x00);
				break;
			}
		}
	}
	return();
}

function int Q501(obj it) {
	int Q5F8 = getObjType(it);
	if ((Q5F8 < 0x1F2D) || (Q5F8 > 0x1F6C)) {
		return(0x00);
	}
	return(0x01);
}

function int Q505(obj it) {
	if (!isValid(it)) {
		return(0x00)}
	if (getObjType(it) == 0x0EFA) {
		return(0x01);
	}
	return(0x00);
}

function int Q4ZN(obj it) {
	if (Q501(it)) {
		obj container = containedBy(it);
		if (container == NULL()) {
			return(0x01);
		}
		if (!Q505(container)) {
			return(0x01);
		}
	}
	return(0x00);
}

function int isScroll() {
	return(Q4ZN(this));
}

function int Q41P(obj user, int Q4EF) {
	if (Q4EF > (getCurMana(user))) {
		barkToHued(user, user, 0x22, "Insufficient mana for this spell.");
		return(0x00);
	}
	return(0x01);
}

function int Q4T2(obj it) {
	int num = getMiscData(it) - 0x01;
	return(num);
}

function int Q4SZ(int Q5UX) {
	return(Q5UX + 0x01);
}

function int Q42S(obj Q4XN) {
	int Q5US = 0x02;
	if (Q501(Q4XN)) {
		Q5US = (Q4T2(Q4XN) / 0x08) + 0x01;
	}
	return(Q5US);
}

function int Q4SY(int num) {
	return((num / 0x08) + 0x01);
}

function int Q4SX(int Q52T) {
	int Q4EF = 0x00;
	switch(Q52T) {
	case 0x01
		Q4EF = 0x04;
		break;
	case 0x02
		Q4EF = 0x06;
		break;
	case 0x03
		Q4EF = 0x09;
		break;
	case 0x04
		Q4EF = 0x0B;
		break;
	case 0x05
		Q4EF = 0x0E;
		break;
	case 0x06
		Q4EF = 0x14;
		break;
	case 0x07
		Q4EF = 0x28;
		break;
	case 0x08
		Q4EF = 0x32;
		break;
	}
	return(Q4EF);
}

function int Q4ZA(obj it) {
	if (it == NULL()) {
		return(0x01);
	}
	if (Q505(it)) {
		return(0x01);
	}
	return(0x00);
}

function int Q49Q(obj user, int Q55B) {
	obj rightHand = getItemAtSlot(user, 0x01);
	obj leftHand = getItemAtSlot(user, 0x02);
	if (!Q4ZA(rightHand)) {
		barkToHued(user, user, 0x22, "Your hands must be free to cast spells.");
		return(0x00);
	}
	if (getCompileFlag(0x01)) {
		if (!Q4ZA(leftHand)) {
			barkToHued(user, user, 0x22, "Your hands must be free to cast spells.");
			return(0x00);
		}
	} else {
		if ((!isUsingVirtueShield(user)) && (!Q4ZA(leftHand))) {
			barkToHued(user, user, 0x22, "Your hands must be free to cast spells.");
			return(0x00);
		}
	}
	if (!Q41P(user, Q55B)) {
		barkToHued(user, user, 0x22, "Not enough mana to cast this spell.");
		return(0x00);
	}
	if (isDead(user)) {
		return(0x00);
	}
	return(0x01);
}

function int Q49R(obj user, loc usedon, int Q55B) {
	loc Q671 = getLocation(user);
	if ((!areSpellsOkay(usedon)) || (!areSpellsOkay(Q671))) {
		barkToHued(user, user, 0x22, "You can not cast spells here.");
		return(0x00);
	}
	return(Q49Q(user, Q55B));
}

function int Q4LU(obj user, loc usedon, int Q5UX, int Q50V) {
	if (isPlayer(user)) {
		if (hasObjVar(user, "spellCastersLevel")) {
			removeObjVar(user, "spellCastersLevel");
		}
	}
	Q662(user, 0x00);
	int Q5US = Q4SY(Q5UX);
	int Q55B = Q4SX(Q5US);
	if (!Q49R(user, usedon, Q55B)) {
		return(0x00);
	}
	int Q5TG = 0x00;
	if (Q50V) {
		Q5TG = 0x02;
	}
	int Q4IB = Q4SW(Q5US - Q5TG);
	if (testAndLearnSkill(user, 0x19, Q4IB, 0x28) <= 0x00) {
		return(0x00);
	}
	loseMana(user, Q55B);
	return(0x01);
}

function int Q4LT(obj user, loc usedon, obj Q5UY) {
	int Q50V = Q4ZN(Q5UY);
	int Q5UX = Q4T2(Q5UY);
	return(Q4LU(user, usedon, Q5UX, Q50V));
}

function int Q5YB(obj user, list Q5BD) {
	int Q5LS = 0x00;
	int Q526 = 0x00;
	for (int Q4CK = 0x00; (Q4CK < numInList(Q5BD)) && (Q526 == 0x00); Q4CK++) {
		Q5LS = Q5BD[Q4CK];
		if (getGeneric(user, Q5LS) <= 0x00) {
			Q526 = 0x01;
			break;
		}
	}
	if (Q526 == 0x01) {
		if (isPlayer(user)) {
			barkToHued(user, user, 0x22, "More reagents are needed for this spell.");
		}
		return(0x00);
	} else {
		for (int Q4SK = 0x00; Q4SK < numInList(Q5BD); Q4SK++) {
			Q5LS = Q5BD[Q4SK];
			destroyGeneric(user, Q5LS, 0x01);
		}
		return(0x01);
	}
	if (isPlayer(user)) {
		bark(user, "BUG! Please report: Invalid takeReagent return.");
	}
	return(0x00);
}

function void Q4RD(obj user) {
	if (isPlayer(user)) {
		barkTo(user, user, "The spell fizzles.");
	}
	doMobAnimation(user, 0x3735, 0x06, 0x1E, 0x00, 0x00);
	sfx(getLocation(user), 0x5C, 0x00);
	return();
}

function obj Q4ES(int Q5F8, loc place) {
	int Q4XW = getTileHeight(Q5F8);
	int Q5JN = getZ(place) + 0x10;
	int Q5BH = getZ(place) - 0x10;
	setZ(place, findGoodZ(place, Q5BH, Q5JN, Q4XW, 0x01));
	if (getZ(place) != (0x00 - 0x80)) {
		return(createGlobalObjectAt(Q5F8, place));
	}
	return(NULL());
}

function int Q46K(loc where, int Q4VQ) {
	list Q5FJ;
	int Q57E = getZ(where);
	int Q56I = Q57E + Q4VQ;
	getObjectsAtInZRange(Q5FJ, where, Q57E, Q56I);
	int num = numInList(Q5FJ);
	obj it;
	for (int i = 0x00; i < num; i++) {
		it = Q5FJ[i];
		if (hasScript(it, "crtwall")) {
			return(0x01);
		}
	}
	return(0x00);
}

function obj Q4EQ(int Q5F8, loc place) {
	int Q4XW = getTileHeight(Q5F8);
	int Q5JN = getZ(place) + 0x10;
	int Q5BH = getZ(place) - 0x10;
	setZ(place, findGoodZ(place, Q5BH, Q5JN, Q4XW, 0x01));
	if (getZ(place) != (0x00 - 0x80)) {
		if (!Q46K(place, Q4XW)) {
			return(createGlobalObjectAt(Q5F8, place));
		}
	}
	return(NULL());
}

function void Q4SL(list Q5LQ, int Q5UT) {
	switch(Q5UT) {
	case 0x00
		Q5LQ = 0x0F7B, 0x0F88;
		break;
	case 0x01
		Q5LQ = 0x0F84, 0x0F85, 0x0F86;
		break;
	case 0x02
		Q5LQ = 0x0F85, 0x0F88;
		break;
	case 0x03
		Q5LQ = 0x0F84, 0x0F85, 0x0F8D;
		break;
	case 0x04
		Q5LQ = 0x0F7A, 0x0F88;
		break;
	case 0x05
		Q5LQ = 0x0F8D, 0x0F8C;
		break;
	case 0x06
		Q5LQ = 0x0F84, 0x0F8C, 0x0F8D;
		break;
	case 0x07
		Q5LQ = 0x0F84, 0x0F88;
		break;
	case 0x08
		Q5LQ = 0x0F7B, 0x0F86;
		break;
	case 0x09
		Q5LQ = 0x0F86, 0x0F88;
		break;
	case 0x0A
		Q5LQ = 0x0F84, 0x0F85;
		break;
	case 0x0B
		Q5LQ = 0x0F88, 0x0F8D;
		break;
	case 0x0C
		Q5LQ = 0x0F84, 0x0F8C, 0x0F8D;
		break;
	case 0x0D
		Q5LQ = 0x0F7B, 0x0F8C;
		break;
	case 0x0E
		Q5LQ = 0x0F84, 0x0F85, 0x0F8C;
		break;
	case 0x0F
		Q5LQ = 0x0F86, 0x0F88;
		break;
	case 0x10
		Q5LQ = 0x0F84, 0x0F86;
		break;
	case 0x11
		Q5LQ = 0x0F7A, 0x0F8C;
		break;
	case 0x12
		Q5LQ = 0x0F8C, 0x0F7B, 0x0F84;
		break;
	case 0x13
		Q5LQ = 0x0F88;
		break;
	case 0x14
		Q5LQ = 0x0F7B, 0x0F86;
		break;
	case 0x15
		Q5LQ = 0x0F7B, 0x0F86;
		break;
	case 0x16
		Q5LQ = 0x0F7B, 0x0F8C;
		break;
	case 0x17
		Q5LQ = 0x0F7B, 0x0F84;
		break;
	case 0x18
		Q5LQ = 0x0F84, 0x0F85, 0x0F86;
		break;
	case 0x19
		Q5LQ = 0x0F84, 0x0F85, 0x0F86, 0x0F8C;
		break;
	case 0x1A
		Q5LQ = 0x0F84, 0x0F88, 0x0F8C;
		break;
	case 0x1B
		Q5LQ = 0x0F7A, 0x0F8D, 0x0F8C;
		break;
	case 0x1C
		Q5LQ = 0x0F84, 0x0F85, 0x0F86, 0x0F8D;
		break;
	case 0x1D
		Q5LQ = 0x0F7A, 0x0F86, 0x0F8C;
		break;
	case 0x1E
		Q5LQ = 0x0F7A, 0x0F86, 0x0F8D;
		break;
	case 0x1F
		Q5LQ = 0x0F7A, 0x0F7B, 0x0F86;
		break;
	case 0x20
		Q5LQ = 0x0F7A, 0x0F86, 0x0F88;
		break;
	case 0x21
		Q5LQ = 0x0F84, 0x0F7A, 0x0F8D, 0x0F8C;
		break;
	case 0x22
		Q5LQ = 0x0F7B, 0x0F84, 0x0F88;
		break;
	case 0x23
		Q5LQ = 0x0F84, 0x0F86, 0x0F8D;
		break;
	case 0x24
		Q5LQ = 0x0F7A, 0x0F86, 0x0F88, 0x0F8C;
		break;
	case 0x25
		Q5LQ = 0x0F84, 0x0F86, 0x0F8D;
		break;
	case 0x26
		Q5LQ = 0x0F7A, 0x0F88, 0x0F8D;
		break;
	case 0x27
		Q5LQ = 0x0F7B, 0x0F86, 0x0F8D;
		break;
	case 0x28
		Q5LQ = 0x0F84, 0x0F86, 0x0F8C;
		break;
	case 0x29
		Q5LQ = 0x0F7A, 0x0F88;
		break;
	case 0x2A
		Q5LQ = 0x0F7A, 0x0F86, 0x0F8C;
		break;
	case 0x2B
		Q5LQ = 0x0F7B, 0x0F88;
		break;
	case 0x2C
		Q5LQ = 0x0F7A, 0x0F7B, 0x0F86;
		break;
	case 0x2D
		Q5LQ = 0x0F84, 0x0F86, 0x0F88, 0x0F8C;
		break;
	case 0x2E
		Q5LQ = 0x0F7A, 0x0F85, 0x0F8D;
		break;
	case 0x2F
		Q5LQ = 0x0F7B, 0x0F8C;
		break;
	case 0x30
		Q5LQ = 0x0F7A, 0x0F7B, 0x0F86, 0x0F8C;
		break;
	case 0x31
		Q5LQ = 0x0F7A, 0x0F86, 0x0F8D, 0x0F8C;
		break;
	case 0x32
		Q5LQ = 0x0F8D, 0x0F8C;
		break;
	case 0x33
		Q5LQ = 0x0F7A, 0x0F86, 0x0F8C;
		break;
	case 0x34
		Q5LQ = 0x0F86, 0x0F7A, 0x0F7B, 0x0F8D;
		break;
	case 0x35
		Q5LQ = 0x0F7A, 0x0F84, 0x0F86, 0x0F8C;
		break;
	case 0x36
		Q5LQ = 0x0F7B, 0x0F8D, 0x0F86, 0x0F8C;
		break;
	case 0x37
		Q5LQ = 0x0F7B, 0x0F86, 0x0F8D;
		break;
	case 0x38
		Q5LQ = 0x0F7B, 0x0F85, 0x0F86, 0x0F8C;
		break;
	case 0x39
		Q5LQ = 0x0F7A, 0x0F7B, 0x0F86, 0x0F88;
		break;
	case 0x3A
		Q5LQ = 0x0F7B, 0x0F84, 0x0F85;
		break;
	case 0x3B
		Q5LQ = 0x0F7B, 0x0F86, 0x0F8D;
		break;
	case 0x3C
		Q5LQ = 0x0F7B, 0x0F86, 0x0F8D, 0x0F8C;
		break;
	case 0x3D
		Q5LQ = 0x0F7B, 0x0F86, 0x0F8D;
		break;
	case 0x3E
		Q5LQ = 0x0F7B, 0x0F86, 0x0F8D, 0x0F8C;
		break;
	case 0x3F
		Q5LQ = 0x0F7B, 0x0F86, 0x0F8D;
		break;
	}
	return();
}

function string Q4T5(int Q5UT) {
	string name;
	switch(Q5UT) {
	case 0x00
		name = "Uus Jux";
		break;
	case 0x01
		name = "In Mani Ylem";
		break;
	case 0x02
		name = "Rel Wis";
		break;
	case 0x03
		name = "In Mani";
		break;
	case 0x04
		name = "In Por Ylem";
		break;
	case 0x05
		name = "In Lor";
		break;
	case 0x06
		name = "Flam Sanct";
		break;
	case 0x07
		name = "Des Mani";
		break;
	case 0x08
		name = "Ex Uus";
		break;
	case 0x09
		name = "Uus Wis";
		break;
	case 0x0A
		name = "An Nox";
		break;
	case 0x0B
		name = "An Mani";
		break;
	case 0x0C
		name = "In Jux";
		break;
	case 0x0D
		name = "An Jux";
		break;
	case 0x0E
		name = "Uus Sanct";
		break;
	case 0x0F
		name = "Uus Mani";
		break;
	case 0x10
		name = "Rel Sanct";
		break;
	case 0x11
		name = "Vas Flam";
		break;
	case 0x12
		name = "An Por";
		break;
	case 0x13
		name = "In Nox";
		break;
	case 0x14
		name = "Ort Por Ylem";
		break;
	case 0x15
		name = "Rel Por";
		break;
	case 0x16
		name = "Ex Por";
		break;
	case 0x17
		name = "In Sanct Ylem";
		break;
	case 0x18
		name = "Vas An Nox";
		break;
	case 0x19
		name = "Vas Uus Sanct";
		break;
	case 0x1A
		name = "Des Sanct";
		break;
	case 0x1B
		name = "In Flam Grav";
		break;
	case 0x1C
		name = "In Vas Mani";
		break;
	case 0x1D
		name = "Por Ort Grav";
		break;
	case 0x1E
		name = "Ort Rel";
		break;
	case 0x1F
		name = "Kal Ort Por";
		break;
	case 0x20
		name = "In Jux Hur Ylem";
		break;
	case 0x21
		name = "An Grav";
		break;
	case 0x22
		name = "Kal In Ex";
		break;
	case 0x23
		name = "In Jux Sanct";
		break;
	case 0x24
		name = "Por Corp Wis";
		break;
	case 0x25
		name = "An Ex Por";
		break;
	case 0x26
		name = "In Nox Grav";
		break;
	case 0x27
		name = "Kal Xen";
		break;
	case 0x28
		name = "An Ort";
		break;
	case 0x29
		name = "Corp Por";
		break;
	case 0x2A
		name = "Vas Ort Flam";
		break;
	case 0x2B
		name = "An Lor Xen";
		break;
	case 0x2C
		name = "Kal Por Ylem";
		break;
	case 0x2D
		name = "Vas Des Sanct";
		break;
	case 0x2E
		name = "In Ex Grav";
		break;
	case 0x2F
		name = "Wis Quas";
		break;
	case 0x30
		name = "Vas Ort Grav";
		break;
	case 0x31
		name = "In Sanct Grav";
		break;
	case 0x32
		name = "Kal Vas Flam";
		break;
	case 0x33
		name = "Vas Rel Por";
		break;
	case 0x34
		name = "Ort Sanct";
		break;
	case 0x35
		name = "Vas An Ort";
		break;
	case 0x36
		name = "Flam Kal Des Ylem";
		break;
	case 0x37
		name = "Vas Ylem Rel";
		break;
	case 0x38
		name = "In Vas Por";
		break;
	case 0x39
		name = "Vas Corp Por";
		break;
	case 0x3A
		name = "An Corp";
		break;
	case 0x3B
		name = "Kal Vas Xen Hur";
		break;
	case 0x3C
		name = "Kal Vas Xen Corp";
		break;
	case 0x3D
		name = "Kal Vas Xen Ylem";
		break;
	case 0x3E
		name = "Kal Vas Xen Flam";
		break;
	case 0x3F
		name = "Kal Vas Xen An Flam";
		break;
	}
	return(name);
}

function string Q4T0(int Q5UT) {
	string name;
	switch(Q5UT) {
	case 0x00
		name = "Clumsy";
		break;
	case 0x01
		name = "Create Food";
		break;
	case 0x02
		name = "Feeblemind";
		break;
	case 0x03
		name = "Heal";
		break;
	case 0x04
		name = "Magic Arrow";
		break;
	case 0x05
		name = "Night Sight";
		break;
	case 0x06
		name = "Reactive Armor";
		break;
	case 0x07
		name = "Weaken";
		break;
	case 0x08
		name = "Agility";
		break;
	case 0x09
		name = "Cunning";
		break;
	case 0x0A
		name = "Cure";
		break;
	case 0x0B
		name = "Harm";
		break;
	case 0x0C
		name = "Magic Trap";
		break;
	case 0x0D
		name = "Magic Untrap";
		break;
	case 0x0E
		name = "Protection";
		break;
	case 0x0F
		name = "Strength";
		break;
	case 0x10
		name = "Bless";
		break;
	case 0x11
		name = "Fireball";
		break;
	case 0x12
		name = "Magic Lock";
		break;
	case 0x13
		name = "Poison";
		break;
	case 0x14
		name = "Telekinesis";
		break;
	case 0x15
		name = "Teleport";
		break;
	case 0x16
		name = "Unlock";
		break;
	case 0x17
		name = "Wall of Stone";
		break;
	case 0x18
		name = "Archcure";
		break;
	case 0x19
		name = "Archprotection";
		break;
	case 0x1A
		name = "Curse";
		break;
	case 0x1B
		name = "Fire Field";
		break;
	case 0x1C
		name = "Greater Heal";
		break;
	case 0x1D
		name = "Lightning";
		break;
	case 0x1E
		name = "Mana Drain";
		break;
	case 0x1F
		name = "Recall";
		break;
	case 0x20
		name = "Blade Spirits";
		break;
	case 0x21
		name = "Dispel Field";
		break;
	case 0x22
		name = "Incognito";
		break;
	case 0x23
		name = "Magic Reflection";
		break;
	case 0x24
		name = "Mind Blast";
		break;
	case 0x25
		name = "Paralyze";
		break;
	case 0x26
		name = "Poison Field";
		break;
	case 0x27
		name = "Summon Creature";
		break;
	case 0x28
		name = "Dispel";
		break;
	case 0x29
		name = "Energy Bolt";
		break;
	case 0x2A
		name = "Explosion";
		break;
	case 0x2B
		name = "Invisibility";
		break;
	case 0x2C
		name = "Mark";
		break;
	case 0x2D
		name = "Mass Curse";
		break;
	case 0x2E
		name = "Paralyze Field";
		break;
	case 0x2F
		name = "Reveal";
		break;
	case 0x30
		name = "Chain Lightning";
		break;
	case 0x31
		name = "Energy Field";
		break;
	case 0x32
		name = "Flamestrike";
		break;
	case 0x33
		name = "Gate Travel";
		break;
	case 0x34
		name = "Mana Vampire";
		break;
	case 0x35
		name = "Mass Dispel";
		break;
	case 0x36
		name = "Meteor Swarm";
		break;
	case 0x37
		name = "Polymorph";
		break;
	case 0x38
		name = "Earthquake";
		break;
	case 0x39
		name = "Energy Vortex";
		break;
	case 0x3A
		name = "Resurrection";
		break;
	case 0x3B
		name = "Summon Air Elemental";
		break;
	case 0x3C
		name = "Summon Daemon";
		break;
	case 0x3D
		name = "Summon Earth Elemental";
		break;
	case 0x3E
		name = "Summon Fire Elemental";
		break;
	case 0x3F
		name = "Summon Water Elemental";
		break;
	}
	return(name);
}

function string Q4SQ(int Q5UT) {
	string name;
	switch(Q5UT) {
	case 0x00
		name = "clumsy";
		break;
	case 0x01
		name = "creatfod";
		break;
	case 0x02
		name = "feblmind";
		break;
	case 0x03
		name = "heal";
		break;
	case 0x04
		name = "magarrow";
		break;
	case 0x05
		name = "nitesite";
		break;
	case 0x06
		name = "reactarm";
		break;
	case 0x07
		name = "weaken";
		break;
	case 0x08
		name = "agility";
		break;
	case 0x09
		name = "cunning";
		break;
	case 0x0A
		name = "cure";
		break;
	case 0x0B
		name = "harm";
		break;
	case 0x0C
		name = "magctrap";
		break;
	case 0x0D
		name = "mguntrap";
		break;
	case 0x0E
		name = "protect";
		break;
	case 0x0F
		name = "strength";
		break;
	case 0x10
		name = "bless";
		break;
	case 0x11
		name = "fireball";
		break;
	case 0x12
		name = "magclock";
		break;
	case 0x13
		name = "poison";
		break;
	case 0x14
		name = "telknsis";
		break;
	case 0x15
		name = "teleport";
		break;
	case 0x16
		name = "unlock";
		break;
	case 0x17
		name = "wallston";
		break;
	case 0x18
		name = "archcure";
		break;
	case 0x19
		name = "aprotect";
		break;
	case 0x1A
		name = "curse";
		break;
	case 0x1B
		name = "firefild";
		break;
	case 0x1C
		name = "grtheal";
		break;
	case 0x1D
		name = "lightng";
		break;
	case 0x1E
		name = "manadran";
		break;
	case 0x1F
		name = "recall";
		break;
	case 0x20
		name = "bldsprts";
		break;
	case 0x21
		name = "dsplfild";
		break;
	case 0x22
		name = "incognto";
		break;
	case 0x23
		name = "magrflct";
		break;
	case 0x24
		name = "mindblst";
		break;
	case 0x25
		name = "paralyze";
		break;
	case 0x26
		name = "posnfild";
		break;
	case 0x27
		name = "summoncr";
		break;
	case 0x28
		name = "dispel";
		break;
	case 0x29
		name = "nrgybolt";
		break;
	case 0x2A
		name = "exploson";
		break;
	case 0x2B
		name = "invis";
		break;
	case 0x2C
		name = "mark";
		break;
	case 0x2D
		name = "mascurse";
		break;
	case 0x2E
		name = "parafild";
		break;
	case 0x2F
		name = "reveal";
		break;
	case 0x30
		name = "chainltg";
		break;
	case 0x31
		name = "nrgyfild";
		break;
	case 0x32
		name = "flamstrk";
		break;
	case 0x33
		name = "gatetrvl";
		break;
	case 0x34
		name = "manavamp";
		break;
	case 0x35
		name = "massdspl";
		break;
	case 0x36
		name = "meteor";
		break;
	case 0x37
		name = "polymrph";
		break;
	case 0x38
		name = "earthquk";
		break;
	case 0x39
		name = "nrgyvrtx";
		break;
	case 0x3A
		name = "resurect";
		break;
	case 0x3B
		name = "sumaire";
		break;
	case 0x3C
		name = "sumdaem";
		break;
	case 0x3D
		name = "sumearth";
		break;
	case 0x3E
		name = "sumfire";
		break;
	case 0x3F
		name = "sumh2o";
		break;
	}
	return(name);
}

function int Q4T1(int num) {
	return((num / 0x08) + 0x01);
}

function int Q4T3(int num) {
	if ((num < 0x00) || (num > 0x3F)) {
		return(0x00 - 0x01);
	}
	int Q5NC;
	if (num == 0x06) {
		Q5NC = 0x1F2D;
	} else {
		if ((num >= 0x00) && (num <= 0x05)) {
			Q5NC = 0x1F2E + num;
		} else {
			Q5NC = 0x1F34 + num - 0x07;
		}
	}
	return(Q5NC);
}

function int Q4T4(int num) {
	return(Q4T3(num - 0x01));
}

function string Q4SR(int Q5UT) {
	return(Q4SQ(Q5UT - 0x01));
}

function int Q5YC(obj user, obj Q5UY) {
	if (Q4ZN(Q5UY)) {
		return(0x01);
	}
	list Q5LQ;
	Q4SL(Q5LQ, Q4T2(Q5UY));
	return(Q5YB(user, Q5LQ));
}

function int Q4NQ(obj user) {
	obj rightHand = getItemAtSlot(user, 0x01);
	obj leftHand = getItemAtSlot(user, 0x02);
	if (leftHand != NULL()) {
		if (isWeapon(leftHand)) {
			barkToHued(user, user, 0x22, "You must have a free hand to drink a potion.");
			return(0x00);
		}
		if (rightHand != NULL()) {
			barkToHued(user, user, 0x22, "You must have a free hand to drink a potion.");
			return(0x00);
		}
	}
	return(0x01);
}

function int Q558(obj Q487, obj boss, int Q54B, int Q5DC) {
	list myBoss = boss;
	setObjVar(Q487, "myBoss", myBoss);
	setObjVar(Q487, "myLoyalty", Q54B);
	if (Q5DC) {
		setObjVar(Q487, "isPet", 0x01);
	}
	makeBeelineFailPathfind(Q487, 0x01);
	disableBehaviors(Q487);
	attachScript(Q487, "pet");
	return(0x01);
}

function int Q42P(int damage) {
	int Q527 = damage * 0x19;
	if (Q527 > 0x03E8) {
		Q527 = 0x03E8;
	}
	return(Q527);
}

function int Q42Q(int Q52T) {
	int Q527 = Q52T * 0x32;
	if (Q527 > 0x03E8) {
		Q527 = 0x03E8;
	}
	return(Q527);
}

function int Q4BH(obj user, obj usedon, int damage) {
	if (isDead(usedon)) {
		return(0x00);
	}
	if (testAndLearnSkill(usedon, 0x1A, Q42P(damage), 0x32) > 0x00) {
		systemMessage(usedon, "You feel yourself resisting magical energy!");
		return((damage + 0x01) / 0x02);
	}
	return(damage);
}

function int Q4BI(obj user, obj usedon, int damage) {
	if (isDead(usedon)) {
		return(0x00);
	}
	if (Q5ZJ(usedon, 0x1A, Q42P(damage), 0x28) > 0x00) {
		systemMessage(usedon, "You feel yourself resisting magical energy!");
		return((damage + 0x01) / 0x02);
	}
	return(damage);
}

function int Q4CM(obj user, obj usedon, int Q52T) {
	if (isDead(usedon)) {
		return(0x00);
	}
	if (testAndLearnSkill(usedon, 0x1A, Q42Q(Q52T), 0x32) > 0x00) {
		systemMessage(usedon, "You feel yourself resisting magical energy!");
		return(0x01);
	}
	return(0x00);
}

function int Q4CN(obj user, obj usedon, int Q52T) {
	if (isDead(usedon)) {
		return(0x00);
	}
	if (Q5ZJ(usedon, 0x1A, Q42Q(Q52T), 0x28) > 0x00) {
		systemMessage(usedon, "You feel yourself resisting magical energy!");
		return(0x01);
	}
	return(0x00);
}

function void Q5UK(obj user, obj usedon, int num, int Q5NO) {
	if (user == usedon) {
		return();
	}
	obj Q49N = user;
	obj victim = usedon;
	if (Q5NO) {
		Q49N = usedon;
		victim = user;
	}
	if (getCompileFlag(0x01)) {
		if (!canBeFreelyAggressedBy(victim, Q49N)) {
			committedCrimeAt(Q49N, getLocation(victim), 0x01E0);
		}
	} else {
		callGuards(Q49N, getLocation(victim), num);
	}
	return();
}

function void Q5UL(obj user, loc where, int num, int Q5NO) {
	if (getCompileFlag(0x01)) {
		committedCrimeAt(user, where, 0x01E0);
	} else {
		callGuards(user, where, num);
	}
	return();
}

function int Q41X(obj user, obj target) {
	int Q5NC = 0x00;
	if (hasScript(target, "reflctor")) {
		Q5NC = 0x01;
	}
	return(Q5NC);
}

function int Q4Z7(obj it) {
	return(isHuman(it));
}

function int Q43E(obj Q5U8, obj target, int damage) {
	int Q5NH = damage;
	int Q5DD = 0x01;
	int Q5T9 = 0x00;
	if (Q5U8 != NULL()) {
		loc Q5TR = getLocation(Q5U8);
		Q5T9 = inJusticeRegion(Q5TR);
		if (isNPC(Q5U8)) {
			if (!Q4Z7(Q5U8)) {
				Q5DD = 0x00;
			}
		}
	}
	int Q637 = 0x00;
	if (target != NULL()) {
		loc Q639 = getLocation(target);
		Q637 = inJusticeRegion(Q639);
		if (isNPC(target)) {
			if (!Q4Z7(target)) {
				Q5DD = 0x00;
			}
		}
	}
	if (Q5DD && (Q5T9 || Q637)) {
		Q5NH = 0x00;
	}
	return(Q5NH);
}

function void Q422(obj Q5U8, obj target, int damage, int Q5NM) {
	int Q5CL = Q43E(Q5U8, target, damage);
	if (Q5NM) {
		doDamage(target, Q5U8, 0x00);
	}
	doDamage(Q5U8, target, Q5CL);
	return();
}

function void Q423(obj Q5U8, obj target, int damage, int Q65M, int Q5NM) {
	int Q5CL = Q43E(Q5U8, target, damage);
	if (Q5NM) {
		doDamage(target, Q5U8, 0x00);
	}
	doDamageType(Q5U8, target, Q5CL, Q65M);
	return();
}

function int Q41L(obj Q4P2, obj target) {
	if (isCounselor(target)) {
		return(0x00);
	}
	int Q5NC = 0x00;
	loc Q4P3 = getLocation(Q4P2);
	int Q6A1 = getZ(Q4P3);
	loc Q5YV = getLocation(target);
	int Q6A3 = getZ(Q5YV);
	int Q4HE = 0x08;
	if (Q6A3 >= Q6A1) {
		int Q63Q = Q6A1 + Q4HE;
		if (Q6A3 <= Q63Q) {
			Q5NC = 0x01;
		}
	}
	return(Q5NC);
}

function void Q41T(obj scroll, string Q5OL) {
	if (Q5OL == "") {
		return();
	}
	string Q5FL;
	int objtype = getObjType(scroll);
	Q5FL = objtype;
	if (!hasScript(scroll, Q5FL)) {
		attachScript(scroll, Q5FL);
	}
	if (!hasScript(scroll, Q5OL)) {
		attachScript(scroll, Q5OL);
	}
	if (hasScript(scroll, "magscroll")) {
		detachScript(scroll, "magscroll");
	}
	list Q5OO;
	getScripts(Q5OO, scroll);
	int Q5F0 = 0x00;
	int Q5EV = 0x00;
	int Q5ET = 0x00;
	int Q5EX = 0x00;
	int Q4QI = 0x00;
	int Q5EY = numInList(Q5OO);
	for (int i = 0x00; i < Q5EY; i++) {
		Q4QI = 0x00;
		string Q4GF = Q5OO[i];
		if (Q4GF == Q5OL) {
			Q5F0++;
			Q4QI = 0x01;
		}
		if (Q4GF == Q5FL) {
			Q5EV++;
			Q4QI = 0x01;
		}
		if (Q4GF == "vended") {
			Q5EX++;
			Q4QI = 0x01;
		}
		if (!Q4QI) {
			detachScript(scroll, Q4GF);
		}
	}
	return();
}

function void Q41U(obj scroll) {
	int Q57F = getMiscData(scroll);
	int objtype = getObjType(scroll);
	if (objtype != Q4T4(Q57F)) {
		deleteObject(scroll);
		return();
	}
	Q41T(scroll, Q4SR(Q57F));
	return();
}

function int Q4SS(int Q5VX, int Q463) {
	int num = 0x00;
	switch(Q5VX) {
	case 0x00
		if (Q463 > 0x00) {
			num = 0x01;
		} else {
			num = 0x02;
		}
		break;
	case 0x01
		if (Q463 > 0x00) {
			num = 0x03;
		} else {
			num = 0x04;
		}
		break;
	case 0x02
		if (Q463 > 0x00) {
			num = 0x05;
		} else {
			num = 0x06;
		}
		break;
	}
	return(num);
}

function string Q4T9(int Q5VX, int Q463) {
	string Q5OK;
	int num = Q4SS(Q5VX, Q463);
	switch(num) {
	case 0x01
		Q5OK = "strup";
		break;
	case 0x02
		Q5OK = "strdown";
		break;
	case 0x03
		Q5OK = "dexup";
		break;
	case 0x04
		Q5OK = "dexdown";
		break;
	case 0x05
		Q5OK = "intup";
		break;
	case 0x06
		Q5OK = "intdown";
		break;
	}
	return(Q5OK);
}

function int Q4T8(int Q5VX, int Q463) {
	int num = Q4SS(Q5VX, Q463);
	int Q5NC = 0x00;
	switch(num) {
	case 0x01
		Q5NC = 0x67;
		break;
	case 0x02
		Q5NC = 0x68;
		break;
	case 0x03
		Q5NC = 0x69;
		break;
	case 0x04
		Q5NC = 0x6A;
		break;
	case 0x05
		Q5NC = 0x6B;
		break;
	case 0x06
		Q5NC = 0x6C;
		break;
	}
	return(Q5NC);
}

function int Q432(obj user, int Q5VX, int Q463) {
	if (Q463 == 0x00) {
		return(0x00);
	}
	return(hasScript(user, Q4T9(Q5VX, Q463)));
}

function void Q43I(obj user, int Q5VX, int Q463, int Q4NC) {
	if (Q463 == 0x00) {
		return();
	}
	if (!isMobile(user)) {
		return();
	}
	string Q5OK = Q4T9(Q5VX, Q463);
	int Q4AT = Q4T8(Q5VX, Q463);
	setObjVar(user, Q5OK, Q463);
	int Q4I5 = modifyStat(user, Q5VX, Q463);
	attachScript(user, Q5OK);
	callback(user, Q4NC, Q4AT);
	return();
}

function void Q43H(obj user, int Q5VX, int Q463) {
	if (!isMobile(user)) {
		return();
	}
	if (Q463 == 0x00) {
		return();
	}
	int Q5NC = modifyStat(user, Q5VX, Q463);
	return();
}

function int Q41Q(obj user, int Q5VX, int Q463, int Q4NC) {
	if (Q463 == 0x00) {
		return(0x01);
	}
	if (!isMobile(user)) {
		return(0x00);
	}
	if (!Q432(user, Q5VX, Q463)) {
		Q43I(user, Q5VX, Q463, Q4NC);
		return(0x01);
	}
	return(0x00);
}

function int Q4TA(int Q5VX, int Q463) {
	int num = Q4SS(Q5VX, Q463);
	switch(num) {
	case 0x01
		return(0x01EE);
	case 0x02
		return(0x01E6);
	case 0x03
		return(0x01E7);
	case 0x04
		return(0x01DF);
	case 0x05
		return(0x01EB);
	case 0x06
		return(0x01E4);
	}
	return(0x00);
}

function int Q4T7(int Q5VX, int Q4ID) {
	if (Q4ID) {
		return(0x375A);
	} else {
		return(0x3779);
	}
	return(0x00);
}

function int Q433(obj it) {
	return(hasScript(it, "reflctor"));
}

function void Q42D(obj it, int Q5VX, int Q4ID) {
	int Q463 = 0x01;
	if (!Q4ID) {
		Q463 = 0x00 - 0x01;
	}
	if (!isMobile(it)) {
		return();
	}
	string name = Q4T9(Q5VX, Q463);
	if (hasObjVar(it, name)) {
		Q463 = getObjVar(it, name);
		Q43H(it, Q5VX, 0x00 - Q463);
		removeObjVar(it, name);
	}
	if (hasScript(it, name)) {
		detachScript(it, name);
	}
	return();
}

function void Q660(obj it) {
	setPoisoned(it, 0x00);
	if (hasObjVar(it, "poison_strength")) {
		removeObjVar(it, "poison_strength");
	}
	detachScript(it, "poisoned");
	handleHealthGain(it);
	return();
}

function void Q41C(obj Q5U8, obj target, int Q5NM) {
	if (Q5NM) {
		scriptTrig(Q5U8, 0x01, target);
	} else {
		scriptTrig(target, 0x01, Q5U8);
	}
	return();
}

function int Q49V(obj Q5KD, obj Q5KC, int Q5NM) {
	obj user = Q5KD;
	obj usedon = Q5KC;
	if (Q5NM) {
		user = Q5KC;
		usedon = Q5KD;
	}
	if (usedon == NULL()) {
		return(0x00);
	}
	if (Q5KC != NULL()) {
		if (getTopmostContainer(Q5KC) != Q5KD) {
			if (!canSeeObj(user, usedon)) {
				systemMessage(user, "Target can not be seen.");
				return(0x00);
			}
			if (getDistanceInTiles(getLocation(user), getLocation(usedon)) > 0x0C) {
				systemMessage(user, "Target is too far away.");
				return(0x00);
			}
		}
	}
	return(0x01);
}

function int Q50O(obj Q4XN) {
	int Q65M = getObjType(Q4XN);
	switch(Q65M) {
	case 0x0DF2
	case 0x0DF3
	case 0x0DF4
	case 0x0DF5
	case 0x13F8
	case 0x13F9
		return(0x01);
		break;
	}
	return(0x00);
}

function int Q49W(obj Q4XN, obj Q5KD, obj Q5KC, int Q5NM) {
	if (Q5KC == NULL()) {
		return(0x00);
	}
	if (Q50O(Q4XN)) {
		if ((!isEquipped(Q4XN)) || (containedBy(Q4XN) != Q5KD)) {
			systemMessage(Q5KD, "You must equip this item to use it.");
			return(0x00);
		}
	}
	return(Q49V(Q5KD, Q5KC, Q5NM));
}

function void Q5MF(obj it) {
	if (hasScript(it, "reflctor")) {
		doMobAnimation(it, 0x37B9, 0x0A, 0x05, 0x00, 0x00);
		detachScript(it, "reflctor");
	}
	return();
}

function int Q42R(int Q52T) {
	int num;
	int die;
	int Q5J6;
	switch(Q52T) {
	case 0x01
		num = 0x01;
		die = 0x03;
		Q5J6 = 0x03;
		break;
	case 0x02
		num = 0x01;
		die = 0x08;
		Q5J6 = 0x04;
		break;
	case 0x03
		num = 0x04;
		die = 0x04;
		Q5J6 = 0x04;
		break;
	case 0x04
		num = 0x03;
		die = 0x08;
		Q5J6 = 0x05;
		break;
	case 0x05
		num = 0x05;
		die = 0x08;
		Q5J6 = 0x06;
		break;
	case 0x06
		num = 0x06;
		die = 0x08;
		Q5J6 = 0x08;
		break;
	case 0x07
		num = 0x07;
		die = 0x08;
		Q5J6 = 0x0A;
		break;
	case 0x08
		num = 0x07;
		die = 0x08;
		Q5J6 = 0x0A;
		break;
	default
		return(0x00);
		break;
	}
	int damage = (num * random(0x01, die)) + Q5J6;
	return(damage);
}

function int Q43F(int Q5TQ, int damage) {
	int Q5CL = (damage * (0x32 + Q5TQ)) / 0x64;
	return(Q5CL);
}

function int Q43G(obj Q5UY, obj Q4XN, int damage) {
	int Q5TQ = 0x00;
	if (isValid(Q5UY)) {
		if (hasObjVar(Q5UY, "magicItemDamage")) {
			int Q54V = getObjVar(Q5UY, "magicItemDamage");
			Q5TQ = Q54V * 0x0A;
		} else {
			if (isValid(Q4XN)) {
				if (isMobile(Q4XN)) {
					Q5TQ = getSkillLevel(Q4XN, 0x19);
				}
			}
		}
	} else {
		if (isValid(Q4XN)) {
			if (isMobile(Q4XN)) {
				Q5TQ = getSkillLevel(Q4XN, 0x19);
			}
		}
	}
	return(Q43F(Q5TQ, damage));
}

function int Q428(obj Q5UY, int Q45Y, obj Q5U8, obj dest, int Q65M, int Q5NQ) {
	int damage = Q45Y;
	if (isNPC(dest)) {
		damage = Q45Y * 0x02;
	}
	obj caster = Q5U8;
	if (Q5NQ) {
		caster = dest;
	}
	damage = Q43G(Q5UY, caster, damage);
	if (isValid(dest)) {
		if (inJusticeRegion(getLocation(dest))) {
			damage = Q4BI(Q5U8, dest, damage);
		} else {
			damage = Q4BH(Q5U8, dest, damage);
		}
	}
	Q423(Q5U8, dest, damage, Q65M, Q5NQ);
	return(damage);
}

function int Q427(obj Q5UY, int Q5UW, obj Q5U8, obj dest, int Q65M, int Q5NQ) {
	int damage = Q42R(Q5UW);
	return(Q428(Q5UY, damage, Q5U8, dest, Q65M, Q5NQ));
}

function int Q429(obj Q5UY, obj Q5U8, obj dest, int Q65M, int Q5NQ) {
	int Q5UW = Q42S(Q5UY);
	return(Q427(Q5UY, Q5UW, Q5U8, dest, Q65M, Q5NQ));
}

function int Q42B(int range, obj Q5UY, int Q45Y, obj Q5U8, list Q5YQ, int Q65M) {
	int num = numInList(Q5YQ);
	int damage = Q45Y;
	if (num > 0x01) {
		damage = damage * 0x02;
	}
	int Q5I0 = damage / num;
	if ((Q45Y > 0x00) && (Q5I0 <= 0x00)) {
		Q5I0 = 0x01;
	}
	obj Q5HY;
	int Q527;
	loc Q5UF = getLocation(Q5U8);
	loc Q4HT;
	int Q4IJ;
	int Q5KX;
	for (int i = 0x00; i < num; i++) {
		Q5HY = Q5YQ[i];
		if (isValid(Q5HY)) {
			Q4HT = getLocation(Q5HY);
			Q4IJ = getDistanceInTiles(Q5UF, Q4HT);
			Q527 = Q428(Q5UY, Q5I0, Q5U8, Q5HY, Q65M, 0x00);
			scriptTrig(Q5HY, 0x01, Q5U8);
		}
	}
	return(Q45Y);
}

function int Q42A(int range, obj Q5UY, int Q5UW, obj Q5U8, list Q5YQ, int Q65M) {
	int damage = Q42R(Q5UW);
	return(Q42B(range, Q5UY, damage, Q5U8, Q5YQ, Q65M));
}

function int Q42C(int range, obj Q5UY, obj Q5U8, list Q5YQ, int Q65M) {
	int Q5UW = Q42S(Q5UY);
	return(Q42A(range, Q5UY, Q5UW, Q5U8, Q5YQ, Q65M));
}

function void Q5LZ(obj Q4XN, int Q4AT, int Q540, int Q4VZ) {
	if (!hasCallback(Q4XN, Q4AT)) {
		shortcallback(Q4XN, random(Q540, Q4VZ), Q4AT);
	}
	return();
}

function int Q41G(obj it, int Q463, int Q5JO, int Q5BI) {
	if (!isValid(it)) {
		return(0x00);
	}
	int Q4FJ;
	Q4FJ = getNotoriety(it);
	int Q5C3 = Q4FJ + Q463;
	if (Q463 > 0x00) {
		if (Q4FJ > Q5JO) {
			Q5C3 = Q4FJ;
		} else {
			if (Q5C3 > Q5JO) {
				Q5C3 = Q5JO;
			}
		}
	}
	if (Q463 < 0x00) {
		if (Q4FJ < Q5BI) {
			Q5C3 = Q4FJ;
		} else {
			if (Q5C3 < Q5BI) {
				Q5C3 = Q5BI;
			}
		}
	}
	if (Q5C3 != Q4FJ) {
		setNotoriety(it, Q5C3);
		return(0x01);
	}
	return(0x00);
}

function int Q41W(obj Q5U8, obj dest, int Q5NM, int Q524, int Q54K) {
	obj Q5AQ = Q5U8;
	obj Q5A9 = dest;
	if (Q5AQ == Q5A9) {
		return(0x00);
	}
	if (Q5NM) {
		Q5AQ = dest;
		Q5A9 = Q5U8;
	}
	if (getCompileFlag(0x01)) {
		if (Q524 == 0x01) {
			receiveHelpfulActionFrom(Q5A9, Q5AQ);
			int value = getKarma(Q5A9) / 0x05;
			changeKarma(Q5AQ, value);
		}
	}
	if (!getCompileFlag(0x01)) {
		int Q4IA = NotorietyCompare(Q5AQ, Q5A9);
		if ((Q524 == 0x01) && (Q4IA == 0x01) && (!Q4BD(Q5A9, Q5AQ))) {
			int Q463 = 0x00 - ((Q54K + 0x01) / 0x02);
			int Q5BI = (0x00 - (((Q54K + 0x01) / 0x02) * 0x18));
			if (Q41G(Q5AQ, Q463, 0x00, Q5BI)) {
				systemMessage(Q5AQ, "That action is frowned upon.");
			}
			return(Q463);
		}
	}
	return(0x00);
}

function int Q41J(obj Q5U8, obj dest, int Q5NM, obj Q5UY) {
	return(Q41W(Q5U8, dest, Q5NM, 0x01, Q42S(Q5UY)));
}

function void Q4WO(obj Q68S, obj Q68D) {
	superTargetObj(Q68S, Q68D, 0x01);
	return();
}

function void Q4WN(obj Q68S, obj Q68D, int range) {
	superTargetLoc(Q68S, Q68D, 0x01, range);
	return();
}

function void Q48A(obj Q68S, obj Q68D) {
	superTargetObj(Q68S, Q68D, 0x02);
	return();
}

function void Q489(obj Q68S, obj Q68D, int range) {
	superTargetLoc(Q68S, Q68D, 0x02, range);
	return();
}

function void Q554(obj Q68S, int Q4NC) {
	setCriminal(Q68S, Q4NC);
	return();
}

function loc Q5I9(obj Q68S) {
	loc Q4G3 = getLocation(Q68S);
	loc Q4BA = Q4G3;
	int find = findGoodSpotNearMin(Q4BA, 0x01, 0x01, 0x10, 0x01);
	if ((!find) || (!Q4ZZ(Q68S, Q4BA)) || (!canSeeLoc(Q68S, Q4BA))) {
		Q4BA = (0x00 - 0x01), (0x00 - 0x01), (0x00 - 0x01);
	}
	return(Q4BA);
}

function int Q4RN(obj caster, int Q52T) {
	return(0x0F + ((getSkillLevel(caster, 0x19) * 0x02) / Q52T));
}

function int Q4YT(obj Q68S) {
	if (hasCallback(Q68S, 0x80)) {
		return(0x01);
	}
	return(0x00);
}

function int Q4SV(int Q5US, int Q5UX) {
	switch(Q5UX) {
	case 0x20
		return((Q5US + 0x01) * 0x05);
		break;
	case 0x27
		return((Q5US + 0x01) * 0x05);
		break;
	case 0x3B
		return((Q5US + 0x01) * 0x05);
		break;
	case 0x3C
		return((Q5US + 0x01) * 0x05);
		break;
	case 0x3D
		return((Q5US + 0x01) * 0x05);
		break;
	case 0x3E
		return((Q5US + 0x01) * 0x05);
		break;
	case 0x3F
		return((Q5US + 0x01) * 0x05);
		break;
	}
	return(Q5US + 0x01);
}

function int Q507(obj Q68S) {
	return(hasScript(Q68S, "targeting"));
}

function void Q4M9(obj spell, obj caster) {
	if (Q4YT(caster) || Q507(caster)) {
		systemMessage(caster, "You are already casting a spell.");
		return();
	}
	if (getMobFlag(caster, 0x02)) {
		systemMessage(caster, "You can not cast a spell while frozen.");
		return();
	}
	int Q5UX = Q4T2(spell);
	int Q5US = Q4SY(Q5UX);
	int Q55B = Q4SX(Q5US);
	if (!Q49Q(caster, Q55B)) {
		return();
	}
	setObjVar(caster, "spellObj", spell);
	attachScript(caster, "casting");
	int Q4H9 = Q4SV(Q5US, Q5UX);
	shortcallback(caster, Q4H9, 0x80);
	shortcallback(caster, 0x00, 0x82);
	bark(caster, Q4T5(Q4T2(spell)));
	return();
}

function obj Q4BB(obj this, list args) {
	obj user = args[0x00];
	obj Q4WD = getTopmostContainer(this);
	if ((Q4WD != NULL()) && (Q4WD != user)) {
		user = NULL();
	}
	return(user);
}

function int Q508(obj it) {
	if (hasScript(it, "teleporter")) {
		return(0x01);
	}
	if (hasScript(it, "dec_teleport")) {
		return(0x01);
	}
	if (hasScript(it, "des1_ankh_tele_1")) {
		return(0x01);
	}
	if (hasScript(it, "des1_ankh_tele_2")) {
		return(0x01);
	}
	if (hasScript(it, "despise_teleporter_four")) {
		return(0x01);
	}
	if (hasScript(it, "despise_teleporter_one")) {
		return(0x01);
	}
	if (hasScript(it, "despise_teleporter_three")) {
		return(0x01);
	}
	if (hasScript(it, "despise_teleporter_two")) {
		return(0x01);
	}
	if (hasScript(it, "dest_tele_one")) {
		return(0x01);
	}
	if (hasScript(it, "sha_tele_new")) {
		return(0x01);
	}
	if (hasScript(it, "sha_teleporter")) {
		return(0x01);
	}
	if (hasScript(it, "sha_teleporter2")) {
		return(0x01);
	}
	if (hasScript(it, "sha_teleporter3")) {
		return(0x01);
	}
	if (hasScript(it, "sha_teleporter4")) {
		return(0x01);
	}
	if (hasScript(it, "sha_teleporter5")) {
		return(0x01);
	}
	if (hasScript(it, "sha_teleporter6")) {
		return(0x01);
	}
	if (hasScript(it, "sha_teleporter7")) {
		return(0x01);
	}
	if (hasScript(it, "sha_teler_lever_2")) {
		return(0x01);
	}
	if (hasScript(it, "sha_teler_switch")) {
		return(0x01);
	}
	if (hasScript(it, "sha_teleroom_lever")) {
		return(0x01);
	}
	if (hasScript(it, "sha_teleroom_wall")) {
		return(0x01);
	}
	if (hasScript(it, "trap_tele_gen_er_one")) {
		return(0x01);
	}
	return(0x00);
}

function int Q509(loc where, int range) {
	list Q5FJ;
	getObjectsInRange(Q5FJ, where, range);
	int num = numInList(Q5FJ);
	for (int i = 0x00; i < num; i++) {
		obj it = Q5FJ[i];
		if (Q508(it)) {
			return(0x01);
		}
	}
	return(0x00);
}

function int Q657(obj user, int objtype, loc place, int Q67X, int Q5EC, int walldur, int Q4UK, int Q4H9) {
	if (!canSeeLoc(user, place)) {
		return(0x00);
	}
	if (Q509(place, 0x03)) {
		return(0x00);
	}
	obj Q4EZ = Q4EQ(objtype, place);
	if (Q4EZ != NULL()) {
		Q5RC(Q4EZ, user);
		copyControllerInfo(Q4EZ, user);
		setObjVar(Q4EZ, "newType", Q67X);
		setObjVar(Q4EZ, "walltype", Q5EC);
		setObjVar(Q4EZ, "walldur", walldur);
		attachScript(Q4EZ, "crtwall");
		shortcallback(Q4EZ, Q4H9, 0x2E);
		if (!getCompileFlag(0x01)) {
			if (Q4UK) {
				Q5UL(user, place, 0x01, 0x00);
			}
		}
		return(0x01);
	}
	return(0x00);
}

function void Q5RD(obj Q68S, obj Q5UY) {
	if (!Q507(Q68S)) {
		attachScript(Q68S, "targeting");
	}
	setObjVar(Q68S, "targetingForObj", Q5UY);
	return();
}

function int Q4C8(obj Q68S, obj Q5UY) {
	if (!Q507(Q68S)) {
		return(0x00);
	}
	obj Q4D2;
	Q4D2 = getObjVar(Q68S, "targetingForObj");
	if (Q5UY != Q4D2) {
		return(0x00);
	}
	detachScript(Q68S, "targeting");
	removeObjVar(Q68S, "targetingForObj");
	return(0x01);
}

function int Q504(obj caster, int Q5US) {
	if (getSkillSuccessChance(caster, 0x19, Q4SW(Q5US), 0x28) >= 0x01F4) {
		return(0x01);
	}
	return(0x00);
}

function int Q4A8(obj caster, int Q5US) {
	if (getSkillSuccessChance(caster, 0x19, Q4SW(Q5US), 0x28) > 0x00) {
		return(0x01);
	}
	return(0x00);
}

function int Q50H(obj caster, obj victim) {
	if (caster == victim) {
		return(0x00);
	}
	if (getMobFlag(victim, 0x02)) {
		return(0x00);
	}
	if (isInvulnerable(victim)) {
		return(0x00);
	}
	return(0x01);
}

function void Q556(obj it) {
	if (isNPC(it)) {
		if (Q50H(NULL(), it)) {
			loc where = getLocation(it);
			setX(where, getX(where) + random(0x00, 0x0A) - 0x05);
			setY(where, getY(where) + random(0x00, 0x0A) - 0x05);
			walkTo(it, where, 0x17);
		}
	}
	return();
}

function int Q50L(loc where) {
	if (isInRegionWithPrefix("teleportation_in_no", where)) {
		return(0x00);
	}
	return(0x01);
}

function int Q50M(loc where) {
	if (isInRegionWithPrefix("teleportation_out_no", where)) {
		return(0x00);
	}
	return(0x01);
}

function int Q5UM(obj user, obj usedon, int range) {
	if (!canSeeObj(user, usedon)) {
		systemMessage(user, "Target cannot be seen.");
		return(0x00);
	}
	if (getDistanceInTiles(getLocation(user), getLocation(usedon)) > range) {
		systemMessage(user, "Target is too far away.");
		return(0x00);
	}
	return(0x01);
}

function int Q4ZK(obj it) {
	int Q65M = getObjType(it);
	switch(Q65M) {
	case 0x0F6C
		return(0x01);
		break;
	default
		return(0x00);
		break;
	}
	return(0x00);
}

function int Q46M(loc where, obj Q68S) {
	list Q5FJ;
	getObjectsAt(Q5FJ, where);
	int num = numInList(Q5FJ);
	for (int i = 0x00; i < num; i++) {
		obj it = Q5FJ[i];
		if (it != Q68S) {
			if (Q4ZK(it)) {
				return(0x01);
			}
		}
	}
	return(0x00);
}

function int Q46L(loc where) {
	return(Q46M(where, NULL()));
}

function int Q50G(obj usedon) {
	if (isMobile(usedon)) {
		if (!isDead(usedon)) {
			if (!isCounselor(usedon)) {
				if (!getMobFlag(usedon, 0x01)) {
					return(0x01);
				}
			}
		}
	}
	return(0x00);
}

function int Q50J(obj usedon) {
	return(isValid(usedon));
}

function int Q50F(loc place) {
	return(isInMap(place));
}

function void Q5UQ(obj it) {
	shortcallback(it, 0x01, 0x48);
	return();
}

function void Q5UR(obj it, int Q5NC) {
	if (!Q5NC) {
		shortcallback(it, 0x01, 0x48);
	}
	return();
}
