inherits globals;

member list Q4GP;

function void Q5M4() {
	list args;
	multiMessageToLoc(getMasterObjLoc(0x00), "registerBoard", args);
	return();
}

trigger callback(0x2F) {
	Q5M4();
	return(0x01);
}

trigger objectloaded {
	callback(this, 0x01, 0x2F);
	list Q4E4;
	getContents(Q4E4, this);
	for (int i = numInList(Q4E4); i; i--) {
		deleteObject(Q4E4[0x00]);
		removeItem(Q4E4, 0x00);
	}
	return(0x00);
}

trigger creation {
	Q5M4();
	return(0x01);
}

trigger lookedat {
	list Q4E4;
	getContents(Q4E4, this);
	int count = 0x00;
	for (int i = numInList(Q4E4); i; i--) {
		if (hasObjVar(Q4E4[0x00], "killer")) {
			count++;
		}
		removeItem(Q4E4, 0x00);
	}
	barkTo(this, looker, "a bounty board with " + count + " posted bounties");
	return(0x00);
}

forward void postKillerToBB(list args);

trigger message("clearBounties") {
	list Q4E4;
	getContents(Q4E4, this);
	for (int i = numInList(Q4E4); i; i--) {
		deleteObject(Q4E4[0x00]);
		removeItem(Q4E4, 0x00);
	}
	return(0x01);
}

trigger message("setBounty") {
	postKillerToBB(args);
	return(0x01);
}

function string Q4RW(int Q4XG) {
	if (!Q4XG) {
		return("");
	}
	Q4XG = Q4XG - 0x044C;
	switch(Q4XG) {
	case 0x00
		return("indeterminate color");
		break;
	case 0x01
	case 0x02
	case 0x03
		return("white");
		break;
	case 0x04
	case 0x05
	case 0x06
		return("graying");
		break;
	case 0x07
	case 0x08
		return("black hair");
	case 0x09
	case 0x0A
	case 0x0B
		return("copper");
		break;
	case 0x0C
	case 0x0D
	case 0x0E
	case 0x0F
		return("brown");
		break;
	case 0x10
		return("reddish brown");
		break;
	case 0x11
	case 0x12
	case 0x13
		return("blonde");
		break;
	case 0x14
	case 0x15
	case 0x16
		return("light brown");
		break;
	case 0x17
	case 0x18
		return("golden brown");
		break;
	case 0x19
	case 0x1A
	case 0x1B
		return("golden");
		break;
	case 0x1C
	case 0x1D
	case 0x1E
		return("bronze");
		break;
	case 0x1F
	case 0x20
		return("dark brown");
		break;
	case 0x21
	case 0x22
		return("sandy");
		break;
	case 0x23
	case 0x24
	case 0x25
		return("honey-colored");
		break;
	case 0x26
	case 0x27
	case 0x28
		return("red");
		break;
	case 0x29
	case 0x2A
	case 0x2B
		return("nut brown");
		break;
	case 0x2C
	case 0x2D
	case 0x2E
		return("rich brown");
		break;
	case 0x2F
	case 0x30
		return("very dark brown");
		break;
	}
	return("outlandishly colored");
}

function string Q4RX(int Q65M) {
	string Q5Y4;
	switch(Q65M) {
	case 0x2049
		Q5Y4 = "hair in two pigtails";
		break;
	case 0x2047
		Q5Y4 = "curly hair";
		break;
	case 0x2046
		Q5Y4 = "hair tied in buns";
		break;
	case 0x204A
		Q5Y4 = "shaved head and topknot";
		break;
	case 0x203C
		Q5Y4 = "hair worn long";
		break;
	case 0x2044
		Q5Y4 = "a mohawk hairstyle";
		break;
	case 0x203D
		Q5Y4 = "hair tied back";
		break;
	case 0x2045
		Q5Y4 = "pageboy hair";
		break;
	case 0x2048
		Q5Y4 = "receding hairline";
		break;
	case 0x203B
		Q5Y4 = "hair worn short";
		break;
	default
		Q5Y4 = "bald";
		break;
	}
	return(Q5Y4);
}

function string Q4SU(int Q4XG) {
	string Q5Y4;
	Q4XG = Q4XG - 0x03E8;
	Q4XG = Q4XG - 0x8000;
	switch(Q4XG) {
	case 0x0F
	case 0x16
	case 0x1D
	case 0x1E
	case 0x24
	case 0x25
		Q5Y4 = "pale";
		break;
	case 0x08
	case 0x09
	case 0x17
	case 0x1F
	case 0x2C
	case 0x2D
	case 0x01
	case 0x02
	case 0x10
	case 0x11
	case 0x12
	case 0x2E
		Q5Y4 = "fair";
		break;
	case 0x0A
	case 0x0B
	case 0x13
	case 0x18
	case 0x19
	case 0x20
	case 0x26
	case 0x27
	case 0x28
	case 0x2F
		Q5Y4 = "tanned";
		break;
	case 0x03
	case 0x04
	case 0x05
	case 0x0C
	case 0x1A
	case 0x29
	case 0x2A
	case 0x30
	case 0x38
		Q5Y4 = "copper";
		break;
	case 0x06
	case 0x07
	case 0x0D
	case 0x0E
	case 0x14
	case 0x15
	case 0x1B
	case 0x1C
	case 0x21
	case 0x22
	case 0x23
	case 0x2B
	case 0x31
	case 0x32
	case 0x39
		Q5Y4 = "dark";
		break;
	case 0x33
	case 0x34
	case 0x35
		Q5Y4 = "yellow";
		break;
	default
		Q5Y4 = "deathly";
		break;
	}
	return(Q5Y4);
}

function string Q4RY(int murderCount) {
	list Q5Y8 = "hath murdered one too many!", "shall not slay again!", "hath slain too many!", "cannot continue to kill!", "must be stopped.", "is a bloodthirsty monster.", "is a killer of the worst sort.", "hath no conscience!", "hath cowardly slain many.", "must die for all our sakes.", "sheds innocent blood!", "must fall to preserve us.", "must be taken care of.", "is a thug and must die.", "cannot be redeemed.", "is a shameless butcher.", "is a callous monster.", "is a cruel, casual killer.";
	string Q5Y4 = Q5Y8[random(0x00, numInList(Q5Y8) - 0x01)];
	return(Q5Y4);
}

function string Q4J2(int bounty) {
	list Q5Y8 = "  A bounty is hereby offered", "  Lord British sets a price", "  Claim the reward! 'Tis", "  Lord Blackthorn set a price", "  The Paladins set a price", "  The Merchants set a price", "  Lord British's bounty ";
	string Q5Y4 = Q5Y8[random(0x00, numInList(Q5Y8) - 0x01)];
	return(Q5Y4);
}

function obj Q5K6(obj Q47Z, obj Q521) {
	obj Q58D;
	obj killer;
	obj Q4QI;
	list Q4E4;
	getContents(Q4E4, Q47Z);
	int Q55T = numInList(Q4E4);
	for (int i = 0x00; i < Q55T; i++) {
		Q58D = Q4E4[i];
		if (getObjType(Q58D) == 0x0EB0) {
			if (hasObjVar(Q58D, "killer")) {
				killer = getObjVar(Q58D, "killer");
				if (killer == Q521) {
					return(Q58D);
				}
			}
		}
	}
	return(NULL());
}

function void postKillerToBB(list args) {
	debugMessage("postKillerToBB:  args=");
	printList(args);
	obj killer = args[0x00];
	int bounty = args[0x01];
	string Q522 = args[0x02];
	list postText = Q522 + ":  " + bounty + "gold.                      ";
	if (numInList(args) > 0x03) {
		int murderCount = oprlist(args[0x03], 0x00);
		int Q5RO = oprlist(args[0x03], 0x01);
		int Q4UT = oprlist(args[0x03], 0x02);
		int Q4UR = oprlist(args[0x03], 0x03);
		int Q5TN = oprlist(args[0x03], 0x04);
		obj Q58D = Q5K6(this, killer);
		if (Q58D == NULL()) {
			Q58D = createNoResObjectIn(0x0EB0, this);
		}
		setObjVar(Q58D, "killer", killer);
		string Q5Y5;
		string Q5Y6;
		string Q67E;
		string Q67F;
		switch(random(0x00, 0x05)) {
		case 0x00
			default
			Q5Y5 = "Bounty for ";
			Q5Y6 = "!";
			break;
		case 0x01
			Q5Y5 = "";
			Q5Y6 = " must die!";
			break;
		case 0x02
			Q5Y5 = "A price on ";
			Q5Y6 = "!";
			break;
		case 0x03
			Q5Y5 = "";
			Q5Y6 = " outlawed!";
			break;
		case 0x04
			Q5Y5 = "Execute ";
			Q5Y6 = "!";
			break;
		case 0x05
			Q5Y5 = "WANTED: ";
			Q5Y6 = "!";
			break;
		}
		string Q4W4;
		string Q4W6;
		string Q4VJ;
		if (Q5RO) {
			Q4W4 = "her";
			Q4W6 = "her";
			Q4VJ = "she";
		} else {
			Q4W4 = "him";
			Q4W6 = "his";
			Q4VJ = "he";
		}
		int Q534 = wordWrap(postText, "The foul scum known as " + Q522 + " " + Q4RY(murderCount) + "  For " + Q4VJ + " is responsible for " + murderCount + " murders.  " + Q4J2(bounty) + " of " + bounty + " gold pieces for " + Q4W6 + " head!", 0x1C);
		appendToList(postText, "  A description:");
		if (Q4UR) {
			appendToList(postText, "    - " + Q4RW(Q4UR) + " hair");
		}
		appendToList(postText, "    - " + Q4RX(Q4UT));
		appendToList(postText, "    - " + Q4SU(Q5TN) + " skin");
		appendToList(postText, "If you kill " + Q4W4 + ", remove the");
		appendToList(postText, "head, and give it to a guard");
		appendToList(postText, "to claim your reward.");
	} else {
		appendToList(postText, "No information available.");
	}
	setObjVar(Q58D, "postText", postText);
	setPostTime(Q58D);
	return();
}
