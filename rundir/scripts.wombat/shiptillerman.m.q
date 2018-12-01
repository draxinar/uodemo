inherits shipstuff;

member int Q5BA;

member obj Q55D;

member int Q5ST;

member int Q5SI;

member int Q5SC;

member int Q4V5;

member int Q464;

forward int Q62Q(obj Q62O, int Q4DW, int Q478);

forward void Q62X(int Q5J7);

forward int Q62S();

function int Q5S1(obj house, obj Q5HY) {
	if (!hasObjVar(house, "myhousedoors")) {
		return(0x00);
	}
	list doors;
	getObjListVar(doors, house, "myhousedoors");
	if (numInList(doors) < 0x01) {
		return(0x00);
	}
	obj Q5AB = doors[0x00];
	obj Q5NC = mobileHasObjWithListObjOfObj(Q5HY, "whatIUnlock", Q5AB);
	if (Q5NC == NULL()) {
		return(0x00);
	}
	return(0x01);
}

function int Q62U(obj ship) {
	int Q5NC = getObjVar(ship, "shiprightplank");
	if (Q5NC == 0x01) {
		return(0x01);
	}
	Q5NC = getObjVar(ship, "shipleftplank");
	if (Q5NC == 0x01) {
		return(0x01);
	}
	return(0x00);
}

function void Q62W(obj Q62O) {
	if (hasObjVar(Q62O, "shipqueuedcommand")) {
		removeObjVar(Q62O, "shipqueuedcommand");
	}
	return;
}

function int Q62P(int Q5B7, int Q5SG) {
	int Q5NC = Q5B7 - Q5SG;
	if (Q5NC > 0x04) {
		Q5NC = Q5NC + (0x00 - 0x08);
	} else {
		if (Q5NC < (0x00 - 0x04)) {
			Q5NC = Q5NC + 0x08;
		}
	}
	return(Q5NC);
}

function void Q62T(obj ship) {
	int Q58G = getMultiType(ship);
	loc Q4OI;
	loc Q4OJ;
	int Q5NC = getMultiExtents(Q58G, Q4OI, Q4OJ);
	Q5ST = getX(Q4OJ) - getX(Q4OI) + 0x01;
	Q5SI = getY(Q4OJ) - getY(Q4OI) + 0x01;
	Q5SC = Q5ST;
	if (Q5SI > Q5SC) {
		Q5SC = Q5SI;
	}
	return;
}

trigger creation {
	Q464 = 0x01;
	Q4V5 = 0x00;
	obj ship = getMultiSlaveId(this);
	if (ship == NULL()) {
		bark(this, "Ar, I have no ship!");
		return(0x01);
	}
	setObjVar(ship, "myshiptillerman", this);
	Q62X((0x00 - 0x01));
	Q55D = NULL();
	Q62T(ship);
	return(0x01);
}

function int Q630(obj Q62O) {
	if (hasObjVar(Q62O, "shipcommand")) {
		int Q5FV = getObjVar(Q62O, "shipcommand");
		removeObjVar(Q62O, "shipcommand");
		return(Q5FV);
	}
	return((0x00 - 0x01));
}

function void Q62V(obj Q62O) {
	if (hasObjVar(Q62O, "shipcommand")) {
		setObjVar(Q62O, "oldshipcommand", getobjvar_int(Q62O, "shipcommand"));
	}
	return;
}

function void Q62Y(obj Q62O, int Q4DW) {
	if ((Q4DW >= 0x08) && (Q4DW <= 0x0A)) {
		if (hasObjVar(Q62O, "shipcommand")) {
			int Q5G5 = getObjVar(Q62O, "shipcommand");
			if (((Q5G5 <= 0x07) || (Q5G5 >= 0x0B)) && (Q5G5 != 0x1B) && (Q5G5 != 0x1C)) {
				setObjVar(Q62O, "shipqueuedcommand", Q5G5);
			}
		}
	}
	int Q5FV = Q630(Q62O);
	setObjVar(Q62O, "shipcommand", Q4DW);
	if (Q4V5 == 0x00) {
		Q4V5 = 0x01;
		shortCallback(this, 0x02, 0x31);
	}
	return;
}

trigger serverswitch {
	if (containedBy(this) != NULL()) {
		return(0x01);
	}
	if (hasObjVar(this, "oldshipcommand")) {
		int Q4DW = getobjvar_int(this, "oldshipcommand");
		removeObjVar(this, "oldshipcommand");
		Q62Y(this, Q4DW);
	}
	return(0x01);
}

function int Q62Z(obj ship, int Q4ID) {
	int Q5SG = getObjVar(ship, "myshipdir");
	int Q4AG = 0x00;
	Q5SG = Q5SG + 0x04;
	if (Q4ID == 0x01) {
		Q5SG = Q5SG + 0x01;
		Q4AG = 0x02;
	}
	if (Q4ID == 0x02) {
		Q5SG = Q5SG - 0x01;
		Q4AG = 0x06;
	}
	if (Q4ID == 0x03) {
		Q5SG = Q5SG - 0x02;
		Q4AG = 0x04;
	}
	if (Q5SG > 0x03) {
		Q5SG = Q5SG - 0x04;
	}
	if (Q5SG > 0x03) {
		Q5SG = Q5SG - 0x04;
	}
	int Q5NC = Q5SQ(ship, Q5SG, Q4AG);
	Q62T(ship);
	return(Q5NC);
}

function int Q62R(obj Q62O, int Q5WD) {
	string Q5N7;
	string Q63B;
	obj ship = getMultiSlaveId(Q62O);
	if (ship == NULL()) {
		bark(Q62O, "Blimey, I have no ship!");
		return(0x00);
	}
	if ((!isValid(Q55D)) || (!isMap(Q55D))) {
		bark(Q62O, "I have seen no map, sir.");
		Q55D = NULL();
		return(0x00);
	}
	if (getDistanceInTiles(getLocation(Q55D), getLocation(Q62O)) > 0x0F) {
		bark(Q62O, "The map is too far away from me, sir.");
		Q55D = NULL();
		return(0x00);
	}
	loc Q5B8;
	if (!getMapPoint(Q5B8, Q55D, Q5BA)) {
		Q5N7 = "Nav point ";
		Q63B = Q5BA + 0x01;
		concat(Q5N7, Q63B);
		concat(Q5N7, " is invalid, sir.");
		bark(Q62O, Q5N7);
		Q5BA = (0x00 - 0x01);
		return(0x00);
	}
	loc Q5SL = getLocation(ship);
	if (getDistanceInTiles(Q5SL, Q5B8) <= Q5SC) {
		if (Q5WD) {
			Q5N7 = "We have arrived at nav ";
			Q63B = Q5BA + 0x01;
			concat(Q5N7, Q63B);
			concat(Q5N7, ", sir.");
			bark(Q62O, Q5N7);
			Q5BA++;
			int Q5FV = Q630(Q62O);
			return(0x00);
		}
		Q5BA++;
		if (!getMapPoint(Q5B8, Q55D, Q5BA)) {
			Q5BA = (0x00 - 0x01);
			bark(Q62O, "The course is completed, sir.");
			Q5FV = Q630(Q62O);
			return(0x00);
		}
		Q5N7 = "Heading to nav point ";
		Q63B = Q5BA + 0x01;
		concat(Q5N7, Q63B);
		concat(Q5N7, ", sir.");
		bark(Q62O, Q5N7);
	}
	int Q5B7 = getDirectionInternal(Q5SL, Q5B8);
	int Q5SG = getObjVar(ship, "myshipdir");
	Q5SG = Q5SG * 0x02;
	int Q4IA = Q62P(Q5B7, Q5SG);
	int Q4DW = 0x00;
	if ((Q4IA > 0x01) || (Q4IA < (0x00 - 0x01))) {
		if (Q4IA < 0x00) {
			Q4DW = 0x09;
		} else {
			Q4DW = 0x08;
		}
	} else {
		if (Q4IA == 0x01) {
			Q4DW = 0x01;
		} else {
			if (Q4IA == (0x00 - 0x01)) {
				Q4DW = 0x07;
			} else {
				Q4DW = 0x00;
			}
		}
	}
	return(Q62Q(Q62O, Q4DW, 0x01));
}

function int Q62Q(obj Q62O, int Q4DW, int Q478) {
	int Q5NC;
	obj ship = getMultiSlaveId(this);
	if (ship == NULL()) {
		int Q5FV = Q630(Q62O);
		bark(this, "Ar, I have no ship!");
		return(0x00);
	}
	if (Q464 == 0x01) {
		bark(this, "Ar, the anchor is down sir!");
		return(0x00);
	}
	if ((Q4DW >= 0x08) && (Q4DW <= 0x0A)) {
		int Q4ID = Q4DW - 0x07;
		Q5NC = Q62Z(ship, Q4ID);
		if (Q5NC > 0x00) {
			if (!Q478) {
				bark(Q62O, "Yes, sir.");
			}
		} else {
			if (Q5NC < 0x00) {
				bark(Q62O, "Arr, the water is too turbulent to turn sir!");
			} else {
				bark(Q62O, "Ar, can't turn sir.");
			}
			Q5FV = Q630(Q62O);
			return(0x00);
		}
		if (!Q478) {
			Q5FV = Q630(Q62O);
			return(0x00);
		}
		return(0x01);
	}
	if (((Q4DW >= 0x00) && (Q4DW <= 0x07)) || ((Q4DW >= 0x0B) && (Q4DW <= 0x1A)) || ((Q4DW >= 0x1D) && (Q4DW <= 0x24))) {
		int Q58B = 0x01;
		int Q5CK = 0x00;
		if ((Q4DW >= 0x00) && (Q4DW <= 0x07)) {
			Q5CK = Q4DW;
			if ((Q4DW == 0x00) || (Q4DW == 0x01) || (Q4DW == 0x07)) {
				Q58B = 0x03;
			}
		}
		if ((Q4DW >= 0x0B) && (Q4DW <= 0x12)) {
			Q5CK = Q4DW - 0x0B;
		}
		if ((Q4DW >= 0x13) && (Q4DW <= 0x1A)) {
			Q5CK = Q4DW - 0x13;
			if ((Q5CK == 0x00) || (Q5CK == 0x01) || (Q5CK == 0x07)) {
				Q58B = 0x03;
			}
		}
		if ((Q4DW >= 0x1D) && (Q4DW <= 0x24)) {
			Q5CK = Q4DW - 0x1D;
		}
		Q5NC = Q5SP(ship, Q5CK, Q58B);
		if (Q5NC == 0x00) {
			bark(Q62O, "Ar, we've stopped sir.")Q5FV = Q630(Q62O);
			Q62W(Q62O);
			return(0x00);
		} else {
			if (Q5NC < 0x00) {
				bark(Q62O, "Ar, turbulent water!")Q62V(Q62O);
				Q5NC = Q5S4(ship, Q5CK, Q62O);
				if (!Q478) {
					if (!Q65T) {
						Q5FV = Q630(Q62O);
					} else {
						Q65T = 0x00;
					}
				}
				return(0x00);
			} else {
				if (((Q4DW >= 0x13) && (Q4DW <= 0x1A)) || ((Q4DW >= 0x1D) && (Q4DW <= 0x24))) {
					if (!Q478) {
						Q5FV = Q630(Q62O);
					}
				}
			}
		}
		return(0x01);
	}
	if (Q4DW == 0x1B) {
		return(Q62R(Q62O, 0x00));
	}
	if (Q4DW == 0x1C) {
		return(Q62R(Q62O, 0x01));
	}
	if (Q4DW >= 0x25) {
		bark(this, "Ar, I don't know how to do that, sir.");
		Q5FV = Q630(Q62O);
		return(0x00);
	}
	return(0x00);
}

trigger callback(0x31) {
	Q4V5 = 0x00;
	if (containedBy(this) != NULL()) {
		return(0x01);
	}
	if (hasObjVar(this, "shipcommand")) {
		int Q4DW = getObjVar(this, "shipcommand");
		if (Q62Q(this, Q4DW, 0x00)) {
			shortCallback(this, 0x02, 0x31);
			Q4V5 = 0x01;
			return(0x01);
		}
		if (hasObjVar(this, "shipqueuedcommand")) {
			int Q5CK = getObjVar(this, "shipqueuedcommand");
			removeObjVar(this, "shipqueuedcommand");
			Q62Y(this, Q5CK);
		}
	}
	return(0x01);
}

trigger speech("*") {
	if (containedBy(this) != NULL()) {
		return(0x01);
	}
	obj Q5AK = getMultiSlaveId(this);
	if (isDead(speaker) && (!isManifesting(speaker))) {
		return(0x01);
	}
	if (!isOnMulti(speaker, Q5AK)) {
		return(0x01);
	}
	if ((!Q5S1(Q5AK, speaker)) && (!isEditing(speaker))) {
		obj Q4DK = getClosestVisibleOnlinePlayer(getLocation(this), 0x0F);
		if ((Q4DK == NULL()) || ((Q4DK != speaker))) {
			return(0x01);
		}
		list Q5J1;
		getPlayersOnMulti(Q5J1, Q5AK);
		int Q5EW = numInList(Q5J1);
		int Q5J3;
		for (Q5J3 = 0x00; Q5J3 < Q5EW; Q5J3++) {
			obj Q5J2 = Q5J1[Q5J3];
			if (Q5S1(Q5AK, Q5J2)) {
				return(0x01);
			}
		}
	}
	list args;
	split(args, arg);
	string Q5N7;
	string Q44J;
	string Q44K;
	string Q44L;
	int num = numInList(args);
	if (num > 0x02) {
		Q44J = args[0x00];
		Q44K = args[0x01];
		if ((Q44J == "set") && (Q44K == "name")) {
			string Q5B6;
			string Q4G2;
			for (int Q4EJ = 0x02; Q4EJ < num; Q4EJ++) {
				if (Q4EJ != 0x02) {
					concat(Q5B6, " ");
				}
				Q4G2 = args[Q4EJ];
				concat(Q5B6, Q4G2);
			}
			Q5N7 = "This ship is now called the ";
			concat(Q5N7, Q5B6);
			concat(Q5N7, ".");
			Q58V(Q5AK, Q5B6);
			barkTo(this, speaker, Q5N7);
			return(0x01);
		}
	}
	if (num == 0x01) {
		Q44J = args[0x00];
		if (Q44J == "name") {
			if (Q58R(Q5AK)) {
				Q5N7 = "This is the ";
				concat(Q5N7, Q58N(Q5AK));
				concat(Q5N7, ".");
				bark(this, Q5N7);
			} else {
				bark(this, "Ar, this ship has no name.");
			}
			return(0x01);
		}
		if (Q44J == "forward") {
			Q62Y(this, 0x00);
			bark(this, "Aye aye sir.");
			return(0x01);
		}
		if ((Q44J == "backwards") || (Q44J == "backward") || (Q44J == "back")) {
			Q62Y(this, 0x04);
			bark(this, "Aye aye sir.");
			return(0x01);
		}
		if (Q44J == "left") {
			Q62Y(this, 0x06);
			bark(this, "Aye aye sir.");
			return(0x01);
		}
		if (Q44J == "right") {
			Q62Y(this, 0x02);
			bark(this, "Aye aye sir.");
			return(0x01);
		}
		if (Q44J == "stop") {
			int Q5FV = Q630(this);
			bark(this, "Yes, sir.");
			return(0x01);
		}
		if (Q44J == "starboard") {
			Q62Y(this, 0x08);
			return(0x01);
		}
		if (Q44J == "port") {
			Q62Y(this, 0x09);
			return(0x01);
		}
		if (Q44J == "nav") {
			int Q5B9 = Q62S();
			string Q5AI;
			if (Q5B9 < 0x00) {
				concat(Q5AI, "I have no current nav point.");
			} else {
				concat(Q5AI, "My current destination navpoint is nav ");
				Q5AI = Q5AI + (Q5B9 + 0x01);
				concat(Q5AI, ".");
			}
			bark(this, Q5AI);
			return(0x01);
		}
		if (Q44J == "start") {
			Q62X(0x00);
			Q62Y(this, 0x1B);
			bark(this, "Aye aye sir.");
			return(0x01);
		}
		if (Q44J == "continue") {
			Q62Y(this, 0x1B);
			bark(this, "Aye aye sir.");
			return(0x01);
		}
		return(0x01);
	}
	if (num == 0x02) {
		Q44J = args[0x00];
		Q44K = args[0x01];
		if ((Q44J == "remove") && (Q44K == "name")) {
			if (Q58R(Q5AK)) {
				Q58U(Q5AK);
				bark(this, "This ship now has no name.");
			} else {
				bark(this, "This ship has no name.");
			}
			return(0x01);
		}
		if ((Q44J == "unfurl") && (Q44K == "sail")) {
			Q62Y(this, 0x00);
			bark(this, "Aye aye sir.");
			return(0x01);
		}
		if ((Q44J == "furl") && (Q44K == "sail")) {
			Q5FV = Q630(this);
			if (Q5FV >= 0x00) {
				bark(this, "Yes sir.");
			} else {
				bark(this, "Er, the ship is not moving sir.");
			}
			return(0x01);
		}
		if (((Q44J == "drop") && (Q44K == "anchor")) || ((Q44J == "lower") && (Q44K == "anchor"))) {
			if (Q464 != 0x01) {
				Q464 = 0x01;
				bark(this, "Ar, anchor dropped sir.");
				Q5FV = Q630(this);
			} else {
				bark(this, "Ar, the anchor was already dropped sir.");
			}
			return(0x01);
		}
		if (((Q44J == "raise") && (Q44K == "anchor")) || ((Q44J == "lift") && (Q44K == "anchor")) || ((Q44J == "hoist") && (Q44K == "anchor"))) {
			if (Q464 != 0x00) {
				Q464 = 0x00;
				bark(this, "Ar, anchor raised sir.");
			} else {
				bark(this, "Ar, the anchor has not been dropped sir.");
			}
			return(0x01);
		}
		if ((Q44J == "forward") && (Q44K == "left")) {
			Q62Y(this, 0x07);
			bark(this, "Aye aye sir.");
			return(0x01);
		}
		if ((Q44J == "forward") && (Q44K == "right")) {
			Q62Y(this, 0x01);
			bark(this, "Aye aye sir.");
			return(0x01);
		}
		if (((Q44J == "backward") && (Q44K == "left")) || ((Q44J == "backwards") && (Q44K == "left")) || ((Q44J == "back") && (Q44K == "left"))) {
			Q62Y(this, 0x05);
			bark(this, "Aye aye sir.");
			return(0x01);
		}
		if (((Q44J == "backward") && (Q44K == "right")) || ((Q44J == "backwards") && (Q44K == "right")) || ((Q44J == "back") && (Q44K == "right"))) {
			Q62Y(this, 0x03);
			bark(this, "Aye aye sir.");
			return(0x01);
		}
		if ((Q44J == "turn") && (Q44K == "right")) {
			Q62Y(this, 0x08);
			return(0x01);
		}
		if ((Q44J == "turn") && (Q44K == "left")) {
			Q62Y(this, 0x09);
			return(0x01);
		}
		if ((Q44J == "turn") && (Q44K == "around")) {
			Q62Y(this, 0x0A);
			return(0x01);
		}
		if ((Q44J == "come") && (Q44K == "about")) {
			Q62Y(this, 0x0A);
			return(0x01);
		}
		if ((Q44J == "drift") && (Q44K == "left")) {
			Q62Y(this, 0x06);
			bark(this, "Aye aye sir.");
			return(0x01);
		}
		if ((Q44J == "drift") && (Q44K == "right")) {
			Q62Y(this, 0x02);
			bark(this, "Aye aye sir.");
			return(0x01);
		}
		if (Q44J == "slow") {
			if (Q44K == "left") {
				Q62Y(this, 0x11);
				bark(this, "Aye aye sir.");
				return(0x01);
			}
			if (Q44K == "right") {
				Q62Y(this, 0x0D);
				bark(this, "Aye aye sir.");
				return(0x01);
			}
			if (Q44K == "forward") {
				Q62Y(this, 0x0B);
				bark(this, "Aye aye sir.");
				return(0x01);
			}
			if ((Q44K == "back") || (Q44K == "backward") || (Q44K == "backwards")) {
				Q62Y(this, 0x0F);
				bark(this, "Aye aye sir.");
				return(0x01);
			}
		}
		if (Q44J == "one") {
			if (Q44K == "left") {
				Q62Y(this, 0x23);
				bark(this, "Aye aye sir.");
				return(0x01);
			}
			if (Q44K == "right") {
				Q62Y(this, 0x1F);
				bark(this, "Aye aye sir.");
				return(0x01);
			}
			if (Q44K == "forward") {
				Q62Y(this, 0x1D);
				bark(this, "Aye aye sir.");
				return(0x01);
			}
			if ((Q44K == "back") || (Q44K == "backward") || (Q44K == "backwards")) {
				Q62Y(this, 0x21);
				bark(this, "Aye aye sir.");
				return(0x01);
			}
		}
		if (Q44K == "one") {
			if (Q44J == "left") {
				Q62Y(this, 0x23);
				bark(this, "Aye aye sir.");
				return(0x01);
			}
			if (Q44J == "right") {
				Q62Y(this, 0x1F);
				bark(this, "Aye aye sir.");
				return(0x01);
			}
			if (Q44J == "forward") {
				Q62Y(this, 0x1D);
				bark(this, "Aye aye sir.");
				return(0x01);
			}
			if ((Q44J == "back") || (Q44J == "backward") || (Q44J == "backwards")) {
				Q62Y(this, 0x21);
				bark(this, "Aye aye sir.");
				return(0x01);
			}
		}
		if (Q44J == "goto") {
			Q62X(strtoi(Q44K) - 0x01);
			Q62Y(this, 0x1B);
			bark(this, "Aye aye sir.");
			return(0x01);
		}
		if (Q44J == "single") {
			Q62X(strtoi(Q44K) - 0x01);
			Q62Y(this, 0x1C);
			bark(this, "Aye aye sir.");
			return(0x01);
		}
		return(0x01);
	}
	if (num == 0x03) {
		Q44J = args[0x00];
		Q44K = args[0x01];
		Q44L = args[0x02];
		if (Q44J == "slow") {
			if (Q44K == "forward") {
				if (Q44L == "left") {
					Q62Y(this, 0x12);
					bark(this, "Aye aye sir.");
					return(0x01);
				}
				if (Q44L == "right") {
					Q62Y(this, 0x0C);
					bark(this, "Aye aye sir.");
					return(0x01);
				}
			}
			if ((Q44K == "back") || (Q44K == "backward") || (Q44K == "backwards")) {
				if (Q44L == "left") {
					Q62Y(this, 0x10);
					bark(this, "Aye aye sir.");
					return(0x01);
				}
				if (Q44L == "right") {
					Q62Y(this, 0x0E);
					bark(this, "Aye aye sir.");
					return(0x01);
				}
			}
		}
		if (Q44J == "one") {
			if (Q44K == "forward") {
				if (Q44L == "left") {
					Q62Y(this, 0x24);
					bark(this, "Aye aye sir.");
					return(0x01);
				}
				if (Q44L == "right") {
					Q62Y(this, 0x1E);
					bark(this, "Aye aye sir.");
					return(0x01);
				}
			}
			if ((Q44K == "back") || (Q44K == "backward") || (Q44K == "backwards")) {
				if (Q44L == "left") {
					Q62Y(this, 0x22);
					bark(this, "Aye aye sir.");
					return(0x01);
				}
				if (Q44L == "right") {
					Q62Y(this, 0x20);
					bark(this, "Aye aye sir.");
					return(0x01);
				}
			}
		}
		if (Q44L == "one") {
			if (Q44J == "forward") {
				if (Q44K == "left") {
					Q62Y(this, 0x24);
					bark(this, "Aye aye sir.");
					return(0x01);
				}
				if (Q44K == "right") {
					Q62Y(this, 0x1E);
					bark(this, "Aye aye sir.");
					return(0x01);
				}
			}
			if ((Q44J == "back") || (Q44J == "backward") || (Q44J == "backwards")) {
				if (Q44K == "left") {
					Q62Y(this, 0x22);
					bark(this, "Aye aye sir.");
					return(0x01);
				}
				if (Q44K == "right") {
					Q62Y(this, 0x20);
					bark(this, "Aye aye sir.");
					return(0x01);
				}
			}
		}
	}
	return(0x01);
}

trigger give {
	int Q5NC;
	if (isMap(givenobj)) {
		if (!isValidMap(givenobj)) {
			bark(this, "Ar, that is not a map, tis but a blank piece of paper!");
		} else {
			loc Q5AH;
			if (!getMapPoint(Q5AH, givenobj, 0x00)) {
				bark(this, "Arrrr, this map has no course on it!");
			} else {
				bark(this, "A map!");
				Q55D = givenobj;
			}
		}
	} else {
		bark(this, "Rrrrr, I don't want that!  Show me a map!");
	}
	return(0x00);
}

function void Q62X(int Q5J7) {
	Q5BA = Q5J7;
	return;
}

function int Q62S() {
	return(Q5BA);
}

trigger objectloaded {
	if (containedBy(this) == NULL()) {
		int Q5FV = Q630(this);
	}
	return(0x01);
}

trigger lookedat {
	obj Q5AK = getMultiSlaveId(this);
	if (Q58R(Q5AK)) {
		string Q5CQ = "the tillerman of the ";
		concat(Q5CQ, Q58N(Q5AK));
		barkTo(this, looker, Q5CQ);
		Q58J(this, looker, "ship");
		return(0x00);
	}
	Q58J(this, looker, "ship");
	return(0x01);
}

trigger use {
	obj Q5AK = getMultiSlaveId(this);
	if (Q4X6(Q5AK, user)) {
		systemMessage(user, "What dost thou wish to name thy ship?");
		textEntry(this, user, 0x18, 0x00, "");
	} else {
		string Q4R5;
		int num = random(0x00, 0x0F);
		switch(num) {
		case 0x00
		case 0x01
		case 0x02
			Q4R5 = "Arr, don't do that!";
			break;
		case 0x03
		case 0x04
		case 0x05
			Q4R5 = "Arr, leave me alone!";
			break;
		case 0x06
		case 0x07
		case 0x08
			Q4R5 = "Arr, watch what thou'rt doing, matey!";
			break;
		case 0x09
		case 0x0A
			Q4R5 = "Arr!  Do that again and I'll throw ye overboard!";
			break;
		case 0x0B
		case 0x0C
		case 0x0D
		case 0x0E
		case 0x0F
			default
			Q4R5 = "Arr!  Only the owner of the ship may change its name!";
			break;
		}
		bark(this, Q4R5);
	}
	return(0x00);
}

trigger textentry(0x18) {
	if (button == 0x00) {
		return(0x00);
	}
	obj Q5AK = getMultiSlaveId(this);
	if (Q4X6(Q5AK, sender)) {
		if (text == "") {
			if (Q58R(Q5AK)) {
				Q58U(Q5AK);
				barkTo(this, sender, "This ship now has no name.");
			}
		} else {
			string Q5N7 = "This ship is now called the ";
			concat(Q5N7, text);
			concat(Q5N7, ".");
			barkTo(this, sender, Q5N7);
			Q58V(Q5AK, text);
		}
	}
	return(0x00);
}
