trigger use {
	obj head = createNoResObjectAt(0x1DA0, getLocation(user));
	setObjVar(head, "bountyObjID", user);
	return(0x01);
}
