inherits sndfx;

forward void Q4J3(obj , int );

forward void Q4M4(obj , int );

forward int Q50K(obj , obj );

forward void Q45D(obj , obj );

forward void Q4M1(obj , obj , int );

forward void Q4J9(obj );

forward int Q4CH(obj , list );

forward int Q4J8(obj , obj , string );

forward string Q4TQ(obj , obj );

forward int Q4BO(obj );

forward int Q4Z8(obj , obj );

forward int Q4ZL(string , obj );

forward int Q4LZ(obj , obj );

forward int Q4JV(obj , obj );

forward int Q4M0(obj , obj );

forward int Q5W3(obj , obj );

function void Q4J3(obj this, int Q4ID) {
	faceHere(this, Q4ID);
	animateMobile(this, 0x20, 0x05, 0x01, 0x00, 0x03);
	return();
}

function void Q4M4(obj this, int Q4ID) {
	faceHere(this, Q4ID);
	animateMobile(this, 0x21, 0x05, 0x01, 0x00, 0x01);
	return();
}

function int Q50K(obj this, obj target) {
	if (!isHuman(target)) {
		return(0x00);
	}
	if (isNPC(target)) {
		return(0x00);
	}
	if (isDead(target)) {
		return(0x00);
	}
	if (!canSeeObj(this, target)) {
		return(0x00);
	}
	return(0x01);
}

function void Q45D(obj this, obj target) {
	list memoryRecent;
	if (hasObjVar(this, "memoryRecent")) {
		getObjListVar(memoryRecent, this, "memoryRecent");
	}
	removeSpecificItem(memoryRecent, target);
	appendToList(memoryRecent, target);
	if (0x00) {
		bark(this, "I am remembering ");
		bark(this, getName(target));
	}
	if (0x00) {
		debugMessage("Recognizing someone from a distance.");
	}
	if (numInList(memoryRecent) > 0x1E) {
		removeItem(memoryRecent, 0x00);
	}
	setObjVar(this, "memoryRecent", memoryRecent);
	return();
}

function void Q4M1(obj this, obj target, int mod) {
	if (!Q50K(this, target)) {
		return();
	}
	loc Q4VS = getLocation(this);
	loc Q60S = getLocation(target);
	int Q603 = getDistanceInTiles(Q4VS, Q60S);
	list memoryNotoriety;
	list memoryRecent;
	if (hasObjVar(this, "memoryNotoriety")) {
		getObjListVar(memoryNotoriety, this, "memoryNotoriety");
	}
	if (hasObjVar(this, "memoryRecent")) {
		getObjListVar(memoryRecent, this, "memoryRecent");
	}
	int Q4OW;
	if (!getCompileFlag(0x01)) {
		Q4OW = getNotoriety(target) + mod;
	} else {
		Q4OW = getFame(target) + mod;
	}
	if (Q4OW < 0x00) {
		Q4OW = 0x00 - Q4OW;
	}
	list Q61Q;
	list Q63D;
	int Q45N;
	int Q61D;
	obj Q5ZK;
	list Q5H1;
	setItem(Q5H1, target, 0x00);
	setItem(Q5H1, Q4OW, 0x01);
	setItem(Q5H1, 0x00, 0x02);
	obj Q5H0;
	int Q55T = numInList(memoryNotoriety);
	if (0x00) {
		debugMessage("Updating memory of famous folks.");
	}
	for (int i = 0x00; i < Q55T; i++) {
		copyList(Q61Q, memoryNotoriety[i]);
		Q5ZK = Q61Q[0x00];
		Q5H0 = Q5H1[0x00];
		if (Q5ZK == Q5H0) {
			removeItem(memoryNotoriety, i);
			Q55T--;
			if (0x00) {
				debugMessage("Found this guy in notoriety memory, erasing.");
			}
			break;
		}
	}
	for (i = 0x00; i < Q55T; i++) {
		copyList(Q61Q, memoryNotoriety[i]);
		Q45N = Q61Q[0x02];
		Q61D = Q61Q[0x01];
		Q5ZK = Q61Q[0x00];
		Q45N++;
		setItem(Q61Q, Q45N, 0x02);
		setItem(memoryNotoriety, Q61Q, i);
		if ((Q61D - Q45N) <= Q4OW) {
			appendToList(Q63D, i);
			if (0x00) {
				debugMessage("Found someone to forget.");
			}
		}
	}
	if (numInList(Q63D) != 0x00) {
		int Q548 = 0x00;
		int Q549 = 0x0F;
		int Q61T;
		for (i = 0x00; i < numInList(Q63D); i++) {
			Q61T = Q63D[i];
			copyList(Q61Q, memoryNotoriety[Q61T]);
			Q45N = Q61Q[0x02];
			Q61D = Q61Q[0x01];
			if (Q61D < Q549) {
				Q548 = i;
				Q549 = Q61D;
			}
		}
		int Q60R = Q63D[Q548];
		removeItem(memoryNotoriety, Q60R);
		if (0x00) {
			debugMessage("Removing a forgettable person.");
		}
		appendToList(memoryNotoriety, Q5H1);
	} else {
		if (numInList(memoryNotoriety) < 0x0A) {
			appendToList(memoryNotoriety, Q5H1);
		}
	}
	setObjVar(this, "memoryNotoriety", memoryNotoriety);
	return();
}

function void Q4J9(obj this) {
	if (!isGuard(this)) {
		disableBehaviors(this);
	}
	if (0x00) {
		bark(this, "Starting convo pause.");
	}
	callBack(this, 0x2D, 0x38);
	return();
}

trigger callback(0x38) {
	disableBehaviors(this);
	int myLoyalty = 0x00;
	if (hasObjVar(this, "myLoyalty")) {
		myLoyalty = getObjVar(this, "myLoyalty");
	}
	if (myLoyalty < 0x01) {
		enableBehaviors(this);
		list Q5N8;
		Q5N8 = "'Twas nice speaking with thee.", "I suppose I have other things to do.", "Thou seemst to be done speaking with me.", "Unless thou needest aught else, I am done with speaking.", "Unless thou needest aught else, I have my work to do.", "'A pleasure talking with thee.", "Farewell.", "Goodbye.", "Until later.", "Until we meet again.", "'Twas a pleasure.", "Farewell for now.", "Goodbye for now.", "Thou'rt done, and I have work to do.", "I have matters to attend to.", "Fare thee well.";
		if (getIntelligence(this) < 0x22) {
			Q5N8 = "'Twas nice speakin' with ye.", "I's got other things to do, I reckon.", "Thou seemst to be done speakin' to me.", "'Less'n thou needst aught else, I's done.", "'Less'n thou needst aught else, I's got work to be doing.", "Nice talkin' with thee.", "Farewell.", "Bye!", "'Til later.", "'Til we meet again.", "Farewell for now.", "Goodbye for now.", "Thee's done, and I have work to do.", "I's got things to do.", "Fare thee well.";
		}
		if (0x00) {
			bark(this, "Ending convo pause.");
		}
		if (hasObjVar(this, "lastSpokeTo")) {
			obj Q54G = getObjVar(this, "lastSpokeTo");
			removeObjVar(this, "lastSpokeTo");
			if (hasObjVar(this, "wasAskedBuy")) {
				removeObjVar(this, "wasAskedBuy");
				return(0x00);
			}
			list Q5YQ;
			getTargets(Q5YQ, this);
			if (numInList(Q5YQ) > 0x00) {
				return(0x00);
			}
			if (getDistanceInTiles(getLocation(this), getLocation(Q54G)) < 0x05) {
				bark(this, Q5N8[random(0x00, (numInList(Q5N8) - 0x01))]);
			}
		}
	}
	return(0x00);
}

function int Q4CH(obj this, list args) {
	int Q4QI = 0x00;
	if (isInList(args, getName(this))) {
		Q4QI = 0x01;
	}
	if (isShopkeeper(this)) {
		if (isInList(args, "shopkeep")) {
			Q4QI = 0x01;
		}
		if (isInList(args, "shopkeeper")) {
			Q4QI = 0x01;
		}
		if (isInList(args, "merchant")) {
			Q4QI = 0x01;
		}
		if (isInList(args, "vendor")) {
			Q4QI = 0x01;
		}
		if (isInList(args, "vender")) {
			Q4QI = 0x01;
		}
	}
	if (isGuard(this)) {
		if (isInList(args, "guard")) {
			Q4QI = 0x01;
		}
	}
	return(Q4QI);
}

function int Q4J8(obj this, obj speaker, string arg) {
	loc Q4VS = getLocation(this);
	loc there = getLocation(speaker);
	int Q602 = getDirectionInternal(Q4VS, there);
	
member int Q5M8 = Q602;
	list args;
	split(args, arg);
	int Q4QI = 0x00;
	int Q4KB = 0x01;
	if (isDead(speaker)) {
		return(0x00);
	}
	if (!canSeeObj(this, speaker)) {
		return(0x00);
	}
	if (getDistanceInTiles(getLocation(this), getLocation(speaker)) > 0x05) {
		return(0x00);
	}
	obj lastSpokeTo = NULL();
	if (hasObjVar(this, "lastSpokeTo")) {
		lastSpokeTo = getObjVar(this, "lastSpokeTo");
		if (lastSpokeTo == speaker) {
			Q4KB = 0x00;
			if (getDistanceInTiles(getLocation(this), getLocation(speaker)) < 0x06) {
				faceHere(this, getDirectionInternal(getLocation(this), getLocation(speaker)));
			}
		}
	}
	if (!isFacingPerson(speaker, this)) {
		if (lastSpokeTo != NULL()) {
			if (getDistanceInTiles(getLocation(this), getLocation(speaker)) < 0x04) {
				if (lastSpokeTo == speaker) {
					Q4QI = 0x01;
					Q4KB = 0x00;
				}
			}
		}
		if (getDistanceInTiles(getLocation(speaker), getLocation(this)) < 0x02) {
			Q4QI = 0x01;
		}
		if (!Q4CH(this, args)) {
			Q4QI = 0x00;
		}
		if (Q4QI) {
			faceHere(this, getDirectionInternal(getLocation(this), getLocation(speaker)));
			if (Q4KB) {
				replyTo(this, speaker, "@InternalConvinit");
			}
			Q4J9(this);
			setObjVar(this, "lastSpokeTo", speaker);
			return(0x01);
		}
		return(0x00);
	}
	if (!isFacingPerson(this, speaker)) {
		if (0x00) {
			bark(this, "We are not facing each other.");
		}
		string Q618;
		int i;
		Q4QI = 0x00;
		if (isInList(args, getName(this))) {
			Q4QI = 0x01;
			if (0x00) {
				debugMessage("Detected my name in a speech trigger.");
			}
		}
		if (getDistanceInTiles(getLocation(speaker), getLocation(this)) < 0x04) {
			if (Q4CH(this, args)) {
				Q4QI = 0x01;
			}
		}
		if (lastSpokeTo != NULL()) {
			if (lastSpokeTo == speaker) {
				Q4KB = 0x00;
				Q4QI = 0x01;
			}
		}
		if (!Q4QI) {
			return(0x00);
		}
		if (lastSpokeTo != NULL()) {
			if (lastSpokeTo != speaker) {
				if (getDistanceInTiles(getLocation(this), getLocation(lastSpokeTo)) < 0x05) {
					int Q4ID = getDirectionInternal(getLocation(this), getLocation(lastSpokeTo));
					faceHere(this, Q4ID);
					string Q4OD = "Excuse me, " + getName(lastSpokeTo) + ", but " + getName(speaker) + " is calling me.";
					bark(this, Q4OD);
					Q4KB = 0x01;
				}
			}
		}
		if (0x00) {
			debugMessage("Calling the convinit keyword.");
		}
		faceHere(this, Q602);
		if (Q4KB) {
			replyTo(this, speaker, "@InternalConvinit");
		}
		int bow = 0x00;
		if (!getCompileFlag(0x01)) {
			if (getNotoriety(speaker) > 0x5A) {
				bow = 0x01;
			}
		} else {
			if (getFameLevel(speaker) > 0x03) {
				bow = 0x01;
			}
		}
		if (bow) {
			if (getSex(this) == 0x00) {
				Q4M4(this, Q602);
			} else {
				Q4J3(this, Q602);
			}
		}
		setObjVar(this, "lastSpokeTo", speaker);
		Q4J9(this);
	}
	int Q68W = 0x01;
	if (hasObjVar(this, "myJobLocation")) {
		loc myJobLocation = getObjVar(this, "myJobLocation");
		if (getDistanceInTiles(getLocation(this), myJobLocation) > 0x10) {
			Q68W = 0x00;
		}
	}
	if (isGuard(this)) {
		Q68W = 0x00;
	}
	Q68W = 0x00;
	if (isInList(args, "come")) {
		if (Q68W) {
			walkTo(this, getLocation(speaker), 0x05);
			callback(this, 0x2D, 0x0C);
		}
	} else {
		if (getDistanceInTiles(Q4VS, there) > 0x03) {
			if (Q68W) {
				walkTo(this, interpose(Q4VS, there), 0x05);
				if (0x00) {
					debugMessage("Walking closer to speaker.");
				}
			}
		}
	}
	return(0x01);
}

trigger pathfound(0x05) {
	faceHere(this, Q5M8);
	return(0x00);
}

trigger pathnotfound(0x05) {
	faceHere(this, Q5M8);
	return(0x00);
}

function string Q4TQ(obj this, obj talker) {
	int Q563;
	int Q65M;
	obj Q46X;
	int Q54T;
	string Q46Y;
	string Q4XO;
	loc place;
	obj Q4WD;
	string Q4WI;
	int Q45N;
	loc Q5M7;
	string Q5N7;
	string Q496;
	list Q5N8;
	int Q4QK;
	Q563 = getIntelligence(this) / 0x0A;
	Q4QK = getHint(this, Q563, Q65M, Q46X, Q54T, Q46Y, Q4XO, place, Q4WD, Q4WI, Q45N);
	if ((Q4WD == this) || (Q4WD == talker)) {
		Q4QK = 0x00;
	}
	if (!Q4QK) {
		Q5N8 = "I have not heard any interesting tales lately.", "I can't tell thee much that thou dost not already know.", "I haven't heard much news that would be of interest to thee.", "I haven't heard much lately.", ",I can't tell thee much. I haven't heard anything interest ing.", "No rumors of note are circulating.", "'Tis a pity, but gossip is scarce these days.", "I have heard no rumors lately.", "The rumor mill seemeth to have taken a break lately, methinks.", "Life is dull, methinks, for I have not heard interesting rumors of late.";
		if (Q563 < 0x04) {
			Q5N8 = "I's not heard much lately.", "Has ye heard about the donkey accident?", "Ain't no good gossip hereabouts.", "No stories worth tellin' these days.", "Ho-hum.", "I ain't been hearin' nothin'.", "I ain't been party to no gossip lately.", "I's heard nothing that'd interest thee, I assure ye.", "I 'aven't 'eard nothin' interestin'.", "I haven't picked up anythin' new.";
		}
		if (Q563 > 0x06) {
			Q5N8 = "'Tis a failing of mine, but I follow the rumors of the common folk. ""None seem interesting of late, however.", "Quite a shame, but I have not heard any interesting tales of late.", "No tales of folly or woe, nor indeed any of powerful magical artifacts, have ""reached mine ears in the last few days.", "While petty gossip is a fault, surely restrained rumormongering is not!", "Alas, no rumors bear repeating these days.", "One could wish for a livelier life, with more tales to tell.", "I cannot tell thee much, I fear. No tales of interest have crossed my path.", "No new gossip has reached mine ears, to my great regret.", "Knowing thy elevated tastes, I fear that nothing I can tell thee would be of interest.", "New rumors have been slow in coming of late. I regret that I have none to pass along to thee!";
		}
		Q5N7 = Q5N8[random(0x00, (numInList(Q5N8) - 0x01))];
		return(Q5N7);
	}
	string Q60S;
	string Q612;
	Q5N8 = "Rumor has it that ", "According to tales, ", "I have heard that ", "Thou didst not hear this from me, but ", "Hast thou heard that ", "Some say that ", "According to some, ", "'Tis bandied about that ", "The word is, ", "The word is that ", "'Tis rumored that ", "'Tis said that ", "Gossip has it that ", "Tongues are wagging! They say that ", "All that rumormongerers can think about is that ", "All I hear of these days is that ", "They are saying that ";
	Q5N7 = Q5N8[random(0x00, 0x10)];
	if (Q4WI == "") {
		if (random(0x00, 0x09) > Q563) {
			Q5N7 = Q5N7 + Q46Y;
		} else {
			Q5N7 = Q5N7 + Q4XO;
		}
		Q496 = Q496 + " is ";
	} else {
		Q5N7 = Q5N7 + Q4WI;
		Q5N7 = Q5N7 + " has ";
		if (random(0x00, 0x09) > Q563) {
			Q5N7 = Q5N7 + Q46Y;
		} else {
			Q5N7 = Q5N7 + Q4XO;
		}
		Q5N7 = Q5N7 + " and " + getHeShe(Q4WD);
	}
	string Q5Z4;
	int Q4QO = getLocalizedDesc(Q496, Q5M7, place, getLocation(this));
	if (Q4QO > 0x00) {
		if ((Q4QO == 0x02) || (Q4QO == 0x04)) {
			Q5Z4 = Q5Z4 + " here";
		}
		Q5Z4 = Q5Z4 + " in";
		Q5Z4 = Q5Z4 + Q496;
		if (Q4QO == 0x03) {
			place = Q5M7;
		}
	}
	Q5N7 = Q5N7 + " ";
	loc Q4VS = getLocation(this);
	string Q4ID = getDirection(Q4VS, place);
	clearList(Q5N8);
	Q5N8 = "may be about. ", "can be found. ", "might be nearby. ", "could be around. ", "is somewhere close. ", "is nearby. ", "might be found close by. ", "may be somewhere close. ";
	Q496 = Q5N8[random(0x00, (numInList(Q5N8) - 0x01))];
	clearList(Q5N8);
	Q5N8 = "Look thee", "Hast thou looked", "Thou mightest look", "Hast thou checked", "I wonder if any have looked", "Possibly", "Perchance 'tis";
	string Q4TT = Q5N8[random(0x00, (numInList(Q5N8) - 0x01))];
	if (Q5Z4 != "") {
		Q5N7 = Q5N7 + " ";
		Q5N7 = Q5N7 + Q5Z4;
		Q5N7 = Q5N7 + ",";
	}
	Q5N7 = Q5N7 + Q496 + Q4TT + " " + Q4ID + "?";
	return(Q5N7);
}

function int Q4BO(obj this) {
	list Q5YQ;
	getTargets(Q5YQ, this);
	return(numInList(Q5YQ));
}

function int Q4Z8(obj this, obj Q61K) {
	if (hasObjVar(this, "guardList")) {
		list Q60F;
		getObjListVar(Q60F, this, "guardList");
		for (int i = 0x00; i < numInList(Q60F); i++) {
			obj Q53B = Q60F[i];
			if (Q53B == Q61K) {
				return(0x01);
			}
		}
	}
	return(0x00);
}

function int Q4ZL(string arg, obj this) {
	list args;
	split(args, arg);
	if (numInList(args) < 0x02) {
		if (Q4CH(this, args)) {
			return(0x01);
		}
	}
	return(0x00);
}

function int Q4LZ(obj this, obj target) {
	list memoryRecent;
	if (hasObjVar(this, "memoryRecent")) {
		getObjListVar(memoryRecent, this, "memoryRecent");
	} else {
		return(0x00);
	}
	int Q4QI = 0x00;
	obj Q609;
	if (isInList(memoryRecent, target)) {
		Q4QI = 0x01;
		if (0x00) {
			debugMessage("Found target in recent memory");
		}
	}
	return(Q4QI);
}

function int Q4JV(obj this, obj target) {
	list memoryNotoriety;
	if (hasObjVar(this, "memoryNotoriety")) {
		getObjListVar(memoryNotoriety, this, "memoryNotoriety");
	} else {
		return(0x00);
	}
	list Q5H0;
	obj Q609;
	int Q55T = numInList(memoryNotoriety);
	for (int i = 0x00; i < Q55T; i++) {
		copyList(Q5H0, memoryNotoriety[i]);
		Q609 = Q5H0[0x00];
		if (target == Q609) {
			return(0x01);
			if (0x00) {
				debugMessage("Found target in fame memory.");
			}
		}
	}
	return(0x00);
}

function int Q4M0(obj this, obj target) {
	int Q4QI = Q4LZ(this, target);
	int Q4QR = Q4JV(this, target);
	if (Q4QI) {
		return(0x00);
	}
	if (Q4QR) {
		return(0x01);
	}
	return(0x00);
}

function int Q5W3(obj this, obj Q61K) {
	list Q5XE;
	getStaticObjectsAt(Q5XE, getLocation(Q61K));
	if (0x00) {
		bark(this, "Static objects at target:");
		string debug = numInList(Q5XE);
		bark(this, debug);
	}
	if (numInList(Q5XE) > 0x00) {
		if (0x00) {
			debugMessage("Statics at chosen item.");
			for (int Q5GD = 0x00; Q5GD < numInList(Q5XE); Q5GD++) {
				obj Q527 = Q5XE[Q5GD];
				string Q4PZ = getName(Q527);
				bark(this, Q4PZ);
			}
		}
		return(0x00);
	}
	return(0x01);
}
