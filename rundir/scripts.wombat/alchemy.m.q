inherits spelskil;

member list Q5K3;

member list Q5JY;

member int Q5LP;

member int Q4R3;

member obj Q4FQ;

function int Q50N(string Q4B8) {
	if ((Q4B8 == "a") || (Q4B8 == "A") || (Q4B8 == "e") || (Q4B8 == "E") || (Q4B8 == "i") || (Q4B8 == "I") || (Q4B8 == "o") || (Q4B8 == "O") || (Q4B8 == "u") || (Q4B8 == "U")) {
		return(0x01);
	}
	return(0x00);
}

function void Q4P5(obj Q4NO, obj user) {
	int Q4Q1;
	Q4R3 = 0x00;
	obj Q47F = getBackpack(user);
	int Q5K1 = Q5K3[0x00];
	string Q5ZC = Q5K3[0x01];
	string Q5JZ;
	if (Q50N(Q5ZC[0x00])) {
		Q5JZ = "an ";
	} else {
		Q5JZ = "a ";
	}
	concat(Q5JZ, Q5ZC);
	concat(Q5JZ, " potion");
	obj Q5C7 = createGlobalObjectOn(Q4NO, Q5K1);
	if ((getQuantity(Q4NO) > 0x01) && (!isInContainer(Q4NO))) {
		if (canHold(Q47F, Q4NO)) {
			Q4Q1 = putObjContainer(Q4NO, Q47F);
			systemMessage(user, "You put the remaining empty bottles in to your backpack.");
		} else {
			Q4Q1 = teleport(Q4NO, getLocation(user));
			systemMessage(user, "You put the remaining empty bottles at your feet.");
		}
	}
	int Q5K0 = Q5JY[0x02];
	setObjVar(Q5C7, "power", Q5K0);
	Q5RE(Q5C7, Q5JZ);
	string Q5OM = Q5JY[0x03];
	if (Q5OM == "") {
		Q5OM = Q5K1;
	}
	attachScript(Q5C7, Q5OM);
	destroyOne(Q4NO);
	return();
}

function void Q5VP() {
	int Q5L0 = Q5JY[0x00];
	if (Q5L0 > getGeneric(Q4FQ, Q5LP)) {
		systemMessage(Q4FQ, "You ran out of " + getNameByType(Q5LP) + ".");
		Q4FQ = NULL();
		return();
	}
	destroyGeneric(Q4FQ, Q5LP, Q5L0);
	actionBark(Q4FQ, 0x22, "*You start grinding some " + getNameByType(Q5LP) + " in the mortar.*", "*" + getName(Q4FQ) + " starts grinding some " + getNameByType(Q5LP) + " in a mortar.*");
	sfx(getLocation(Q4FQ), 0x0242, 0x00);
	shortCallback(this, 0x0B, 0x5A);
	return();
}

trigger callback(0x5A) {
	Q4R3++;
	if (Q4R3 < 0x03) {
		actionBark(Q4FQ, 0x22, "*You continue grinding.*", "*" + getName(Q4FQ) + " continues grinding.*");
		sfx(getLocation(Q4FQ), 0x0242, 0x00);
		shortCallback(this, 0x0B, 0x5A);
		return(0x00);
	}
	int success = testAndLearnSkill(Q4FQ, 0x00, Q5JY[0x01], 0x32);
	if (success > 0x00) {
		obj Q4NO = mobileContainsObjType(Q4FQ, 0x0F0E);
		if (Q4NO == NULL()) {
			scriptTrig(this, 0x17, Q4FQ);
		} else {
			actionBark(Q4FQ, 0x22, "*You pour the completed potion into a bottle.*", "*" + getName(Q4FQ) + " pours the completed potion into a bottle.*");
			Q4P5(Q4NO, Q4FQ);
			sfx(getLocation(Q4FQ), 0x0240, 0x00);
			Q4R3 = 0x00;
		}
	} else {
		actionBark(Q4FQ, 0x22, "*You toss the failed mixture from the mortar, unable to create a potion from it.*", "*" + getName(Q4FQ) + " tosses out the contents of the mortar.*");
		Q4R3 = 0x00;
	}
	Q4FQ = NULL();
	return(0x00);
}

trigger use {
	if (Q4R3 == 0x03) {
		obj Q4NO = mobileContainsObjType(user, 0x0F0E);
		if (Q4NO == NULL()) {
			systemMessage(user, "Where is an empty bottle for your potion?");
			targetObj(user, this);
		} else {
			actionBark(user, 0x22, "*You pour the mixture into an empty bottle.*", "* " + getName(user) + " pours the mixture into an empty bottle.*");
			Q4P5(Q4NO, user);
		}
		return(0x00);
	}
	if (Q4FQ != NULL()) {
		if (Q4FQ == user) {
			actionBark(Q4FQ, 0x22, "*You stop mixing and empty the mortar.*", "*" + getName(Q4FQ) + " stops mixing and empties the mortar.*");
			Q4R3 = 0x00;
			Q4FQ = NULL();
			removeCallback(this, 0x5A);
			return(0x00);
		}
		systemMessage(user, "Someone else is using that.");
		return(0x00);
	}
	systemMessage(user, "What reagent would you like to make the potion out of?");
	targetObj(user, this);
	return(0x00);
}

trigger typeselected(0x2B) {
	if (listindex == 0x00) {
		return(0x00);
	}
	listindex--;
	int Q65M = Q5K3[(listindex * 0x02)];
	string name = Q5K3[(listindex * 0x02 + 0x01)];
	clearList(Q5K3);
	Q5K3 = Q65M, name;
	int Q5LR = Q5JY[(listindex * 0x04)];
	int Q4IB = Q5JY[(listindex * 0x04 + 0x01)];
	int power = Q5JY[(listindex * 0x04 + 0x02)];
	string Q5OM = Q5JY[(listindex * 0x04 + 0x03)];
	clearList(Q5JY);
	Q5JY = Q5LR, Q4IB, power, Q5OM;
	Q4FQ = user;
	Q5VP();
	return(0x00);
}

trigger targetobj {
	if (usedon == NULL()) {
		return(0x00);
	}
	if (getDistanceInTiles(getLocation(user), getLocation(usedon)) > 0x02) {
		systemMessage(user, "You are too far away to do that.");
		return(0x00);
	}
	if (Q4R3 < 0x03) {
		if (isMobile(usedon)) {
			systemMessage(user, "That's not something you can grind with a mortar and pestle!");
			return(0x00);
		}
		if ((usedon == this) && (numInList(Q5K3) > 0x00)) {
			Q4FQ = user;
			Q5VP();
			return(0x00);
		}
		Q5LP = getObjType(usedon);
		int Q65M = 0x00;
		clearList(Q5K3);
		switch(Q5LP) {
		case 0x0F7A
			Q5K3 = 0x0F0B, "Refresh", 0x0F0B, "Total Refreshment";
			Q5JY = 0x01, 0x00, 0xFA, "", 0x05, 0x01F4, 0x03E8, "";
			break;
		case 0x0F7B
			Q5K3 = 0x0F08, "Agility", 0x0F08, "Greater Agility";
			Q5JY = 0x01, 0x0190, 0x0A, "", 0x03, 0x0258, 0x14, "";
			break;
		case 0x0F8D
			Q5K3 = 0x0F06, "Nightsight";
			Q5JY = 0x01, 0x00, 0x00, "";
			break;
		case 0x0F85
			Q5K3 = 0x0F0C, "Lesser Heal", 0x0F0C, "Heal", 0x0F0C, "Greater Heal";
			Q5JY = 0x01, 0x00, 0x64, "", 0x03, 0x0190, 0xC8, "", 0x07, 0x0320, 0x012C, "";
			break;
		case 0x0F86
			Q5K3 = 0x0F09, "Strength", 0x0F09, "Greater Strength";
			Q5JY = 0x02, 0x01F4, 0x0A, "", 0x05, 0x02BC, 0x14, "";
			break;
		case 0x0F88
			Q5K3 = 0x0F0A, "Lesser Poison", 0x0F0A, "Poison", 0x0F0A, "Greater Poison", 0x0F0A, "Deadly Poison";
			Q5JY = 0x01, 0xC8, 0x01, "", 0x02, 0x0190, 0x02, "", 0x04, 0x0320, 0x03, "", 0x08, 0x047E, 0x04, "";
			break;
		case 0x0F84
			Q5K3 = 0x0F07, "Lesser Cure", 0x0F07, "Cure", 0x0F07, "Greater Cure";
			Q5JY = 0x01, 0x96, 0x2D, "", 0x03, 0x01F4, 0x4B, "", 0x06, 0x0384, 0x64, "";
			break;
		case 0x0F8C
			Q5K3 = 0x0F0D, "Lesser Explosion", 0x0F0D, "Explosion", 0x0F0D, "Greater Explosion";
			Q5JY = 0x03, 0x012C, 0x0A, "", 0x05, 0x0258, 0x14, "", 0x0A, 0x0384, 0x28, "";
			break;
		default
			systemMessage(user, "That is not a magic reagent.");
			return(0x00);
		}
		int Q5E8 = numInList(Q5K3) / 0x02;
		int Q5DF = 0x00;
		for (int i = 0x00; i < Q5E8;
		) {
			int remove = 0x00;
			int Q5L0 = Q5JY[(i * 0x04)];
			if (Q5L0 > getGeneric(user, Q5LP)) {
				remove = 0x01;
				if (i == 0x00) {
					Q5DF = 0x01;
				}
			}
			int Q4IB = Q5JY[(i * 0x04 + 0x01)];
			if (getSkillSuccessChance(user, 0x00, Q4IB, 0x32) <= 0x00) {
				remove = 0x01;
			}
			if (remove) {
				removeItem(Q5K3, i * 0x02);
				removeItem(Q5K3, i * 0x02);
				removeItem(Q5JY, i * 0x04);
				removeItem(Q5JY, i * 0x04);
				removeItem(Q5JY, i * 0x04);
				removeItem(Q5JY, i * 0x04);
				Q5E8--;
			} else {
				i++;
			}
		}
		if (Q5E8 == 0x00) {
			if (Q5DF) {
				systemMessage(user, "The weakest " + getNameByType(Q5LP) + " potion requires more than you have.");
			} else {
				systemMessage(user, "You are not good enough to make anything out of that.");
			}
			return(0x00);
		}
		if (Q5E8 == 0x01) {
			Q4FQ = user;
			Q5VP();
			return(0x00);
		}
		selectType(user, this, 0x2B, "Choose a formula.", Q5K3);
		return(0x00);
	} else {
		if (getObjType(usedon) == 0x0F0E) {
			actionBark(user, 0x22, "*You pour the completed potion into the bottle.*", "*" + getName(user) + " pours the completed potion into a bottle.*");
			Q4P5(usedon, user);
		} else {
			systemMessage(user, "That is not an empty bottle.");
		}
	}
	return(0x00);
}
