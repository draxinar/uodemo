inherits globals;

member obj Q5YH;

member int Q4YU;

function int Q4V6(obj Q68S) {
	if (hasObjType(Q68S, 0x1BC3) || hasObjTypeInBank(Q68S, 0x1BC3)) {
		return(0x01);
	}
	return(0x00);
}

function int Q4VC(obj Q68S) {
	if (hasObjType(Q68S, 0x1BC4) || hasObjTypeInBank(Q68S, 0x1BC4) || hasObjType(Q68S, 0x1BC5) || hasObjTypeInBank(Q68S, 0x1BC5)) {
		return(0x01);
	}
	return(0x00);
}

function int Q4VD(obj Q68S) {
	if (Q4YU) {
		return(Q4V6(Q68S));
	}
	return(Q4VC(Q68S));
}

function int Q4VB(obj Q68S) {
	if (Q4YU) {
		return(Q4VC(Q68S));
	}
	return(Q4V6(Q68S));
}

function int Q5YE(obj speaker, obj this) {
	list Q5H7;
	string Q58D;
	if (Q4VD(speaker)) {
		Q5H7 = "Hail and well met!", "Greetings, fellow guard.", "In the name of our liege, greetings!", "Greetings, my friend.", "Hail, my friend.", "Yes, thou'rt a virtue guard.", "Hmm? Yes, I am one. So art thou.", "Yes, as thou knowest, it is a great thing to be one!", "Isn't it wonderful being a virtue guard?", "Why dost thou ask about virtue guards when thou art one?";
		Q58D = Q5H7[random(0x00, numInList(Q5H7) - 0x01)];
		bark(this, Q58D);
		return(0x00);
	}
	if (Q4VB(speaker)) {
		Q5H7 = "Stay away, lest our rivalry develop into something worse!", "Thou'rt not of my brotherhood! Away with thee!", "Whilst I grant respect to thy lord, I mislike thy emblem.", "Art thou here to harass me?", "Tch tch... thou wearest the wrong emblem!", "'Tis a pity that thou art in the wrong camp!", "There is a rivalry between thy group and mine--be careful.", "Is not thy emblem a sign that thou art a member of our rival guards?";
		Q58D = Q5H7[random(0x00, numInList(Q5H7) - 0x01)];
		bark(this, Q58D);
		return(0x00);
	}
	if (getNotoriety(speaker) < 0x7F) {
		Q5H7 = "Thou art not worthy of being a member of our fraternity.", "The guards will not accept thee until thy reputation improves.", "Thou hast not the unblemished record we expect from our members.", "Thy record is not good enough to join the guards.", "Only those of utmost probity are accepted into the guards.", "Only the very best of citizens may join the guards.", "Thou dost not qualify for the virtue guards; thy record is not good enough.";
		Q58D = Q5H7[random(0x00, numInList(Q5H7) - 0x01)];
		if (getNotorietyLevel(speaker) > 0x04) {
			Q58D = Q58D + " Thou'rt extremely close, however.";
		} else {
			if (getNotorietyLevel(speaker) < 0x00) {
				Q58D = Q58D + " Do not dishonor us by asking again, scum.";
			}
		}
		bark(this, Q58D);
		return(0x00);
	}
	if (Q4YU) {
		Q5H7 = "Thou hast the look of a likely candidate for joining Lord Blackthorn's guards.", "Wouldst thou be interested in joining Blackthorn's guard?", "Blackthorn's guard hath been looking for folk like thee.", "Thou'rt a good and honest person. Care to join Lord Blackthorn's guard?", "If thou art interested in joining Lord Blackthorn's guard, a place can be found for thee.";
		Q58D = Q5H7[random(0x00, numInList(Q5H7) - 0x01)];
		Q58D = Q58D + " Say 'yea' if thou art interested.";
		bark(this, Q58D);
	} else {
		Q5H7 = "Thou hast the look of a likely candidate for joining Lord British's guards.", "Wouldst thou be interested in joining British's guard?", "British's guard hath been looking for folk like thee.", "Thou'rt a good and honest person. Care to join Lord British's guard?", "If thou art interested in joining Lord British's guard, a place can be found for thee.";
		Q58D = Q5H7[random(0x00, numInList(Q5H7) - 0x01)];
		Q58D = Q58D + " Say 'yea' if thou art interested.";
		bark(this, Q58D);
	}
	Q5YH = speaker;
	return(0x00);
}

trigger speech("virtue*guard") {
	if (getCompileFlag(0x01)) {
		return(0x01);
	}
	int Q4Q1 = Q5YE(speaker, this);
	return(0x00);
}

function int isChaosGuard(obj speaker) {
	return(hasScript(speaker, "chaosguild"));
}

function int isOrderGuard(obj speaker) {
	return(hasScript(speaker, "orderguild"));
}

function int Q4ZT(obj speaker) {
	if (Q4YU) {
		return(isOrderGuard(speaker));
	}
	return(isChaosGuard(speaker));
}

function int Q500(obj speaker) {
	if (Q4YU) {
		return(isChaosGuard(speaker));
	}
	return(isOrderGuard(speaker));
}

function void Q4CQ(obj speaker) {
	list Q5H7;
	string Q58D;
	if (Q500(speaker)) {
		Q5H7 = "Hail and well met!", "Greetings, fellow guard.", "In the name of our liege, greetings!", "Greetings, my friend.", "Hail, my friend.", "Yes, thou'rt a virtue guard.", "Hmm? Yes, I am one. So art thou.", "Yes, as thou knowest, it is a great thing to be one!", "Isn't it wonderful being a virtue guard?";
		Q58D = Q5H7[random(0x00, numInList(Q5H7) - 0x01)];
		if (!Q4VD(speaker)) {
			Q58D = Q58D + "  I see you are in need of our shield.  Here you go.";
			obj Q5RU;
			if (Q4YU) {
				Q5RU = requestCreateObjectIn(0x1BC3, getBackpack(speaker));
			} else {
				Q5RU = requestCreateObjectIn(0x1BC4, getBackpack(speaker));
			}
		}
		bark(this, Q58D);
		return();
	}
	if (Q4ZT(speaker)) {
		Q5H7 = "Stay away, lest our rivalry develop into something worse!", "Thou'rt not of my brotherhood! Away with thee!", "Whilst I grant respect to thy lord, I mislike thy emblem.", "Art thou here to harass me?", "Tch tch... thou wearest the wrong emblem!", "'Tis a pity that thou art in the wrong camp!", "There is a rivalry between thy group and mine--be careful.", "Is not thy emblem a sign that thou art a member of our rival guards?";
		Q58D = Q5H7[random(0x00, numInList(Q5H7) - 0x01)];
		bark(this, Q58D);
		return();
	}
	if (isMurderer(speaker) || (getFameLevel(speaker) < 0x03)) {
		Q5H7 = "Thou art not worthy of being a member of our fraternity.", "The guards will not accept thee until thy reputation improves.", "Thou hast not the unblemished record we expect from our members.", "Thy record is not good enough to join the guards.", "Only those of utmost probity are accepted into the guards.", "Only the very best of citizens may join the guards.", "Thou dost not qualify for the virtue guards; thy record is not good enough.";
		Q58D = Q5H7[random(0x00, numInList(Q5H7) - 0x01)];
		bark(this, Q58D);
		return();
	}
	if (Q4YU) {
		Q5H7 = "Thou hast the look of a likely candidate for joining Lord Blackthorn's guards.", "Wouldst thou be interested in joining Blackthorn's guard?", "Blackthorn's guard hath been looking for folk like thee.", "Thou'rt a good and honest person. Care to join Lord Blackthorn's guard?", "If thou art interested in joining Lord Blackthorn's guard, a place can be found for thee.";
		Q58D = Q5H7[random(0x00, numInList(Q5H7) - 0x01)];
		Q58D = Q58D + " Sign up with a guild of chaos if thou art interested.";
		bark(this, Q58D);
	} else {
		Q5H7 = "Thou hast the look of a likely candidate for joining Lord British's guards.", "Wouldst thou be interested in joining British's guard?", "British's guard hath been looking for folk like thee.", "Thou'rt a good and honest person. Care to join Lord British's guard?", "If thou art interested in joining Lord British's guard, a place can be found for thee.";
		Q58D = Q5H7[random(0x00, numInList(Q5H7) - 0x01)];
		Q58D = Q58D + " Sign up with a guild of order if thou art interested.";
		bark(this, Q58D);
	}
	return();
}

trigger speech("*order*shield*") {
	if (!getCompileFlag(0x01)) {
		return(0x01);
	}
	Q4CQ(speaker);
	return(0x00);
}

trigger speech("*chaos*shield*") {
	if (!getCompileFlag(0x01)) {
		return(0x01);
	}
	Q4CQ(speaker);
	return(0x00);
}

function int Q4V2(obj speaker) {
	if (speaker != Q5YH) {
		return(0x01);
	}
	if ((getNotoriety(speaker) < 0x7F) || Q4VC(speaker) || Q4V6(speaker)) {
		Q5YH = NULL();
		return(0x00);
	}
	obj Q5RU;
	if (Q4YU) {
		Q5RU = requestCreateObjectIn(0x1BC3, getBackpack(speaker));
	} else {
		Q5RU = requestCreateObjectIn(0x1BC4, getBackpack(speaker));
	}
	if (Q5RU == NULL()) {
		bark(this, "I'm sorry, the ranks of the knights are currently full.");
		return(0x00);
	}
	setObjVar(Q5RU, "owner", speaker);
	list Q5H7 = "Excellent! Welcome to our ranks!", "Welcome to our ranks!", "Excellent!", "'Tis a good choice.", "Congratulations!", "I congratulate thee!";
	string Q58D = Q5H7[random(0x00, numInList(Q5H7) - 0x01)];
	Q58D = Q58D + " Thy shield is in thy backpack. Be sure that thou dost ""not lose thy reputation, or else thou shalt lose thy life with it.";
	bark(this, Q58D);
	Q5YH = NULL();
	return(0x00);
}

function int Q4UZ(obj speaker) {
	if (speaker != Q5YH) {
		return(0x01);
	}
	bark(this, "A pity.");
	Q5YH = NULL();
	return(0x00);
}

trigger speech("yes") {
	return(Q4V2(speaker));
}

trigger speech("yea") {
	return(Q4V2(speaker));
}

trigger speech("no") {
	return(Q4UZ(speaker));
}

trigger speech("nay") {
	return(Q4UZ(speaker));
}
