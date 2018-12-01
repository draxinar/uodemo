inherits sndfx;

function void Q5XR(obj Q5G0, int newType) {
	int Q5G2 = getObjType(Q5G0);
	string Q5WW = Q5G2;
	string Q5WV = newType;
	if (Q5G2 != newType) {
		setType(Q5G0, newType);
		attachScript(Q5G0, Q5WV);
		detachScript(Q5G0, Q5WW);
	}
	return();
}

function void Q4XA(obj looker, string Q5N4) {
	int Q5N2;
	if (getResource(Q5N2, this, Q5N4, 0x03, 0x02)) {
		if (Q5N2 > 0x00) {
			string Q5WY = Q5N2;
			barkTo(this, looker, "contains " + Q5WY + " " + Q5N4);
		}
	} else {
	}
	return();
}

function void Q4DV(list Q5NJ, obj Q5UB, obj Q4HS, string Q5N4) {
	int Q4YD;
	int Q4YB;
	int Q55Y;
	int Q4P9;
	int Q4P8;
	int Q4Q1;
	Q4Q1 = getResource(Q4YD, Q5UB, Q5N4, 0x03, 0x02);
	Q4Q1 = getResource(Q4YB, Q4HS, Q5N4, 0x03, 0x02);
	Q4Q1 = getResource(Q55Y, Q4HS, Q5N4, 0x03, 0x00);
	if (Q4YB + Q4YD > Q55Y) {
		transferResources(Q4HS, Q5UB, Q55Y - Q4YB, Q5N4);
		Q4P8 = Q55Y;
		Q4P9 = Q4YD - (Q55Y - Q4YB);
	} else {
		transferResources(Q4HS, Q5UB, Q4YD, Q5N4);
		Q4P8 = Q4YB + Q4YD;
		Q4P9 = 0x00;
	}
	appendToList(Q5NJ, Q4P9);
	appendToList(Q5NJ, Q4P8);
	return();
}

function void Q5J8(int north, int east, int south, int west) {
	loc Q5C0 = getLocation(this);
	loc Q5FZ;
	if (hasObjVar(this, "LOCATION")) {
		Q5FZ = getObjVar(this, "LOCATION");
	} else {
		Q5FZ = Q5C0;
	}
	int Q5G3 = getX(Q5FZ);
	int Q5G4 = getY(Q5FZ);
	int Q5CE = getX(Q5C0);
	int Q5CF = getY(Q5C0);
	int Q4HC = Q5G3 - Q5CE;
	int Q4HD = Q5G4 - Q5CF;
	int Q44V;
	int Q44W;
	int Q5BG = 0x00 - 0x01;
	if (Q4HC < 0x00) {
		Q44V = Q4HC * Q5BG;
	} else {
		Q44V = Q4HC;
	}
	if (Q4HD < 0x00) {
		Q44W = Q4HD * Q5BG;
	} else {
		Q44W = Q4HD;
	}
	if (Q44V == Q44W) {
		if ((Q44V == 0x00) && (Q44W == 0x00)) {
			return();
		}
		int Q5L6 = random(0x00, 0x01);
		if (Q5L6) {
			if (Q4HC > 0x00) {
				Q5XR(this, west);
			} else {
				Q5XR(this, east);
			}
		} else {
			if (Q4HD > 0x00) {
				Q5XR(this, north);
			} else {
				Q5XR(this, south);
			}
		}
	} else {
		if (Q44V > Q44W) {
			if (Q4HC > 0x00) {
				Q5XR(this, west);
			} else {
				Q5XR(this, east);
			}
		} else {
			if (Q4HD > 0x00) {
				Q5XR(this, north);
			} else {
				Q5XR(this, south);
			}
		}
	}
	loc location = getLocation(this);
	setObjVar(this, "LOCATION", location);
	return();
}

function int Q50A(int Q5HC) {
	switch(Q5HC) {
	case 0x0C95
	case 0x0C96
	case 0x0C9E
	case 0x0CCA
	case 0x0CCB
	case 0x0CCC
	case 0x0CCD
	case 0x0CCE
	case 0x0CCF
	case 0x0CD0
	case 0x0CD1
	case 0x0CD2
	case 0x0CD3
	case 0x0CD4
	case 0x0CD5
	case 0x0CD6
	case 0x0CD7
	case 0x0CD8
	case 0x0CD9
	case 0x0CDA
	case 0x0CDB
	case 0x0CDC
	case 0x0CDD
	case 0x0CDE
	case 0x0CDF
	case 0x0CE0
	case 0x0CE1
	case 0x0CE2
	case 0x0CE3
	case 0x0CE4
	case 0x0CE5
	case 0x0CE6
	case 0x0CE8
	case 0x0CF8
	case 0x0CF9
	case 0x0CFA
	case 0x0CFB
	case 0x0CFC
	case 0x0CFD
	case 0x0CFE
	case 0x0CFF
	case 0x0D00
	case 0x0D01
	case 0x0D02
	case 0x0D03
	case 0x0D41
	case 0x0D42
	case 0x0D43
	case 0x0D44
	case 0x0D45
	case 0x0D46
	case 0x0D47
	case 0x0D48
	case 0x0D49
	case 0x0D4A
	case 0x0D4B
	case 0x0D4C
	case 0x0D4D
	case 0x0D4E
	case 0x0D4F
	case 0x0D50
	case 0x0D51
	case 0x0D52
	case 0x0D53
	case 0x0D6E
	case 0x0D6F
	case 0x0D70
	case 0x0D71
	case 0x0D72
	case 0x0D73
	case 0x0D74
	case 0x0D75
	case 0x0D76
	case 0x0D77
	case 0x0D78
	case 0x0D79
	case 0x0D7A
	case 0x0D7B
	case 0x0D7C
	case 0x0D7D
	case 0x0D7E
	case 0x0D7F
	case 0x0D84
	case 0x0D85
	case 0x0D86
	case 0x0D87
	case 0x0D88
	case 0x0D89
	case 0x0D8A
	case 0x0D8B
	case 0x0D8C
	case 0x0D8D
	case 0x0D8E
	case 0x0D8F
	case 0x0D90
	case 0x0D94
	case 0x0D95
	case 0x0D96
	case 0x0D97
	case 0x0D98
	case 0x0D99
	case 0x0D9A
	case 0x0D9A
	case 0x0D9C
	case 0x0D9D
	case 0x0D9E
	case 0x0D9F
	case 0x0DA0
	case 0x0DA1
	case 0x0DA2
	case 0x0DA3
	case 0x0DA4
	case 0x0DA5
	case 0x0DA6
	case 0x0DA7
	case 0x0DA8
	case 0x0DA9
	case 0x0DAA
	case 0x0DAB
	case 0x12B6
	case 0x12B7
	case 0x12B8
	case 0x12B9
	case 0x12BA
	case 0x12BB
	case 0x12BC
	case 0x12BD
	case 0x12BE
	case 0x1323
	case 0x12C0
	case 0x12C1
	case 0x12C2
	case 0x12C3
	case 0x12C4
	case 0x12C5
	case 0x12C6
	case 0x12C7
		return(0x01);
		break;
	default
		return(0x00);
		break;
	}
	return(0x00);
}

function int Q4ZI(int Q5HC) {
	switch(Q5HC) {
	case 0x025C
	case 0x025D
	case 0x025E
	case 0x025F
	case 0x0260
	case 0x0261
	case 0x0262
	case 0x0263
	case 0x0264
	case 0x0265
	case 0x0266
	case 0x0267
	case 0x0268
	case 0x0269
	case 0x026A
	case 0x026B
	case 0x026C
	case 0x026D
	case 0x026E
	case 0x026F
	case 0x0270
	case 0x0271
	case 0x0272
	case 0x0273
	case 0x0274
	case 0x0275
	case 0x0276
	case 0x027D
	case 0x027E
	case 0x027F
	case 0x0280
	case 0x053B
	case 0x053C
	case 0x053D
	case 0x053E
	case 0x053F
	case 0x0540
	case 0x0541
	case 0x0542
	case 0x0543
	case 0x0544
	case 0x0545
	case 0x0546
	case 0x0547
	case 0x0548
	case 0x0549
	case 0x054A
	case 0x054B
	case 0x054C
	case 0x054D
	case 0x054E
	case 0x054F
	case 0x0551
	case 0x0552
	case 0x0553
	case 0x056A
	case 0x16E4
	case 0x16E5
	case 0x16E6
	case 0x16E7
	case 0x16E8
	case 0x16E9
	case 0x16EA
	case 0x16EB
	case 0x16EC
	case 0x16ED
	case 0x16EE
	case 0x16EF
	case 0x16F0
	case 0x16F1
	case 0x16F2
	case 0x16F3
		return(0x01);
		break;
	default
		return(0x00);
		break;
	}
	return(0x00);
}

function int Q4ZJ(int Q5HC) {
	if ((Q5HC >= 0xDC) && (Q5HC <= 0xE7)) {
		return(0x01);
	}
	if ((Q5HC >= 0xEC) && (Q5HC <= 0xF7)) {
		return(0x01);
	}
	if ((Q5HC >= 0xFC) && (Q5HC <= 0x0107)) {
		return(0x01);
	}
	if ((Q5HC >= 0x010C) && (Q5HC <= 0x0117)) {
		return(0x01);
	}
	if ((Q5HC >= 0x011E) && (Q5HC <= 0x0129)) {
		return(0x01);
	}
	if ((Q5HC >= 0x0141) && (Q5HC <= 0x0144)) {
		return(0x01);
	}
	if ((Q5HC >= 0x01D3) && (Q5HC <= 0x01DA)) {
		return(0x01);
	}
	if ((Q5HC >= 0x021F) && (Q5HC <= 0x0243)) {
		return(0x01);
	}
	if ((Q5HC >= 0x06CD) && (Q5HC <= 0x06DD)) {
		return(0x01);
	}
	if ((Q5HC >= 0x06EB) && (Q5HC <= 0x06FE)) {
		return(0x01);
	}
	if ((Q5HC >= 0x0709) && (Q5HC <= 0x0720)) {
		return(0x01);
	}
	if ((Q5HC >= 0x0727) && (Q5HC <= 0x073E)) {
		return(0x01);
	}
	if ((Q5HC >= 0x0745) && (Q5HC <= 0x075C)) {
		return(0x01);
	}
	if ((Q5HC >= 0x07BD) && (Q5HC <= 0x07D4)) {
		return(0x01);
	}
	if ((Q5HC >= 0x0245) && (Q5HC <= 0x026D)) {
		return(0x01);
	}
	return(0x00);
}

function int Q46J(obj user, obj Q66L) {
	if (hasObjVar(Q66L, "lifeRemaining")) {
		int lifeRemaining = getObjVar(Q66L, "lifeRemaining");
		if (lifeRemaining > 0x01) {
			setObjVar(Q66L, "lifeRemaining", (lifeRemaining - 0x01));
		} else {
			string name = getNameByType(getObjType(this));
			systemMessage(user, "You destroyed the " + name + ".");
			return(0x01);
		}
	} else {
		setObjVar(Q66L, "lifeRemaining", 0x32);
	}
	return(0x00);
}
