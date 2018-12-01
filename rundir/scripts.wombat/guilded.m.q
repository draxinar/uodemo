forward string guildName();

forward string Q4UL();

forward string myGuildTitle();

forward void Q4TI(obj this);

forward void cleanup(obj this);

member obj me;

trigger lookedat {
	string ab = getObjVar(this, "guildAbbreviation");
	if (ab == "none") {
		ab = guildName();
	}
	if (hasObjVar(this, "displayGuildAbbr")) {
		barkTo(this, looker, "[" + ab + "]");
	}
	return(0x01);
}

trigger objectloaded {
	Q4TI(this);
	return(0x01);
}

function string guildName() {
	if (!hasObjVar(me, "guildName")) {
		cleanup(me);
	}
	string x = getObjVar(me, "guildName");
	return(x);
}

function string Q4UL() {
	if (!hasObjVar(me, "guildAbbreviation")) {
		cleanup(me);
	}
	string x = getObjVar(me, "guildAbbreviation");
	return(x);
}

function string myGuildTitle() {
	if (!hasObjVar(me, "myGuildTitle")) {
		cleanup(me);
	}
	string x = getObjVar(me, "myGuildTitle");
	return(x);
}

trigger creation {
	me = this;
	setObjVar(this, "guildName", "unaffiliated");
	setObjVar(this, "guildAbbreviation", "none");
	setObjVar(this, "myGuildTitle", "");
	Q4TI(this);
	return(0x01);
}

function void Q4TI(obj this) {
	if (!hasObjVar(this, "guildstoneId")) {
		cleanup(me);
		return();
	}
	obj Q4UE = getObjVar(this, "guildstoneId");
	list blah;
	multimessage(Q4UE, "updateMyGuildInfo", blah);
	return();
}

trigger message("updateGuildInfo") {
	int Q4ZH = args[0x00];
	string Q43M = args[0x01];
	string Q43L = args[0x02];
	string Q43O = args[0x03];
	if (Q43M != guildName()) {
		systemMessage(this, "The name of your guild has changed from " + guildName() + " to " + Q43M + ".");
		setObjVar(this, "guildName", Q43M);
	}
	if (Q43L != Q4UL()) {
		systemMessage(this, "Your guild abbreviation has changed from " + Q4UL() + " to " + Q43L + ".");
		setObjVar(this, "guildAbbreviation", Q43L);
	}
	if (Q43O != myGuildTitle()) {
		systemMessage(this, "You have been given a new guild title: " + Q43O + ".");
		setObjVar(this, "myGuildTitle", Q43O);
	}
	if (!Q4ZH) {
		systemMessage(this, "You have been dismissed from " + guildName() + ".");
		cleanup(this);
	}
	return(0x01);
}

function void cleanup(obj this) {
	removeObjVar(this, "guildName");
	removeObjVar(this, "guildAbbreviation");
	removeObjVar(this, "myGuildTitle");
	removeObjVar(this, "guildstoneId");
	removeObjVar(this, "displayGuildAbbr");
	detachScript(this, "guilded");
	return();
}

trigger message("removedFromGuild") {
	cleanup(this);
	return(0x01);
}

trigger message("guildMessage") {
	string Q65L = args[0x00];
	systemMessage(this, "Guild message: " + Q65L);
	return(0x01);
}

trigger message("globalGuildMessage") {
	string Q65L = args[0x00];
	systemMessage(this, "Guild message: " + Q65L);
	return(0x01);
}
