inherits virtueguild;

trigger message("addedToSpecialGuild") {
	systemMessage(this, "To get your shield, ask any of Lord Blackthorn's Guards.");
	setObjVar(this"displayGuildAbbr", 0x01);
	return(0x01);
}
