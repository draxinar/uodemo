trigger creation {
	list Q5J1;
	getPlayersInRange(Q5J1, getLocation(this), 0x270F);
	int Q55T = numInList(Q5J1);
	for (int i = 0x00; i < Q55T; i++) {
		attachScript(Q5J1[i], "fixme");
	}
	bark(this, "fixme should have been run on all players now.");
	detachScript(this, "fixall");
	return(0x01);
}
