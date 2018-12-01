inherits human_funcs;

forward int Q4CE(string );

forward int Q506(obj );

forward void Q4M5(obj );

forward int Q5TJ(obj , obj , string );

forward int Q5LX(obj , obj , string );

forward int Q5VF(obj , obj , string );

forward int Q4C4(obj , obj , string );

forward int Q4TP(obj , obj , string );

forward int Q4M7(obj , obj , string );

trigger message("getPriceModifier") {
	int Q60J = 0x64;
	int guildMember = 0xFF;
	int Q5SW = 0xFE;
	if (hasObjVar(this, "guildMember")) {
		Q5SW = getObjVar(this, "guildMember");
	}
	if (hasObjVar(sender, "guildMember")) {
		guildMember = getObjVar(sender, "guildMember");
	}
	if (Q5SW == guildMember) {
		Q60J = Q60J - 0x0A;
	}
	int Q5DJ = getNotoriety(sender);
	Q5DJ = Q5DJ / 0x05;
	Q60J = Q60J - Q5DJ;
	return(Q60J);
}

trigger speech("*") {
	int Q5B3 = 0x00;
	debugMessage("Starting stock convo trigger.");
	if (0x00) {
		bark(this, "Standard convo trigger executing.");
	}
	if (isDead(speaker)) {
		return(0x01);
	}
	Q5B3 = Q4ZL(arg, this);
	int Q4QI;
	int i;
	if (!Q4J8(this, speaker, arg)) {
		if (0x00) {
			bark(this, "Failed convo facing check");
		}
		return(0x01);
	}
	if (Q4BO(this)) {
		bark(this, "I am too busy fighting to deal with thee!");
		return(0x00);
	}
	debugMessage("Doing recognition of speaker.");
	if (Q4M0(this, speaker)) {
		if (0x00) {
			debugMessage("Internal recognition keyword called.");
		}
		replyTo(this, speaker, "@InternalRecognition");
		Q4J9(this);
	}
	if (!Q4M7(this, speaker, arg)) {
		return(0x00);
	}
	if (!Q4TP(this, speaker, arg)) {
		return(0x00);
	}
	if (!Q4C4(this, speaker, arg)) {
		return(0x00);
	}
	if (!Q5VF(this, speaker, arg)) {
		return(0x00);
	}
	if (!Q5LX(this, speaker, arg)) {
		return(0x00);
	}
	if (!Q5TJ(this, speaker, arg)) {
		return(0x00);
	}
	if (!Q5B3) {
		if (0x00) {
			bark(this, "Responding now.");
		}
		replyTo(this, speaker, arg);
		Q4J9(this);
	}
	Q45D(this, speaker);
	return(0x00);
}

trigger enterrange(0x01) {
	if (hasObjVar(this, "StandingOnMe")) {
		return(0x01);
	}
	if (!Q50K(this, target)) {
		return(0x01);
	}
	setObjVar(this, "StandingOnMe", target);
	callBack(this, 0x78, 0x0A);
	if (0x00) {
		debugMessage("Personal space trigger activated.");
	}
	return(0x01);
}

trigger leaverange(0x01) {
	if (hasObjVar(this, "StandingOnMe")) {
		removeObjVar(this, "StandingOnMe");
		if (0x00) {
			debugMessage("Removing personal space flag.");
		}
		return(0x01);
	}
	return(0x01);
}

trigger callback(0x0A) {
	if (Q4BO(this)) {
		return(0x00);
	}
	if (!hasObjVar(this, "StandingOnMe")) {
		return(0x00);
	}
	obj Q4UN = getObjVar(this, "StandingOnMe");
	loc Q61E = getLocation(Q4UN);
	loc Q4VS = getLocation(this);
	removeObjVar(this, "StandingOnMe");
	if (getDistanceInTiles(Q4VS, Q61E) < 0x02) {
		if (0x00) {
			bark(this, "You're standing too close, go away.");
		}
		replyTo(this, Q4UN, "@InternalPersonalSpace");
		setObjVar(this, "StandingOnMe", Q4UN);
		callBack(this, 0x64, 0x0A);
	}
	return(0x01);
}

trigger time("hour:**") {
	if (hasObjVar(this, "myJobLocation")) {
		loc place = getObjVar(this, "myJobLocation");
		walkTo(this, place, 0x06);
		return(0x01);
	}
	return(0x01);
}

trigger creation {
	callBack(this, 0xFA, 0x0B);
	if (0x00) {
		debugMessage("Initializing scavenger behavior.");
	}
	return(0x01);
}

function int Q506(obj this) {
	list Q5XE;
	getObjectsInRange(Q5XE, getLocation(this), 0x0A);
	if (numInList(Q5XE) == 0x00) {
		if (0x00) {
			debugMessage("Nothing nearby to scavenge.");
		}
		return(0x00);
	}
	return(0x01);
}

trigger callback(0x0B) {
	callback(this, 0x3C, 0x0B);
	if (!Q506(this)) {
		return(0x01);
	}
	Q4M5(this);
	return(0x01);
}

function void Q4M5(obj this) {
	list Q5XE;
	getObjectsInRange(Q5XE, getLocation(this), 0x0A);
	int Q60R = random(0x00, numInList(Q5XE) - 0x01);
	obj Q61K = Q5XE[Q60R];
	if (!Q5W3(this, Q61K)) {
		return();
	}
	if (getWeight(Q61K) > 0x14) {
		if (0x00) {
			bark(this, "Tried to scavenge something too heavy. :P");
		}
		return();
	}
	if (Q4Z8(this, Q61K)) {
		return();
	}
	if (getObjType(Q61K) == 0x00) {
		return();
	}
	if (hasObjVar(this, "ScavengeLastItemGotten")) {
		obj Q63H = getObjVar(this, "ScavengeLastItemGotten");
		if (hasObj(this, Q63H)) {
			deleteObject(Q63H);
		}
	}
	
member obj Q5OI = Q61K;
	walkTo(this, getLocation(Q61K), 0x08);
	return();
}

trigger pathfound(0x08) {
	replyTo(this, this, "@InternalScavenger");
	if (0x00) {
		string Q4Q1 = getName(Q5OI);
		bark(this, "I found something to scavenge...");
		bark(this, Q4Q1);
	}
	loc there = getLocation(Q5OI);
	int Q4ON = getDirectionInternal(getLocation(this), there);
	Q4J3(this, Q4ON);
	if (giveItem(this, Q5OI) == NULL()) {
		int bar = putObjContainer(Q5OI, this);
	}
	setObjVar(this, "ScavengeLastItemGotten", Q5OI);
	return(0x00);
}

trigger leaverange(0x05) {
	if (Q50K(this, target)) {
		Q45D(this, target);
	}
	return(0x01);
}

trigger enterrange(0x0A) {
	if (!Q50K(this, target)) {
		return(0x01);
	}
	if (0x00) {
		debugMessage("Someone is approaching.");
	}
	Q4M1(this, target, 0x00);
	return(0x01);
}

trigger 0x012Centerrange(0x05) {
	if (!Q50K(this, target)) {
		return(0x01);
	}
	if (!isFacingPerson(this, target)) {
		return(0x01);
	}
	if (Q4M0(this, target)) {
		if (0x00) {
			debugMessage("Issuing greeting message.");
			bark(this, "Hello, I recognize you.");
		}
		if (getNotoriety(target) > 0x5A) {
			int Q602 = getDirectionInternal(getLocation(this), getLocation(target));
			if (getSex(this) == 0x00) {
				Q4M4(this, Q602);
			} else {
				Q4J3(this, Q602);
			}
		}
		replyTo(this, target, "@InternalRecognition");
		Q4J9(this);
	}
	if (!Q5W3(this, this)) {
		return(0x01);
	}
	if (hasObjVar(this, "myJobLocation")) {
		loc myJobLocation = getObjVar(this, "myJobLocation");
		if (getDistanceInTiles(getLocation(this), myJobLocation) > 0x10) {
			return(0x01);
		}
	}
	if (isShopkeeper(this)) {
		replyTo(this, target, "@InternalGreeting");
		Q4J9(this);
	}
	return(0x01)}

trigger creation {
	int Q60C = random(0x01, 0xC8);
	int Q60J = 0x05;
	Q60C = (Q60C * Q60J) - 0x01 + random(0x00, 0x02);
	setDefaultTextHue(this, Q60C);
	if (!isShopkeeper(this)) {
		return(0x01);
	}
	loc Q59O = getLocation(this);
	setObjVar(this, "myJobLocation", Q59O);
	if (0x00) {
		bark(this, "Setting my job location.");
	}
	string myHomeShop;
	if (getSmallestArea(myHomeShop, Q59O)) {
		setObjVar(this, "myHomeShop", myHomeShop);
	}
	callBack(this, 0x64, 0x0C);
	setLoiterMode(this, 0x01);
	setBehavior(this, 0x02);
	return(0x01);
}

trigger callback(0x0C) {
	if (0x00) {
		bark(this, "Doing my job activity.");
		if (!hasObjVar(this, "myJobLocation")) {
			bark(this, "I am missing my job location.");
		}
		loc Q51B = getObjVar(this, "myJobLocation");
		int x = getX(Q51B);
		int y = getY(Q51B);
		string Q61A = x;
		string Q61B = y;
		string place = "My job location is " + Q61A + ", " + Q61B + ".";
		bark(this, place);
	}
	int Q60B = getHour();
	if (hasObjVar(this, "myJobLocation")) {
		loc there = getObjVar(this, "myJobLocation");
		walkTo(this, there, 0x0D);
		if (0x00) {
			debugMessage("Walking back to my job location.");
		}
	}
	callBack(this, 0x64, 0x0C);
	return(0x01);
}

function int Q5TJ(obj this, obj speaker, string arg) {
	if (!Q4J8(this, speaker, arg)) {
		return(0x01);
	}
	list Q619;
	split(Q619, arg);
	int Q4QI = 0x00;
	if (isInList(Q619, "train")) {
		Q4QI = 0x01;
	}
	if (isInList(Q619, "training")) {
		Q4QI = 0x01;
	}
	if (isInList(Q619, "teach")) {
		Q4QI = 0x01;
	}
	if (isInList(Q619, "teaching")) {
		Q4QI = 0x01;
	}
	if (isInList(Q619, "learn")) {
		Q4QI = 0x01;
	}
	if (isInList(Q619, "learning")) {
		Q4QI = 0x01;
	}
	if (isInList(Q619, "practice")) {
		Q4QI = 0x01;
	}
	if (isInList(Q619, "practicing")) {
		Q4QI = 0x01;
	}
	if (!Q4QI) {
		return(0x01);
	}
	int Q4QQ = 0x00;
	list Q5TH = "parrying", "parry", "battle", "defense", "first", "aid", "heal", "healing", "medicine", "hide", "hiding", "steal", "stealing", "alchemy", "anatomy", "animal", "lore", "appraise", "item", "identification", "identify", "armslore", "arms", "beg", "begging", "blacksmith", "smith", "blacksmithy", "smithing", "blacksmithing", "bowyer", "bow", "arrow", "fletcher", "bowcraft", "fletching", "calm", "peace", "peacemaking", "camp", "camping", "carpentry", "woodwork", "woodworking", "cartography", "map", "mapmaking", "cooking", "cook", "detect", "hidden", "entice", "enticement", "enticing", "evaluate", "intelligence", "evaluating", "fish", "fishing", "incite", "provoke", "provoking", "provocation", "lockpicking", "lock", "pick", "picking", "locks", "magic", "magery", "sorcery", "wizardry", "mage", "resist", "resisting", "spells", "battle", "tactic", "tactics", "fight", "fighting", "peek", "peeking", "snoop", "snooping", "play", "instrument", "playing", "musician", "musicianship", "poisoning", "poison", "ranged", "missile", "missiles", "shoot", "shooting", "archery", "archer", "spirit", "ghost", "seance", "spiritualism", "tailoring", "tailor", "clothier", "tame", "animal", "animals", "taming", "taste", "tasting", "tinker", "tinkering", "vet", "veterinarian", "forensic", "forensics", "herd", "herding", "tracking", "track", "hunt", "hunting", "inscribe", "scroll", "inscribing", "inscription", "sword", "swords", "blade", "blades", "swordsman", "swordsmanship", "club", "clubs", "mace", "maces", "dagger", "daggers", "fence", "fencing", "hand", "wrestle", "wrestling";
	string Q5Z4;
	string Q60Z;
	for (int i = 0x00; i < numInList(Q5TH); i++) {
		Q5Z4 = Q5TH[i];
		if (isInList(Q619, Q5Z4)) {
			Q4QQ = 0x01;
			Q60Z = Q5Z4;
		}
	}
	if (!Q4QQ) {
		list Q56X;
		Q56X = "If thy desire is to learn, thou must say what thou wishest to learn.", "I cannot teach thee if thou dost not name what to learn!", "Without the name of a skill, 'tis difficult for me to teach thee.", "If thou namest a skill or ability, perhaps I can aid thee.", "If thou art desirous of practice in a craft or skill, name it when thou askest for aid.";
		if (getIntelligence(this) > 0x46) {
			Q56X = "'Tis a noble endeavor to seek to improve thyself. Perhaps if thou couldst name the particular skill thou seekest to improve?", "If thou failest to name what thou desirest me to teach, I cannot fulfill thy desire!", "'Tis a difficult task to instruct thee in mine arts, if thou dost not specify which of said arts thou seekest to master.", "If thou wouldst name the skill when thou askest, I could, perchance, aid thee.", "I presume that thou art on a quest to locate teachers of some ability. If this is indeed thy desire, name the skill as part of thy inquiry.";
		}
		if (getIntelligence(this) < 0x23) {
			Q56X = "I dunno what thou wishest to learn.", "If thou dost not tell me what thou'rt wantin' to learn, well...", "'Tis hard to teach thee without the name of the skill.", "I mebbe could help thee, methinks, if thou namest what thou'rt wishin' to learn.", "If thou wantest to learn a skill, thou needest name it when thou'rt askin'.";
		}
		string Q60K = Q56X[random(0x00, 0x04)];
		bark(this, Q60K);
		Q4J9(this);
		list Q5TC;
		string Q59Z = "I can teach thee of ";
		if (0x00) {
			bark(this, "All known skill slots...");
		}
		for (int Q65G = 0x00; Q65G < (0x2E - 0x01); Q65G++) {
			if (0x00) {
				string Q49A = Q65G;
				if (getSkillLevel(this, Q65G) > 0x01) {
					bark(this, "Have slot #" + Q49A);
				}
			} else {
				if (getSkillLevel(this, Q65G) > getSkillLevel(speaker, Q65G)) {
					appendToList(Q5TC, Q65G);
				}
			}
		}
		if (numInList(Q5TC) == 0x00) {
			bark(this, "Alas, I cannot teach thee anything.");
			Q4J9(this);
			return(0x00);
		}
		for (Q65G = 0x00; Q65G < numInList(Q5TC); Q65G++) {
			if (Q65G != 0x00) {
				Q59Z = Q59Z + ", ";
			}
			if (Q65G == (numInList(Q5TC) - 0x01)) {
				Q59Z = Q59Z + "and ";
			}
			switch(Q5TC[Q65G]) {
			case 0x00
				Q59Z = Q59Z + "alchemy";
				break;
			case 0x01
				Q59Z = Q59Z + "anatomy";
				break;
			case 0x02
				Q59Z = Q59Z + "animal lore";
				break;
			case 0x03
				Q59Z = Q59Z + "appraising and identifying items";
				break;
			case 0x04
				Q59Z = Q59Z + "arms lore";
				break;
			case 0x05
				Q59Z = Q59Z + "parrying attacks";
				break;
			case 0x06
				Q59Z = Q59Z + "begging";
				break;
			case 0x07
				Q59Z = Q59Z + "blacksmithing";
				break;
			case 0x08
				Q59Z = Q59Z + "the making of bows and fletching of arrows";
				break;
			case 0x09
				Q59Z = Q59Z + "peacemaking";
				break;
			case 0x0A
				Q59Z = Q59Z + "camping in the wilderness";
				break;
			case 0x0B
				Q59Z = Q59Z + "carpentry";
				break;
			case 0x0C
				Q59Z = Q59Z + "cartography and the making of maps";
				break;
			case 0x0D
				Q59Z = Q59Z + "cooking";
				break;
			case 0x0E
				Q59Z = Q59Z + "detecting hidden people";
				break;
			case 0x0F
				Q59Z = Q59Z + "enticing folk with music";
				break;
			case 0x10
				Q59Z = Q59Z + "evaluating people's intelligence";
				break;
			case 0x11
				Q59Z = Q59Z + "basic healing";
				break;
			case 0x12
				Q59Z = Q59Z + "fishing";
				break;
			case 0x13
				Q59Z = Q59Z + "forensic evaluation";
				break;
			case 0x14
				Q59Z = Q59Z + "herding animals";
				break;
			case 0x15
				Q59Z = Q59Z + "hiding in plain sight";
				break;
			case 0x16
				Q59Z = Q59Z + "provoking anger and causing fights";
				break;
			case 0x17
				Q59Z = Q59Z + "inscribing scrolls and books";
				break;
			case 0x18
				Q59Z = Q59Z + "picking locks";
				break;
			case 0x19
				Q59Z = Q59Z + "magery";
				break;
			case 0x1A
				Q59Z = Q59Z + "resisting magic spells";
				break;
			case 0x1B
				Q59Z = Q59Z + "battle tactics";
				break;
			case 0x1C
				Q59Z = Q59Z + "snooping in backpacks";
				break;
			case 0x1D
				Q59Z = Q59Z + "musicianship";
				break;
			case 0x1E
				Q59Z = Q59Z + "the deadly art of poisoning";
				break;
			case 0x1F
				Q59Z = Q59Z + "archery";
				break;
			case 0x20
				Q59Z = Q59Z + "spirit talking";
				break;
			case 0x21
				Q59Z = Q59Z + "stealing";
				break;
			case 0x22
				Q59Z = Q59Z + "tailoring";
				break;
			case 0x23
				Q59Z = Q59Z + "taming wild animals";
				break;
			case 0x24
				Q59Z = Q59Z + "food tasting";
				break;
			case 0x25
				Q59Z = Q59Z + "tinkering";
				break;
			case 0x26
				Q59Z = Q59Z + "tracking";
				break;
			case 0x27
				Q59Z = Q59Z + "veterinary healing";
				break;
			case 0x28
				Q59Z = Q59Z + "swordsmanship";
				break;
			case 0x29
				Q59Z = Q59Z + "clubs and maces";
				break;
			case 0x2A
				Q59Z = Q59Z + "fencing and daggers";
				break;
			case 0x2B
				Q59Z = Q59Z + "hand to hand combat and wrestling";
				break;
			default
				Q59Z = Q59Z + "idle chattering";
				break;
			}
		}
		Q59Z = Q59Z + ".";
		bark(this, Q59Z);
		return(0x00);
	}
	int Q5TI = 0xFF;
	if (Q60Z == "battle") {
		Q5TI = 0x05;
	}
	if (Q60Z == "defense") {
		Q5TI = 0x05;
	}
	if (Q60Z == "parry") {
		Q5TI = 0x05;
	}
	if (Q60Z == "parrying") {
		Q5TI = 0x05;
	}
	if (Q60Z == "first") {
		Q5TI = 0x11;
	}
	if (Q60Z == "aid") {
		Q5TI = 0x11;
	}
	if (Q60Z == "heal") {
		Q5TI = 0x11;
	}
	if (Q60Z == "healing") {
		Q5TI = 0x11;
	}
	if (Q60Z == "medicine") {
		Q5TI = 0x11;
	}
	if (Q60Z == "hide") {
		Q5TI = 0x15;
	}
	if (Q60Z == "hiding") {
		Q5TI = 0x15;
	}
	if (Q60Z == "steal") {
		Q5TI = 0x21;
	}
	if (Q60Z == "stealing") {
		Q5TI = 0x21;
	}
	if (Q60Z == "alchemy") {
		Q5TI = 0x00;
	}
	if (Q60Z == "anatomy") {
		Q5TI = 0x01;
	}
	if (Q60Z == "animal") {
		Q5TI = 0x02;
	}
	if (Q60Z == "lore") {
		Q5TI = 0x02;
	}
	if (Q60Z == "appraise") {
		Q5TI = 0x03;
	}
	if (Q60Z == "identify") {
		Q5TI = 0x03;
	}
	if (Q60Z == "identification") {
		Q5TI = 0x03;
	}
	if (Q60Z == "item") {
		Q5TI = 0x03;
	}
	if (Q60Z == "armslore") {
		Q5TI = 0x04;
	}
	if (Q60Z == "arms") {
		Q5TI = 0x04;
	}
	if (Q60Z == "beg") {
		Q5TI = 0x06;
	}
	if (Q60Z == "begging") {
		Q5TI = 0x06;
	}
	if (Q60Z == "blacksmith") {
		Q5TI = 0x07;
	}
	if (Q60Z == "blacksmithy") {
		Q5TI = 0x07;
	}
	if (Q60Z == "blacksmithing") {
		Q5TI = 0x07;
	}
	if (Q60Z == "smith") {
		Q5TI = 0x07;
	}
	if (Q60Z == "smithing") {
		Q5TI = 0x07;
	}
	if (Q60Z == "bowyer") {
		Q5TI = 0x08;
	}
	if (Q60Z == "bowcraft") {
		Q5TI = 0x08;
	}
	if (Q60Z == "bow") {
		Q5TI = 0x08;
	}
	if (Q60Z == "arrow") {
		Q5TI = 0x08;
	}
	if (Q60Z == "fletcher") {
		Q5TI = 0x08;
	}
	if (Q60Z == "fletching") {
		Q5TI = 0x08;
	}
	if (Q60Z == "calm") {
		Q5TI = 0x09;
	}
	if (Q60Z == "peace") {
		Q5TI = 0x09;
	}
	if (Q60Z == "peacemaking") {
		Q5TI = 0x09;
	}
	if (Q60Z == "camp") {
		Q5TI = 0x0A;
	}
	if (Q60Z == "camping") {
		Q5TI = 0x0A;
	}
	if (Q60Z == "carpentry") {
		Q5TI = 0x0B;
	}
	if (Q60Z == "woodwork") {
		Q5TI = 0x0B;
	}
	if (Q60Z == "woodworking") {
		Q5TI = 0x0B;
	}
	if (Q60Z == "cartography") {
		Q5TI = 0x0C;
	}
	if (Q60Z == "map") {
		Q5TI = 0x0C;
	}
	if (Q60Z == "mapmaking") {
		Q5TI = 0x0C;
	}
	if (Q60Z == "cooking") {
		Q5TI = 0x0D;
	}
	if (Q60Z == "cook") {
		Q5TI = 0x0D;
	}
	if (Q60Z == "detect") {
		Q5TI = 0x0E;
	}
	if (Q60Z == "detecting") {
		Q5TI = 0x0E;
	}
	if (Q60Z == "hidden") {
		Q5TI = 0x0E;
	}
	if (Q60Z == "entice") {
		Q5TI = 0x0F;
	}
	if (Q60Z == "enticement") {
		Q5TI = 0x0F;
	}
	if (Q60Z == "evaluate") {
		Q5TI = 0x10;
	}
	if (Q60Z == "evaluating") {
		Q5TI = 0x10;
	}
	if (Q60Z == "intelligence") {
		Q5TI = 0x10;
	}
	if (Q60Z == "fish") {
		Q5TI = 0x12;
	}
	if (Q60Z == "fishing") {
		Q5TI = 0x12;
	}
	if (Q60Z == "incite") {
		Q5TI = 0x16;
	}
	if (Q60Z == "provoke") {
		Q5TI = 0x16;
	}
	if (Q60Z == "provoking") {
		Q5TI = 0x16;
	}
	if (Q60Z == "provocation") {
		Q5TI = 0x16;
	}
	if (Q60Z == "lockpicking") {
		Q5TI = 0x18;
	}
	if (Q60Z == "lock") {
		Q5TI = 0x18;
	}
	if (Q60Z == "pick") {
		Q5TI = 0x18;
	}
	if (Q60Z == "picking") {
		Q5TI = 0x18;
	}
	if (Q60Z == "locks") {
		Q5TI = 0x18;
	}
	if (Q60Z == "magic") {
		Q5TI = 0x19;
	}
	if (Q60Z == "magery") {
		Q5TI = 0x19;
	}
	if (Q60Z == "mage") {
		Q5TI = 0x19;
	}
	if (Q60Z == "sorcery") {
		Q5TI = 0x19;
	}
	if (Q60Z == "wizardry") {
		Q5TI = 0x19;
	}
	if (Q60Z == "resist") {
		Q5TI = 0x1A;
	}
	if (Q60Z == "resisting") {
		Q5TI = 0x1A;
	}
	if (Q60Z == "spells") {
		Q5TI = 0x1A;
	}
	if (Q60Z == "battle") {
		Q5TI = 0x1B;
	}
	if (Q60Z == "tactic") {
		Q5TI = 0x1B;
	}
	if (Q60Z == "tactics") {
		Q5TI = 0x1B;
	}
	if (Q60Z == "fighting") {
		Q5TI = 0x1B;
	}
	if (Q60Z == "fight") {
		Q5TI = 0x1B;
	}
	if (Q60Z == "peek") {
		Q5TI = 0x1C;
	}
	if (Q60Z == "peeking") {
		Q5TI = 0x1C;
	}
	if (Q60Z == "snooping") {
		Q5TI = 0x1C;
	}
	if (Q60Z == "snoop") {
		Q5TI = 0x1C;
	}
	if (Q60Z == "play") {
		Q5TI = 0x1D;
	}
	if (Q60Z == "playing") {
		Q5TI = 0x1D;
	}
	if (Q60Z == "instrument") {
		Q5TI = 0x1D;
	}
	if (Q60Z == "musician") {
		Q5TI = 0x1D;
	}
	if (Q60Z == "musicianship") {
		Q5TI = 0x1D;
	}
	if (Q60Z == "poisoning") {
		Q5TI = 0x1E;
	}
	if (Q60Z == "poison") {
		Q5TI = 0x1E;
	}
	if (Q60Z == "ranged") {
		Q5TI = 0x1F;
	}
	if (Q60Z == "missile") {
		Q5TI = 0x1F;
	}
	if (Q60Z == "missiles") {
		Q5TI = 0x1F;
	}
	if (Q60Z == "shoot") {
		Q5TI = 0x1F;
	}
	if (Q60Z == "shooting") {
		Q5TI = 0x1F;
	}
	if (Q60Z == "archery") {
		Q5TI = 0x1F;
	}
	if (Q60Z == "archer") {
		Q5TI = 0x1F;
	}
	if (Q60Z == "spirit") {
		Q5TI = 0x20;
	}
	if (Q60Z == "ghost") {
		Q5TI = 0x20;
	}
	if (Q60Z == "ghosts") {
		Q5TI = 0x20;
	}
	if (Q60Z == "seance") {
		Q5TI = 0x20;
	}
	if (Q60Z == "spiritualism") {
		Q5TI = 0x20;
	}
	if (Q60Z == "spiritualism") {
		Q5TI = 0x20;
	}
	if (Q60Z == "tailoring") {
		Q5TI = 0x22;
	}
	if (Q60Z == "tailor") {
		Q5TI = 0x22;
	}
	if (Q60Z == "clothier") {
		Q5TI = 0x22;
	}
	if (Q60Z == "tame") {
		Q5TI = 0x23;
	}
	if (Q60Z == "taming") {
		Q5TI = 0x23;
	}
	if (Q60Z == "animal") {
		Q5TI = 0x23;
	}
	if (Q60Z == "animals") {
		Q5TI = 0x23;
	}
	if (Q60Z == "taste") {
		Q5TI = 0x24;
	}
	if (Q60Z == "tasting") {
		Q5TI = 0x24;
	}
	if (Q60Z == "tinker") {
		Q5TI = 0x25;
	}
	if (Q60Z == "tinkering") {
		Q5TI = 0x25;
	}
	if (Q60Z == "vet") {
		Q5TI = 0x27;
	}
	if (Q60Z == "veterinarian") {
		Q5TI = 0x27;
	}
	if (Q60Z == "veterinary") {
		Q5TI = 0x27;
	}
	if (Q60Z == "forensic") {
		Q5TI = 0x13;
	}
	if (Q60Z == "forensics") {
		Q5TI = 0x13;
	}
	if (Q60Z == "herd") {
		Q5TI = 0x14;
	}
	if (Q60Z == "herding") {
		Q5TI = 0x14;
	}
	if (Q60Z == "track") {
		Q5TI = 0x26;
	}
	if (Q60Z == "tracking") {
		Q5TI = 0x26;
	}
	if (Q60Z == "hunt") {
		Q5TI = 0x26;
	}
	if (Q60Z == "hunting") {
		Q5TI = 0x26;
	}
	if (Q60Z == "inscribe") {
		Q5TI = 0x17;
	}
	if (Q60Z == "scroll") {
		Q5TI = 0x17;
	}
	if (Q60Z == "inscribing") {
		Q5TI = 0x17;
	}
	if (Q60Z == "inscription") {
		Q5TI = 0x17;
	}
	if (Q60Z == "sword") {
		Q5TI = 0x28;
	}
	if (Q60Z == "swords") {
		Q5TI = 0x28;
	}
	if (Q60Z == "blade") {
		Q5TI = 0x28;
	}
	if (Q60Z == "blades") {
		Q5TI = 0x28;
	}
	if (Q60Z == "swordsman") {
		Q5TI = 0x28;
	}
	if (Q60Z == "swordsmanship") {
		Q5TI = 0x28;
	}
	if (Q60Z == "club") {
		Q5TI = 0x29;
	}
	if (Q60Z == "clubs") {
		Q5TI = 0x29;
	}
	if (Q60Z == "mace") {
		Q5TI = 0x29;
	}
	if (Q60Z == "maces") {
		Q5TI = 0x29;
	}
	if (Q60Z == "dagger") {
		Q5TI = 0x2A;
	}
	if (Q60Z == "daggers") {
		Q5TI = 0x2A;
	}
	if (Q60Z == "fence") {
		Q5TI = 0x2A;
	}
	if (Q60Z == "fencing") {
		Q5TI = 0x2A;
	}
	if (Q60Z == "hand") {
		Q5TI = 0x2B;
	}
	if (Q60Z == "wrestle") {
		Q5TI = 0x2B;
	}
	if (Q60Z == "wrestling") {
		Q5TI = 0x2B;
	}
	if (Q5TI == 0xFF) {
		if (0x00) {
			bark(this, "Somehow I recognized a skill keyword but didn't see it the second time I checked...");
		}
		return(0x00);
	}
	if (getSkillLevel(this, Q5TI) < 0x0A) {
		if (0x00) {
			bark(this, Q60Z);
		}
		bark(this, "'Tis not something I can teach thee of.");
		Q4J9(this);
		return(0x00);
	}
	if (getSkillLevel(this, Q5TI) < getSkillLevel(speaker, Q5TI)) {
		bark(this, "I cannot teach thee, for thou knowest more than I!");
		Q4J9(this);
		return(0x00);
	}
	int Q463 = (getSkillLevel(this, Q5TI) - getSkillLevel(speaker, Q5TI));
	if (Q463 < 0x01) {
		bark(this, "I cannot teach thee, for thou knowest all I can teach!");
		Q4J9(this);
		return(0x00);
	}
	Q463 = Q463 * 0x0A;
	string Q5ZZ = Q463;
	string Q44N = "I can teach thee, for a fee. For " + Q5ZZ + " gold coins, I can teach thee all I know. For less, I shall teach thee less.";
	bark(this, Q44N);
	Q4J9(this);
	setObjVar(this, "trainerSkillToTeach", Q5TI);
	setObjVar(speaker, "trainingSkillToLearn", Q5TI);
	return(0x00);
}

function int Q5LX(obj this, obj speaker, string arg) {
	list args;
	int i;
	int Q4QI;
	if (!Q4J8(this, speaker, arg)) {
		return(0x01);
	}
	split(args, arg);
	list Q5B5;
	list memoryRecent;
	list memoryNotoriety;
	if (hasObjVar(this, "memoryRecent")) {
		getObjListVar(memoryRecent, this, "memoryRecent");
	}
	if (hasObjVar(this, "memoryNotoriety")) {
		getObjListVar(memoryNotoriety, this, "memoryNotoriety");
	}
	copyList(Q5B5, memoryRecent);
	if (0x00) {
		debugMessage("Added recent memory to the names check list.");
	}
	list Q61Q;
	obj Q609;
	int Q55T = numInList(memoryNotoriety);
	for (i = 0x00; i < Q55T; i++) {
		copyList(Q61Q, memoryNotoriety[i]);
		Q609 = Q61Q[0x00];
		appendToList(Q5B5, Q609);
		if (0x00) {
			debugMessage("Added a name from fame memory to the names check list.");
		}
	}
	int Q518;
	Q4QI = 0x00;
	string Q60L;
	string Q4BA;
	for (i = 0x00; i < numInList(args); i++) {
		Q60L = args[i];
		for (Q518 = 0x00; Q518 < numInList(Q5B5); Q518++) {
			Q4BA = getName(Q5B5[Q518]);
			if (Q60L == Q4BA) {
				Q4QI = 0x01;
				break;
			}
		}
	}
	if (!Q4QI) {
		Q4QI = Q4CE(arg);
	}
	if (Q4QI) {
		if (0x00) {
			debugMessage("Recognized a name in speech.");
		}
		Q60L = getName(Q5B5[Q518]);
		string Q4W7 = getName(speaker);
		if (Q60L != Q4W7) {
			replyTo(this, Q5B5[Q518], "@InternalNameRecognition");
			Q4J9(this);
			if (0x00) {
				debugMessage("doing Convo Pause");
			}
			obj Q611 = Q5B5[Q518];
			string Q58D = getHeShe(Q611) + " is " + getDirection(getLocation(this), getLocation(Q611)) + ".";
			toUpper(Q58D, 0x00, 0x01);
			bark(this, Q58D);
			if (getDistance(getLocation(this), getLocation(Q611)) == "right here") {
				Q58D = "Just turn around and look.";
			} else {
				if (getDistance(getLocation(this), getLocation(Q611)) == "a long journey") {
					Q58D = "Just turn around and look.";
				} else {
					Q58D = getHeShe(Q611) + " is " + getDistance(getLocation(this), getLocation(Q611)) + " from here.";
					toUpper(Q58D, 0x00, 0x01);
					bark(this, Q58D);
				}
			}
			return(0x00);
		}
		if (0x00) {
			bark(this, "Speaker asked about himself.");
		}
	}
	return(0x01);
}

function int Q5VF(obj this, obj speaker, string arg) {
	list args;
	split(args, arg);
	int Q4QI = 0x00;
	int Q4Q1;
	string bar;
	list Q4BC;
	list Q5Z4;
	string Q4QS;
	if (getResourcesOnObj(this, 0x00, Q5Z4)) {
		copyList(Q4BC, Q5Z4);
	}
	if (getResourcesOnObj(this, 0x02, Q5Z4)) {
		for (int i = 0x00; i < (numInList(Q5Z4) - 0x01); i++) {
			bar = Q5Z4[i];
			appendToList(Q4BC, bar);
		}
	}
	string Q47Y;
	for (i = 0x00; i < numInList(Q4BC); i++) {
		for (int Q518 = 0x00; Q518 < numInList(args); Q518++) {
			bar = Q4BC[i];
			Q47Y = args[Q518];
			if (bar == Q47Y) {
				Q4QI = 0x01;
				Q4QS = Q4BC[i];
			}
		}
	}
	if (Q4QI) {
		if (0x00) {
			bark(this, "Found something!");
			bark(this, Q4QS);
		}
		bar = Q4QS;
		if (getResource(Q4Q1, this, Q4QS, 0x00, 0x02)) {
			bar = getResourceName(Q4QS, 0x00);
		} else {
			if (getResource(Q4Q1, this, Q4QS, 0x02, 0x02)) {
				bar = getResourceName(Q4QS, 0x02);
			}
		}
		setObjVar(this, "CurrentNeedString", bar);
		replyTo(this, speaker, "@InternalNeedResponse");
		Q4J9(this);
		return(0x00);
	}
	return(0x01);
}

function int Q4C4(obj this, obj speaker, string arg) {
	list args;
	split(args, arg);
	if (isInList(args, "time")) {
		string Q613;
		int Q60B;
		string Q4WP;
		int Q60I;
		string Q57B;
		int Q45A = 0x00;
		Q60I = getMinute();
		Q60B = getHour();
		Q60I = Q60I / 0x05;
		switch(Q60I) {
		case 0x00
			Q57B = "";
			Q45A = 0x01;
			break;
		case 0x01
			Q57B = "a few minutes past";
			break;
		case 0x02
			Q57B = "ten past";
			break;
		case 0x03
			Q57B = "quarter past";
			break;
		case 0x04
			Q57B = "twenty minutes past";
			break;
		case 0x05
			Q57B = "a few minutes shy of half-past";
			break;
		case 0x06
			Q57B = "half-past";
			break;
		case 0x07
			Q57B = "just over half-past";
			break;
		case 0x08
			Q57B = "lacking twenty minutes until";
			Q60B = Q60B + 0x01;
			break;
		case 0x09
			Q57B = "quarter of";
			Q60B = Q60B + 0x01;
			break;
		case 0x0A
			Q57B = "ten of";
			Q60B = Q60B + 0x01;
			break;
		case 0x0B
			Q57B = "almost";
			Q60B = Q60B + 0x01;
			Q45A = 0x01;
			break;
		case 0x0C
			Q57B = "";
			Q45A = 0x01;
			break;
		default
			Q57B = "no known minutes!";
			break;
		}
		if (Q60B > 0x17) {
			Q60B = 0x00;
		}
		switch(Q60B) {
		default
			Q4WP = "no known hour!";
			break;
		case 0x00
			Q4WP = "midnight";
			Q45A = 0x00;
			break;
		case 0x0C
			Q4WP = "noon";
			Q45A = 0x00;
			break;
		case 0x01
		case 0x0D
			Q4WP = "one";
			break;
		case 0x02
		case 0x0E
			Q4WP = "two";
			break;
		case 0x03
		case 0x0F
			Q4WP = "three";
			break;
		case 0x04
		case 0x10
			Q4WP = "four";
			break;
		case 0x05
		case 0x11
			Q4WP = "five";
			break;
		case 0x06
		case 0x12
			Q4WP = "six";
			break;
		case 0x07
		case 0x13
			Q4WP = "seven";
			break;
		case 0x08
		case 0x14
			Q4WP = "eight";
			break;
		case 0x09
		case 0x15
			Q4WP = "nine";
			break;
		case 0x0A
		case 0x16
			Q4WP = "ten";
			break;
		case 0x0B
		case 0x17
			Q4WP = "eleven";
			break;
		}
		if (Q45A) {
			Q4WP = Q4WP + " o'clock";
		}
		if ((Q60B > 0x00) && (Q60B < 0x0B)) {
			Q4WP = Q4WP + " in the morning";
		}
		if ((Q60B > 0x0C) && (Q60B < 0x15)) {
			Q4WP = Q4WP + " in the afternoon";
		}
		if (Q60B > 0x14) {
			Q4WP = Q4WP + " at night";
		}
		Q613 = "It is " + Q57B + " " + Q4WP + ".";
		bark(this, Q613);
		Q4J9(this);
		return(0x00);
	}
	return(0x01);
}

function int Q4TP(obj this, obj speaker, string arg) {
	list args;
	split(args, arg);
	int Q4QI = 0x00;
	string Q618;
	list Q5II;
	int Q699;
	for (int i = 0x00; i < numInList(args); i++) {
		Q618 = args[i];
		if (Q618 == "where") {
			Q4QI = 0x01;
			if (0x00) {
				bark(this, "Being asked where something is.");
			}
			Q699 = i;
		}
	}
	if (!Q4QI) {
		return(0x01);
	}
	;
	string Q5QL = "nothing";
	int Q4TS = 0x00;
	Q4QI = 0x00;
	int Q5J5 = 0x01;
	for (i = Q699; i < numInList(args); i++) {
		Q618 = args[i];
		if (Q618 == "shrine") {
			Q5QL = "shrine";
			Q4TS = 0x01;
			Q5J5 = 0x00;
			Q4QI = 0x01;
		}
		if (Q618 == "britain") {
			Q5QL = "city_britain";
			Q618 = "city of Britain";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "buccaneer") {
			Q5QL = "city_bucden";
			Q618 = "island known as Buccaneer's Den";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "jhelom") {
			Q5QL = "city_jhelom";
			Q618 = "city of Jhelom";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "magincia") {
			Q5QL = "city_magincia";
			Q618 = "city of Magincia";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "vesper") {
			Q5QL = "city_vesper";
			Q618 = "lovely city of Vesper";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "minoc") {
			Q5QL = "city_minoc";
			Q618 = "rustic town of Minoc";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "moonglow") {
			Q5QL = "city_moonglow";
			Q618 = "magical city of Moonglow";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "nujel") {
			Q5QL = "city_nujelm";
			Q618 = "city of Nujel'm";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "ocllo") {
			Q5QL = "city_ocllo";
			Q618 = "strange land called Ocllo";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "serpent") {
			Q5QL = "city_serphold";
			Q618 = "fortress called Serpent's Hold";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "skara") {
			Q5QL = "city_skara";
			Q618 = "town of Skara Brae";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "trinsic") {
			Q5QL = "city_trinsic";
			Q618 = "walled city of Trinsic";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "yew") {
			Q5QL = "city_yew";
			Q618 = "city of Yew";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "cove") {
			Q5QL = "city_cove";
			Q618 = "township of Cove";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "abbey") {
			Q5QL = "abbey";
			Q618 = "Empath Abbey";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "alchemist") {
			Q5QL = "alchemist";
			Q4QI = 0x01;
		}
		if (Q618 == "animal") {
			Q5QL = "animaltrainer";
			Q618 = "animal trainer";
			Q4QI = 0x01;
		}
		if ((Q618 == "armorer") || (Q618 == "armourer")) {
			Q5QL = "armorer";
			Q4QI = 0x01;
		}
		if ((Q618 == "artisans") || (Q618 == "artisan")) {
			Q5QL = "artisansguild";
			Q618 = "artisans guild";
			Q4TS = 0x01;
			if (Q618 == "artisans") {
				Q5J5 = 0x00;
			}
			Q4QI = 0x01;
		}
		if ((Q618 == "baker") || (Q618 == "bakery")) {
			Q5QL = "baker";
			if (Q618 == "bakery") {
				Q5J5 = 0x00;
			}
			Q4QI = 0x01;
		}
		if (Q618 == "bank") {
			Q5QL = "bank";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if ((Q618 == "bard") || (Q618 == "bards")) {
			Q5QL = "bard";
			if (Q618 == "bards") {
				Q5J5 = 0x00;
			}
			Q4QI = 0x01;
		}
		if ((Q618 == "bath") || (Q618 == "baths")) {
			Q5QL = "bath";
			if (Q618 == "baths") {
				Q5J5 = 0x00;
			}
			Q4QI = 0x01;
		}
		if (Q618 == "beekeeper") {
			Q5QL = "beekeeper";
			Q4QI = 0x01;
		}
		if ((Q618 == "smith") || (Q618 == "blacksmith")) {
			Q5QL = "blacksmith";
			Q4QI = 0x01;
			Q5J5 = 0x00;
		}
		if (Q618 == "blackthorn") {
			Q5QL = "blackthornkeep";
			Q618 == "Blackthorn's keep";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if ((Q618 == "bowyer") || (Q618 == "fletcher")) {
			Q5QL = "bowyer";
			Q4QI = 0x01;
		}
		if (Q618 == "butcher") {
			Q5QL = "butcher";
			Q4QI = 0x01;
		}
		if (Q618 == "carpenter") {
			Q5QL = "carpenter";
			Q4QI = 0x01;
		}
		if (Q618 == "casino") {
			Q5QL = "casino";
			Q4QI = 0x01;
			Q5J5 = 0x00;
		}
		if (Q618 == "cemetery") {
			Q5QL = "cemetery";
			Q5J5 = 0x00;
			Q4QI = 0x01;
		}
		if (Q618 == "clothier") {
			Q5QL = "clothier";
			Q4QI = 0x01;
		}
		if (Q618 == "cobbler") {
			Q5QL = "cobbler";
			Q4QI = 0x01;
		}
		if (Q618 == "court") {
			Q5QL = "court";
			Q4QI = 0x01;
			Q4TS = 0x01;
		}
		if (Q618 == "customs") {
			Q5QL == "customs";
			Q4QI = 0x01;
			Q5J5 = 0x00;
		}
		if ((Q618 == "docks") || (Q618 == "dock")) {
			Q5QL = "docks";
			Q4QI = 0x01;
			if (Q618 == "docks") {
				Q5J5 = 0x00;
			}
			Q4TS = 0x01;
		}
		if ((Q618 == "duel") || (Q618 == "pit")) {
			Q5QL = "duelpit";
			Q618 == "dueling pit";
			Q4QI = 0x01;
		}
		if (Q618 == "farm") {
			Q5QL = "farm";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "fish") {
			Q5QL = "fishery";
			Q4QI = 0x01;
		}
		if (Q618 == "glassblower") {
			Q5QL = "glassblower";
			Q4QI = 0x01;
		}
		if ((Q618 == "gypsy") || (Q618 == "gypsies")) {
			Q5QL = "gypsy";
			if (Q618 == "gypsies") {
				Q5J5 = 0x00;
			}
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "healer") {
			Q5QL = "healer";
			Q4QI = 0x01;
		}
		if (Q618 == "herbalist") {
			Q5QL = "herbalist";
			Q4QI = 0x01;
		}
		if ((Q618 == "inn") || (Q618 == "hostel")) {
			Q5QL = "inn";
			Q4TS = 0x01;
			Q4QI = 0x01;
			Q5J5 = 0x00;
		}
		if (Q618 == "jail") {
			Q5QL = "jail";
			Q4QI = 0x01;
		}
		if (Q618 == "jeweler") {
			Q5QL = "jeweler";
			Q4QI = 0x01;
		}
		if (Q618 == "castle") {
			Q5QL = "lbcastle";
			Q4TS = 0x01;
			Q5J5 = 0x00;
			Q4QI = 0x01;
		}
		if (Q618 == "library") {
			Q5QL = "library";
			Q4QI = 0x01;
			Q5J5 = 0x00;
		}
		if (Q618 == "lighthouse") {
			Q5QL = "lighthouse";
			Q4TS = 0x01;
			Q5J5 = 0x00;
			Q4QI = 0x01;
		}
		if ((Q618 == "magic") || (Q618 == "mage")) {
			Q5QL = "magic";
			Q4QI = 0x01;
			Q618 = "mage";
		}
		if (Q618 == "merchant") {
			Q5QL = "merchant";
			Q4QI = 0x01;
		}
		if (Q618 == "mill") {
			Q5QL = "mill";
			Q4QI = 0x01;
			Q5J5 = 0x00;
		}
		if (Q618 == "observatory") {
			Q5QL = "observatory";
			Q5J5 = 0x00;
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "painter") {
			Q5QL = "painter";
			Q4QI = 0x01;
		}
		if (Q618 == "paladin") {
			Q5QL = "paladin";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "provisioner") {
			Q5QL = "provisioner";
			Q4QI = 0x01;
		}
		if (Q618 == "shipwright") {
			Q5QL = "shipwright";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if ((Q618 == "stable") || (Q618 == "stables")) {
			Q5QL = "stable";
			if (Q618 == "stables") {
				Q5J5 = 0x00;
			}
			Q4QI = 0x01;
		}
		if (Q618 == "tanner") {
			Q5QL = "tanner";
			Q4QI = 0x01;
		}
		if ((Q618 == "tavern") || ((Q618 == "pub") || (Q618 == "bar"))) {
			Q5QL = "tavern";
			Q4QI = 0x01;
		}
		if (Q618 == "temple") {
			Q5QL = "temple";
			Q4QI = 0x01;
			Q5J5 = 0x00;
		}
		if (Q618 == "theater") {
			Q5QL = "theater";
			Q4QI = 0x01;
			Q5J5 = 0x00;
		}
		if (Q618 == "tinker") {
			Q5QL = "tinker";
			Q4QI = 0x01;
		}
		if ((Q618 == "vet") || (Q618 == "veterinarian")) {
			Q5QL = "vet";
			Q4QI = 0x01;
		}
		if ((Q618 == "weapons") || (Q618 == "weaponeer")) {
			Q5QL = "weaponry";
			Q4QI = 0x01;
			if (Q618 == "weapons") {
				Q5J5 = 0x00;
			}
		}
		if (Q618 == "trainer") {
			Q5QL = "weapontrainer";
			Q4QI = 0x01;
		}
		if (Q618 == "woodworker") {
			Q5QL = "woodworker";
			Q4TS = 0x01;
			Q4QI = 0x01;
		}
		if (Q618 == "guild") {
			string Q5QO;
			string Q4QT;
			Q4TS = 0x01;
			for (int Q518 = 0x00; Q518 < numInList(args); Q518++) {
				Q5QO = args[Q518];
				if (Q5QO == "bard") {
					Q4QT = "bardic guild";
					Q5QL = "bardguild";
					Q4QI = 0x01;
				}
				if ((Q5QO == "fighter") || (Q5QO == "warrior")) {
					Q4QT = "warrior's guild";
					Q5QL = "fighterguild";
					Q4QI = 0x01;
				}
				if (Q5QO == "healer") {
					Q4QT = "healer's guild";
					Q5QL = "healer";
					Q4QI = 0x01;
				}
				if (Q5QO == "merchant") {
					Q4QT = "merchant's guild";
					Q5QL = "merchantguild";
					Q4QI = 0x01;
				}
				if (Q5QO == "miner") {
					Q4QT = "miner's guild";
					Q5QL = "minerguild";
					Q4QI = 0x01;
				}
				if (Q5QO == "ranger") {
					Q4QT = "ranger's guild";
					Q5QL = "rangerguild";
					Q4QI = 0x01;
				}
				if (Q5QO == "tailor") {
					Q4QT = "tailor's guild";
					Q5QL = "tailorguild";
					Q4QI = 0x01;
				}
				if (Q5QO == "tinker") {
					Q4QT = "tinker's guild";
					Q5QL = "tinkerguild";
					Q4QI = 0x01;
				}
			}
		}
	}
	if (!Q4QI) {
		if (0x00) {
			bark(this, "Asked direction to nowhere I recognize.");
		}
		return(0x01);
	}
	string Q601;
	loc Q5ZU;
	loc Q4VS = getLocation(this);
	Q4QI = findClosestArea(Q601, Q5ZU, Q5QL, Q4VS, Q4TS);
	if (Q601 == "") {
		if (Q4QT == "") {
			if (Q5J5 == 0x00) {
				Q601 = Q618 + "s";
			} else {
				Q601 = Q618;
			}
		} else {
			Q601 = Q4QT;
		}
	}
	split(args, Q601);
	Q5QO = args[0x00];
	if (Q5QO == "the") {
		Q618 = "";
	} else {
		Q618 = "the ";
	}
	string Q5N7 = "Thou seekest " + Q618 + Q601 + "?";
	bark(this, Q5N7);
	Q4J9(this);
	if (!Q4QI) {
		bark(this, "I know not where to find that.");
		return(0x00);
	}
	string Q602 = getDirection(Q4VS, Q5ZU);
	string Q603 = getDistance(Q4VS, Q5ZU);
	Q5N7 = "'Tis " + Q603 + " " + Q602 + " from here.";
	if (Q603 == "right here") {
		Q5N7 = "But 'tis " + Q603 + "! Look thee " + Q602 + ".";
	}
	bark(this, Q5N7);
	return(0x00);
}

trigger convofunc("GetNeed") {
	string Q5N7;
	if (hasObjVar(this, "CurrentNeedString")) {
		if (0x00) {
			bark(this, "I had just stored my need.");
		}
		Q5N7 = getObjVar(this, "CurrentNeedString");
		removeObjVar(this, "CurrentNeedString");
		setConvoRet(Q5N7);
		return(0x00);
	}
	list Q4Q6;
	list Q4HN;
	list Q5XL;
	int Q4Q1;
	Q4Q1 = getResourcesOnObj(this, 0x00, Q4Q6);
	if (Q4Q1) {
		copyList(Q4Q6, Q5XL);
	}
	Q4Q1 = getResourcesOnObj(this, 0x02, Q4HN);
	string Q60N;
	if (Q4Q1) {
		if (numInList(Q5XL) > 0x00) {
			for (int i = 0x00; i < numInList(Q4HN); i++) {
				Q60N = Q4HN[i];
				appendToList(Q5XL, Q60N);
			}
		}
	}
	if (numInList(Q5XL) < 0x01) {
		setConvoRet("food");
		return(0x00);
	}
	int Q60R;
	Q60R = (random(0x01, numInList(Q5XL)));
	Q60R--;
	Q60N = Q5XL[Q60R];
	int bar = getResource(Q4Q1, this, Q60N, 0x00, 0x00);
	if (bar) {
		Q60N = getResourceName(Q60N, 0x00);
	} else {
		Q60N = getResourceName(Q60N, 0x02);
	}
	setConvoRet(Q60N);
	return(0x00);
}

trigger convofunc("Leave") {
	int Q602 = getDirectionInternal(getLocation(talker), getLocation(this));
	faceHere(this, Q602);
	removeObjVar(this, "lastSpokeTo");
	setConvoRet("");
	if (hasObjVar(this, "myBoss")) {
		list Q59Q;
		getObjListVar(Q59Q, this, "myBoss");
		if (!isInList(Q59Q, talker)) {
			stopFollowing(this);
		}
	}
	return(0x00);
}

trigger convofunc("Attack") {
	walkTo(this, getLocation(talker), 0x09);
	attack(this, talker);
	setConvoRet("");
	return(0x00);
}

trigger convofunc("getHint") {
	setConvoRet(Q4TQ(this, talker));
	return(0x00);
}

function int Q4M7(obj this, obj speaker, string arg) {
	if (!isShopkeeper(this)) {
		return(0x01);
	}
	loc Q4VS = getLocation(this);
	loc there = getLocation(speaker);
	if (getDistanceInTiles(Q4VS, there) > 0x03) {
		return(0x01);
	}
	list Q51Z;
	list Q5N8;
	list Q619;
	string Q618;
	string Q51Y;
	string Q60W;
	int Q4LG;
	int i;
	int Q518;
	int Q4QI;
	Q4QI = 0x00;
	Q51Z = "buy", "trade", "commerce", "merchant", "shop", "purchase", "business", "open", "shopkeeper", "trader", "tradesman", "shopkeep";
	split(Q619, arg);
	for (i = 0x00; i < numInList(Q619); i++) {
		for (Q518 = 0x00; Q518 < numInList(Q51Z); Q518++) {
			Q51Y = Q51Z[Q518];
			Q618 = Q619[i];
			if (Q618 == Q51Y) {
				Q4QI == 0x01;
			}
		}
	}
	if (!Q4QI) {
		return(0x01);
	}
	Q4QI = 0x00;
	if (hasObjVar(this, "myJobLocation")) {
		loc myJobLocation = getObjVar(this, "myJobLocation");
		if (hasObjVar(this, "myHomeShop")) {
			string myHomeShop = getObjVar(this, "myHomeShop");
			scoreToSpace(myHomeShop);
			list Q5GR;
			split(Q5GR, myHomeShop);
			myHomeShop = Q5GR[0x00];
			if (0x00) {
				bark(this, myHomeShop);
			}
			string Q4GC = "";
			list Q4FM;
			if (getSmallestArea(Q4GC, getLocation(this))) {
				scoreToSpace(Q4GC);
				split(Q4FM, Q4GC);
				Q4GC = Q4FM[0x00];
				if (0x00) {
					bark(this, Q4GC);
				}
			}
			if (Q4GC == myHomeShop) {
				Q4QI = 0x01;
			}
		}
		if (!Q4QI) {
			bark(this, "I am sorry, I do not have my wares here with me. Mayhap if thou didst catch me in my shop.");
			Q4J9(this);
			return(0x00);
		}
	} else {
		bark(this, "Alas, I have no shop! I cannot do business with thee.");
		Q4J9(this);
		return(0x00);
	}
	int guildMember = 0xFF;
	int Q5SW = 0xFE;
	if (hasObjVar(this, "guildMember")) {
		Q5SW = getObjVar(this, "guildMember");
	}
	if (hasObjVar(speaker, "guildMember")) {
		guildMember = getObjVar(speaker, "guildMember");
	}
	if (Q5SW == guildMember) {
		bark(this, "As thou'rt of my same guild, I shall discount my wares to thee.");
		Q4J9(this);
	}
	shopKeeperOpenBusiness(this, speaker);
	setObjVar(this, "wasAskedBuy", 0x01);
	Q4J9(this);
	return(0x01);
}

trigger sawdeath {
	list Q59E;
	if (hasObjVar(this, "myMurderWitnessList")) {
		getObjListVar(Q59E, this, "myMurderWitnessList");
	}
	list Q5OE;
	if ((!isHuman(victim)) || (!isHuman(attacker)) || (isGuard(attacker))) {
		debugMessage("Saw death, one participant is not human, or attack is a guard.");
		return(0x00);
	}
	if (!canSeeObj(this, attacker)) {
		debugMessage("Cannot see attacker.");
		return(0x00);
	}
	if (!canSeeObj(this, victim)) {
		debugMessage("Cannot see victim.");
		return(0x00);
	}
	Q5OE = attacker, victim;
	appendToList(Q59E, Q5OE);
	if (numInList(Q59E) > 0x0A) {
		removeSpecificItem(Q59E, 0x00);
	}
	return(0x00);
}

function int Q4CE(string Q46R) {
	int i;
	list Q59E;
	int Q4QM = 0x00;
	if (!hasObjVar(this, "myMurderWitnessList")) {
		debugMessage("No murder list.");
		return(0x00);
	}
	getObjListVar(Q59E, this, "myMurderWitnessList");
	list Q61X;
	string Q5ZM;
	for (i = 0x00; i < numInList(Q59E); i++) {
		copyList(Q61X, Q59E[i]);
		if (Q46R == getName(Q61X[0x00])) {
			Q5ZM = getName(Q61X[0x00]) + " is a bloody murderer! I saw " + getHimHer(Q61X[0x00]) + " kill " + getName(Q61X[0x01]) + " with my own eyes!";
			Q4QM = 0x01;
			break;
		}
		if (Q46R == getName(Q61X[0x01])) {
			Q5ZM = getName(Q61X[0x01]) + " was brutally slain by " + getName(Q61X[0x00]) + "!" + " I saw it with my own eyes!";
			Q4QM = 0x01;
			break;
		}
	}
	if (Q4QM) {
		Q4J9(this);
		obj Q611 = Q61X[0x00];
		string Q58D = getHeShe(Q611) + " is " + getDirection(getLocation(this), getLocation(Q611)) + ".";
		bark(this, Q58D);
		if (getDirection(getLocation(this), getLocation(Q611)) != "right here") {
			Q58D = "It is " + getDistance(getLocation(this), getLocation(Q611)) + " from here.";
			if (getDistance(getLocation(this), getLocation(Q611)) == "right here") {
				Q58D = "Just turn around and look.";
			}
			bark(this, Q58D);
			return(0x01);
		}
	}
	return(0x00);
}

trigger give {
	if (mobileWillBuy(this, givenobj)) {
		bark(this, "I might be interested in buying this of thee.");
		intRet(0x00);
		return(0x01);
	}
	if (hasObjVar(this, "trainerSkillToTeach")) {
		if (0x00) {
			bark(this, "I am teaching!");
		}
		if (hasObjVar(giver, "trainingSkillToLearn")) {
			if (0x00) {
				bark(this, "And the asker is learning.");
			}
			int Q5TI = getObjVar(this, "trainerSkillToTeach");
			int Q5U5 = getObjVar(giver, "trainingSkillToLearn");
			removeObjVar(this, "trainerSkillToTeach");
			removeObjVar(giver, "trainingSkillToLearn");
			if (Q5TI == Q5U5) {
				if (0x00) {
					bark(this, "And we agree on what to learn.");
				}
				int Q463;
				int Q51L = getResource(Q463, givenobj, "gold", 0x03, 0x02);
				if (0x00) {
					string Q50R = Q463;
					bark(this, Q50R);
					if (!Q51L) {
						bark(this, "Failed to get gold resource on item.");
					}
				}
				if (!Q51L) {
					bark(this, "I require gold in payment!");
					return(0x00);
				}
				if (Q463 < 0x0A) {
					bark(this, "'Tis but a pittance! I require 10 gold at a minimum.");
					return(0x00);
				}
				Q463 = Q463 / 0x0A;
				if (Q463 > 0x00) {
					if (0x00) {
						bark(this, "And I was paid.");
					}
					if (Q463 > getSkillLevel(this, Q5TI)) {
						if (0x00) {
							bark(this, "Overpaid, even.");
						}
						Q463 = getSkillLevel(this, Q5TI) - getSkillLevel(giver, Q5TI);
					}
					addSkillLevel(giver, Q5TI, Q463);
					bark(this, "Let me show thee something of how this is done.");
					Q4J9(this);
					if ((isShopkeeper(this)) && (getObjType(givenobj) == 0x0EED)) {
						int Q5B1 = depositIntoBank(this, givenobj, Q463);
					} else {
						if (!putObjContainer(givenobj, this)) {
							if (teleport(givenobj, getLocation(this))) {
								bark(this, "A pity, I lack the hands to carry the gold!");
							} else {
								bark(this, "Here, thou mayst as well keep thy gold.");
							}
						}
					}
					systemMessage(giver, "Your skill level increases.");
					intRet(0x01);
					return(0x00);
				}
			}
		}
	}
	list Q50W;
	int Q45Y;
	int i;
	int Q518;
	int Q4Q1;
	int Q4QI;
	list Q68E;
	list Q68F;
	list Q68L;
	string Q605;
	string Q616;
	string Q60A;
	string Q612;
	string Q60X;
	int Q4Z4;
	Q60X = getName(givenobj);
	if (getResourcesOnObj(givenobj, 0x03, Q50W)) {
		if (getResourcesOnObj(this, 0x00, Q68E)) {
			for (i = 0x00; i < numInList(Q68E); i++) {
				for (Q518 = 0x00; Q518 < numInList(Q50W); Q518++) {
					Q605 = Q68E[i];
					Q612 = Q50W[Q518];
					if (Q605 == Q612) {
						Q4Z4 = 0x01;
						Q4QI = 0x01;
						if (0x00) {
							bark(this, "Found a food match.");
						}
						Q60X = getResourceName(Q605, 0x00);
					}
				}
			}
		}
		if (getResourcesOnObj(this, 0x02, Q68F)) {
			for (i = 0x00; i < numInList(Q68F); i++) {
				for (Q518 = 0x00; Q518 < numInList(Q50W); Q518++) {
					Q616 = Q68F[i];
					Q612 = Q50W[Q518];
					if (Q616 == Q612) {
						setDesireLevel(this, 0x64);
						if (0x00) {
							bark(this, "Found a desire match.");
						}
						Q4QI = 0x01;
						Q60X = getResourceName(Q616, 0x02);
					}
				}
			}
		}
		string Q58D;
		Q58D = "Thou art giving me " + Q60X + "?";
		bark(this, Q58D);
		Q4J9(this);
		obj Q60Y;
		int Q5ZP;
		int Q4NA;
		if (Q4QI) {
			if (getObjType(givenobj) == 0x0EED) {
				string Q44P;
				Q4NA = getResource(Q5ZP, givenobj, "gold", 0x03, 0x02);
				if (Q5ZP > 0xFA) {
					Q44P = "'Tis a noble gift.";
				} else {
					Q44P = "Money is always welcome.";
				}
				bark(this, Q44P);
			}
			Q4J9(this);
			if (0x00) {
				bark(this, "Accepting item.");
			}
			if (isShopkeeper(this)) {
				if (getObjType(givenobj) == 0x0EED) {
					Q4NA = getResource(Q5ZP, givenobj, "gold", 0x03, 0x02);
					Q4NA = depositIntoBank(this, givenobj, Q5ZP);
					intRet(0x01);
					return(0x01);
				} else {
					Q4Q1 = putObjContainer(givenobj, this);
					if (!Q4Q1) {
						Q4Q1 = teleport(givenobj, getLocation(this));
						bark(this, "Oops, I dropped it.");
					}
				}
			} else {
				Q4Q1 = putObjContainer(givenobj, this);
				if (!Q4Q1) {
					Q4Q1 = teleport(givenobj, getLocation(this));
					bark(this, "Oops, I dropped it.");
				}
			}
			if (Q4Z4) {
				bark(this, "This tasteth good.");
				list Q5TW = 0x3C, 0x3B, 0x3A;
				sfx(getLocation(this), Q5TW[random(0x00, 0x02)], 0x00);
			}
			list Q4XZ;
			obj Q4CW;
			obj Q4W2;
			int Q4W3 = 0x00;
			list Q67C;
			getContents(Q4XZ, this);
			for (i = 0x00; i < numInList(Q4XZ); i++) {
				Q4CW = Q4XZ[i];
				if (getResourcesOnObj(Q4CW, 0x03, Q67C)) {
					Q45Y = 0x00;
					Q4Q1 = getResource(Q45Y, Q4CW, "magic", 0x03, 0x02);
					if (Q45Y > Q4W3) {
						Q4W3 = Q45Y;
						Q4W2 = Q4CW;
					}
				}
			}
			list Q5ZY;
			getContainersOnMobile(Q5ZY, this);
			for (i = 0x00; i < numInList(Q5ZY); i++) {
				Q4CW = Q5ZY[i];
				getContents(Q4XZ, Q4CW);
				for (Q518 = 0x00; Q518 < numInList(Q4XZ); Q518++) {
					Q4CW = Q4XZ[Q518];
					if (getResourcesOnObj(Q4CW, 0x03, Q67C)) {
						Q45Y = 0x00;
						Q4Q1 = getResource(Q45Y, Q4CW, "magic", 0x03, 0x02);
						if (Q45Y > Q4W3) {
							Q4W3 = Q45Y;
							Q4W2 = Q4CW;
						}
					}
				}
			}
			Q60Y = Q4W2;
			if (Q60Y == NULL()) {
				if (hasObjVar(this, "ScavengeLastItemGotten")) {
					obj Q60E = getObjVar(this, "ScavengeLastItemGotten");
					if (hasObj(this, Q60E)) {
						Q60Y = Q60E;
					}
				}
			}
			if (Q60Y == NULL()) {
				i = getValue(givenobj);
				if (getObjType(givenobj) == 0x0EED) {
					i = 0x00;
				}
				if (getObjType(givenobj) == 0x0EEE) {
					i = 0x00;
				}
				if (getObjType(givenobj) == 0x0EEF) {
					i = 0x00;
				}
				if (i) {
					Q60Y = transferGenericToContainer(this, this, 0x0EED, i);
					if (Q60Y != NULL()) {
						sfx(getLocation(giver), 0x35, 0x00);
					}
				}
			}
			if (getNotoriety(this) > 0x00) {
				addNotoriety(giver, 0x05);
			} else {
				removeNotoriety(giver, 0x05);
			}
			Q4M1(this, giver, 0x32);
			if (hasObjVar(this, "myBoss")) {
				list Q59Q;
				getObjListVar(Q59Q, this, "myBoss");
				if (!isInList(Q59Q, giver)) {
					stopFollowing(this);
				}
			}
			setDesireLevel(this, 0xC8);
			if (Q60Y == NULL()) {
				bark(this, "I thank thee.");
				bark(this, Q4TQ(this, giver));
				intRet(0x01);
				return(0x00);
			}
			replyTo(this, giver, "@InternalAcceptItem");
			Q58D = "Please accept ";
			i = getObjType(Q60Y);
			Q58D = Q58D + getArticle(i);
			Q58D = Q58D + " ";
			Q58D = Q58D + getName(Q60Y);
			Q58D = Q58D + ".";
			if (giveItem(giver, Q60Y) == NULL()) {
				i = teleport(Q60Y, getLocation(giver));
			}
			bark(this, Q58D);
			intRet(0x01);
			return(0x00);
		}
	}
	setObjVar(this, "theItemGiven", Q60X);
	if (0x00) {
		bark(this, "Refusing item.");
	}
	bark(this, "I am not interested in this.");
	replyTo(this, giver, "@InternalRefuseItem");
	if (giveItem(giver, givenobj) == NULL()) {
		bark(this, "Thy hands are full, so here 'tis, on the ground.");
		i = teleport(givenobj, getLocation(giver));
	}
	Q4J9(this);
	return(0x00);
}

trigger convofunc("GetItem") {
	string theItemGiven;
	if (hasObjVar(this, "theItemGiven")) {
		theItemGiven = getObjVar(this, "theItemGiven");
		removeObjVar(this, "theItemGiven");
	} else {
		theItemGiven = "item";
	}
	setConvoRet(theItemGiven);
	return(0x00);
}

trigger gotattacked {
	Q4M1(this, attacker, 0x4B);
	return(0x01);
}
