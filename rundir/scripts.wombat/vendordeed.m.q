inherits housestuff;

trigger creation {
	setObjVar(this, "mybasevalue", 0x03E8);
	return(0x00);
}

trigger use {
	loc Q4F2 = getLocation(this);
	obj house = Q4YP(user, Q4F2);
	if (!isValid(house)) {
		systemMessage(user, "Shops can only be set up near your house.");
		return(0x00);
	}
	if (!Q4WR(house)) {
		systemMessage(user, "This house can not support any more vendors.");
		return(0x00);
	}
	loc Q5Z7 = getLocation(user);
	int Q5ZB = random(0x0835, 0x0836);
	obj vendor = createGlobalNPCAt(Q5ZB, Q4F2, 0x00);
	if (vendor == NULL()) {
		systemMessage(user, "Vendor was unable to be created there.");
		return(0x00);
	}
	setObjVar(vendor, "owner", user);
	setObjVar(vendor, "multi", house);
	attachScript(vendor, "vendor");
	disableBehaviors(vendor);
	Q4WQ(house, vendor);
	deleteObject(this);
	return(0x00);
}
