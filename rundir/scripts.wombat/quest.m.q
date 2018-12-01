inherits quest_general_funcs;

forward int Q5I7();

forward obj Q4SI();

forward void Q45C(obj );

forward void Q5VO(obj );

forward void Q5VQ(obj );

forward void Q5VM(obj );

forward void Q4ET(obj , int );

forward int Q4SJ(obj );

forward void Q66F();

trigger objectloaded {
	deleteObject(this);
	return(0x01);
}

trigger callback(0x45) {
	deleteObject(this);
	return(0x01);
}

trigger creation {
	shortcallback(this, 0x01, 0x45);
	return(0x01);
	
member list Q5DN;
	
member int Q5EN = 0x00;
	Q66F();
	if (0x00) {
		debugMessage("Initializing quest egg.");
		bark(this, "Initializing quest egg.");
	}
	if (numInList(Q5DN) < 0x01) {
		debugMessage("Failed to find NPCs near quest egg, aborting.");
		bark(this, "Failed to find NPCs near quest egg, aborting.");
		callBack(this, 0x01, 0x4F);
		return(0x00);
	}
	callBack(this, 0x2710, 0x46);
	return(0x01);
}

trigger callback(0x4F) {
	deleteObject(this);
	return(0x00);
}

function void Q66F() {
	list Q4A9;
	obj Q60R;
	clearList(Q5DN);
	getNPCsInRange(Q4A9, getLocation(this), 0x32);
	for (int i = 0x00; i < numInList(Q4A9); i++) {
		Q60R = Q4A9[i];
		if (!hasObjVar(Q60R, "isActor")) {
			if (isHuman(Q60R)) {
				if (!isGuard(Q60R)) {
					if (!hasScript(Q60R, "pet")) {
						appendToList(Q5DN, Q60R);
					}
				}
			}
		}
	}
	return();
}

trigger speech("*") {
	if (0x00) {
		Q66F();
		debugMessage("Adding a new quest: order.");
		bark(this, "Adding a new quest: order.");
		obj Q5KS = Q4SI();
		if (Q5KS == NULL()) {
			debugMessage("Failed to find a protagonist.");
			bark(this, "Failed to find a protagonist.");
			return(0x01);
		}
		Q45C(Q5KS);
	}
	return(0x01);
}

trigger callback(0x46) {
	Q5EN++;
	if (Q5EN > 0x05) {
		callBack(this, 0x2710, 0x4F);
		return(0x00);
	}
	if (0x00) {
		debugMessage("Adding a new quest: interval.");
	}
	Q66F();
	obj Q5KS = Q4SI();
	Q45C(Q5KS);
	callBack(this, 0x2710, 0x46);
	return(0x01);
}

function void Q45C(obj Q5KS) {
	setObjVar(Q5KS, "isActor", 0x01);
	if (0x00) {
		debugMessage("Selecting a quest type.");
	}
	switch(Q5I7()) {
	case 0x00
		if (0x00) {
			debugMessage("Selected fetch quest.");
		}
		Q5VO(Q5KS);
		break;
	case 0x02
		if (0x00) {
			debugMessage("Selected murder quest.");
		}
		Q5VQ(Q5KS);
		break;
	case 0x01
		if (0x00) {
			debugMessage("Selected deliver quest.");
		}
		Q5VM(Q5KS);
		break;
	case 0x03
		if (0x00) {
			debugMessage("Selected mystery quest.");
		}
	case 0x04
		if (0x00) {
			debugMessage("Selected tourney quest.");
		}
	default
		return();
		break;
	}
	return();
}

function int Q5I7() {
	return(random(0x00, 0x01));
}

function obj Q4SI() {
	obj Q60T;
	if (numInList(Q5DN) > 0x00) {
		Q60T = Q5DN[random(0x00, numInList(Q5DN) - 0x01)];
	}
	if (hasObjVar(Q60T, "isActor")) {
		if (0x00) {
			debugMessage("Selected a protagonist who is already an actor.");
			bark(Q60T, "I am already an actor!");
		}
		Q60T = NULL();
	}
	if (getBackpack(Q60T) == NULL()) {
		if (0x00) {
			debugMessage("Selected actor without a backpack.");
		}
		Q60T = NULL();
	}
	if (0x00) {
		debugMessage("Quest protagonist selected.");
		bark(Q60T, "I am now a quest actor!");
	}
	return(Q60T);
}

function void Q5VO(obj Q5KS) {
	obj Q4WD;
	int Q511;
	obj Q4P1;
	int Q5D9 = random(0x00, 0x03);
	Q511 = Q4SJ(Q5KS);
	switch(Q5D9) {
	default
	case 0x00
	case 0x01
		break;
	case 0x02
	case 0x03
		if (0x00) {
			debugMessage("Specific item fetch attempted.");
		}
		Q4WD = Q4SI();
		if (Q4WD == NULL()) {
			if (0x00) {
				debugMessage("Specific item fetch aborted.");
			}
			Q5VO(Q5KS);
			return();
		}
		Q4P1 = requestCreateObjectIn(Q511, getBackpack(Q4WD));
		if (Q4P1 == NULL()) {
			if (0x00) {
				debugMessage("Specific item fetch aborted.");
			}
			Q5VO(Q5KS);
		}
		setObjVar(Q4WD, "questReward", Q4P1);
		setObjVar(Q5KS, "questItemHolder", Q4WD);
		if (0x00) {
			debugMessage("Adding next leg of quest.");
		}
		Q45C(Q4WD);
		break;
	}
	list Q5LW = "'Tis an odd hobby, but I collect ", "I cannot tell thee why, but I need ", "I have need of ", "I need to get ", "I could really use ", "I have great need of ", "I could use ", "'Tis my fondest hope to own ", "I wish to own ", "I would like ", "I badly need to get ", "I dearly wish to get ", "I dearly wish to obtain ", "I wish to obtain ", "I collect ", "I would like to have ", "I collect", "'Tis my life's work to obtain ", "I have always wished ", "I have always wanted ", "I have always desired ", "I have always dreamed of getting ";
	string Q59W = Q5LW[random(0x00, numInList(Q5LW) - 0x01)];
	Q4ET(Q5KS, Q5D9);
	setObjVar(Q5KS, "questFetchReason", Q59W);
	if (0x00) {
		debugMessage("Item type fetch quest activated.");
	}
	setObjVar(Q5KS, "questFetchObjType", Q511);
	if (Q4P1 != NULL()) {
		if (0x00) {
			debugMessage("Specific item fetch quest activated.");
		}
		setObjVar(Q5KS, "questFetchObject", Q4P1);
	}
	if (Q5KS == NULL()) {
		return();
	}
	attachScript(Q5KS, "quest_fetch_asker");
	return();
}

function void Q5VQ(obj Q5KS) {
	obj victim = Q4SI();
	if (victim == NULL()) {
		if (0x00) {
			debugMessage("Murder quest aborted for ack of a victim.");
		}
		Q45C(Q5KS);
		return();
	}
	list Q5LW = "I have a deep hatred for ", "I have a feud with ", "I was insulted terribly by ", "I have good reasons to wish someone dead... ", "'Tis distasteful, perhaps, but with such a scoundrel, there is no other solution. 'Tis ", "Revile me not, but I have an enemy: ", "I have an enemy, ", "I have reasons to wish someone dead... Their name is ", "I was asked to kill someone but I am too scared to do it. Their name is ", "My family hath had a longstanding feud with ";
	string Q59W = Q5LW[random(0x00, numInList(Q5LW) - 0x01)];
	Q59W = Q59W + getName(victim) + Q59D();
	int Q5D9 = random(0x02, 0x03);
	Q4ET(Q5KS, Q5D9);
	setObjVar(Q5KS, "questMurderReason", Q59W);
	if (0x00) {
		debugMessage("Murder quest activated.");
	}
	setObjVar(Q5KS, "questMurderVictim", victim);
	setObjVar(victim, "questMyMurderer", Q5KS);
	if (Q5KS == NULL()) {
		return();
	}
	attachScript(Q5KS, "quest_murder_asker");
	if (victim == NULL()) {
		return();
	}
	attachScript(victim, "quest_murder_victim");
	return();
}

function void Q5VM(obj Q5KS) {
	obj destination;
	int Q511;
	obj Q4P1;
	int Q5D9 = random(0x00, 0x01);
	Q511 = Q4SJ(Q5KS);
	if (0x00) {
		debugMessage("Specific item fetch attempted.");
	}
	destination = Q4SI();
	if (destination == NULL()) {
		if (0x00) {
			debugMessage("Item delivery aborted.");
		}
		Q45C(Q5KS);
		return();
	}
	Q4P1 = requestCreateObjectIn(Q511, getBackpack(Q5KS));
	if (Q4P1 == NULL()) {
		if (0x00) {
			debugMessage("Item delivery aborted.");
		}
		Q5VM(Q5KS);
	}
	setObjVar(Q5KS, "questItemDestination", destination);
	if (0x00) {
		debugMessage("Adding next leg of quest.");
	}
	list Q5LW = "A friend of mine needeth ", "I promised to take something to a friend... ", "I am supposed to deliver ";
	string Q59W = Q5LW[random(0x00, numInList(Q5LW) - 0x01)];
	Q4ET(destination, Q5D9);
	setObjVar(Q5KS, "questDeliverReason", Q59W);
	setObjVar(destination, "questDeliverObjectRec", Q4P1);
	setObjVar(Q5KS, "questDeliverObject", Q4P1);
	if (0x00) {
		debugMessage("Item type deliver quest activated.");
	}
	if (Q5KS == NULL()) {
		return();
	}
	attachScript(Q5KS, "quest_deliver_asker");
	if (destination == NULL()) {
		return();
	}
	attachScript(destination, "quest_deliver_dest");
	return();
}

function void Q4ET(obj Q5KS, int Q5D9) {
	if (hasObjVar(Q5KS, "questReward")) {
		return();
	}
	obj reward = NULL();
	int success = 0x00;
	switch(Q5D9) {
	default
	case 0x00
		break;
	case 0x01
		reward = requestCreateObjectAt(0x0EED, getLocation(Q5KS));
		if (reward != NULL()) {
			success = requestAddQuantity(reward, random(0x64, 0x01F4));
		}
		if (!success) {
			deleteObject(reward);
			Q4ET(Q5KS, 0x00);
			return();
		}
		break;
	case 0x02
		reward = requestCreateObjectAt(0x0EED, getLocation(Q5KS));
		if (reward != NULL()) {
			success = requestAddQuantity(reward, random(0x0190, 0x0320));
		}
		if (!success) {
			deleteObject(reward);
			Q4ET(Q5KS, 0x01);
			return();
		}
		break;
	case 0x03
		reward = requestCreateObjectAt(0x0EED, getLocation(Q5KS));
		if (reward != NULL()) {
			success = requestAddQuantity(reward, random(0x0320, 0x05DC));
		}
		if (!success) {
			deleteObject(reward);
			Q4ET(Q5KS, 0x02);
			return();
		}
		break;
	}
	if (reward != NULL()) {
		success = putObjContainer(reward, this);
	}
	setObjVar(Q5KS, "questReward", reward);
	return();
}

function int Q4SJ(obj Q5KS) {
	list Q4OA = 0x0F06, 0x0F07, 0x0F08, 0x0F09, 0x0F0A, 0x0F0B, 0x0F0C, 0x0F0D, 0x0EB1, 0x0EB2, 0x0EB3, 0x0EB4, 0x0E9C, 0x0E9D, 0x0E9E, 0x0F45, 0x0F47, 0x0F43, 0x0F49, 0x0F4B, 0x13FB, 0x13B0, 0x0F4D, 0x1403, 0x0F62, 0x1405, 0x143D, 0x13B4, 0x1407, 0x0F5C, 0x143B, 0x1439, 0x1441, 0x143F, 0x13FF, 0x0F5E, 0x0F61, 0x13B8, 0x13B9, 0x13B6, 0x13F8, 0x0E89, 0x0F51, 0x0F50, 0x1401, 0x13B2, 0x0F4F, 0x13FD, 0x13DB, 0x13E2, 0x13DA, 0x13E1, 0x13D4, 0x13DC, 0x13DD, 0x1415, 0x1416, 0x1417, 0x1410, 0x1411, 0x141B, 0x1418, 0x1412, 0x1419, 0x13BF, 0x13C4, 0x13BE, 0x13C5, 0x13CB, 0x13D2, 0x13CC, 0x13D3, 0x13CE, 0x13EC, 0x13ED, 0x13F0, 0x13F1, 0x13EE, 0x13EF, 0x13EB, 0x13F2, 0x1409, 0x13BB, 0x13C0, 0x13BF, 0x1451, 0x1412, 0x1B72, 0x1B73, 0x1B74, 0x1B75, 0x1B76, 0x1B77, 0x1B78, 0x1B79, 0x1B7A, 0x1B7B, 0x0F84, 0x0F85, 0x0F86, 0x1086, 0x108B, 0x1087, 0x108A, 0x1085, 0x1088, 0x1089, 0x0F0F, 0x0F10, 0x0F11, 0x0F13, 0x0F15, 0x0F16, 0x0F18, 0x0F25, 0x0F26, 0x0FEF, 0x0FF0, 0x0FF1, 0x0FF2, 0x1F0B, 0x1545, 0x1547, 0x141B, 0x154B, 0x1549, 0x1F2D, 0x1F2E, 0x1F2F, 0x1F30, 0x1F31, 0x1F32, 0x1F33, 0x1F34, 0x1F35, 0x1F36, 0x1F37, 0x1F38, 0x1F39, 0x1F3A, 0x1F3B, 0x1F3C, 0x1F3D, 0x1F3E, 0x1F3F, 0x1F40, 0x1F41, 0x1F42, 0x1F43, 0x1F44, 0x1F3D, 0x1F3E, 0x1F3F, 0x1F40, 0x1F41, 0x1F42, 0x1F43, 0x1F44, 0x1F4D, 0x1F4E, 0x1F4F, 0x1F50, 0x1F51, 0x1F52, 0x1F53, 0x1F54, 0x1F55, 0x1F56, 0x1F57, 0x1F58, 0x1F59, 0x1F5A, 0x1F5B, 0x1F5C, 0x1F5D, 0x1F5E, 0x1F5F, 0x1F60, 0x1F61, 0x1F62, 0x1F63, 0x1F64, 0x1F65, 0x1F66, 0x1F67, 0x1F68, 0x1F69, 0x1F6A, 0x1F6B, 0x1F6C;
	int Q615 = Q4OA[random(0x00, numInList(Q4OA) - 0x01)];
	if (getNameByType(Q615) == "") {
		return(Q4SJ(Q5KS));
	}
	if (getNameByType(Q615) == "unused") {
		return(Q4SJ(Q5KS));
	}
	return(Q615);
}
