trigger use {
	list Q4QI;
	clearList(Q4QI);
	getMobsInRange(Q4QI, getLocation(this), 0x14);
	for (int i = (numInList(Q4QI) - 0x01); i >= 0x00; i--) {
		obj Q4FK = Q4QI[i];
		if (!isPlayer(Q4FK)) {
			loc Q4FH = getLocation(Q4FK);
			int Q4FU = getZ(Q4FH);
			loc Q5Z6 = Q4FH;
			setZ(Q5Z6, Q4FU + 0x10);
			int Q5NC = teleport(Q4QI[i], Q5Z6);
			int Q4QU = findGoodZ(Q4FH, Q4FU, Q4FU, 0x10, 0x02);
			Q5NC = teleport(Q4QI[i], Q4FH);
			if ((Q4QU == (0x00 - 0x80)) || (Q4QU > Q4FU)) {
				systemMessage(user, "FoundZ=" + Q4QU + " Currently at:" + Q4FU);
				systemMessage(user, "'" + getName(Q4FK) + "' was not in a valid position");
				Q5NC = teleport(user, Q4FH);
				return(0x00);
			}
		}
	}
	systemMessage(user, "All mobiles were in valid positions (for flying creatures)");
	return(0x01);
}
