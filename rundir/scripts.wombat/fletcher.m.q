inherits itemmanip;

trigger use {
	if (isAtHome(this)) {
		systemMessage(user, "You can't use that, it belongs to someone else.");
		return(0x00);
	}
	int Q62A = getObjType(this);
	loc Q61U = getLocation(this);
	switch(Q62A) {
	case 0x1BD1
		systemMessage(user, "Select the shafts you wish to use this on.");
		break;
	case 0x1BD4
		systemMessage(user, "Select the feathers you wish to use this on.");
		break;
	}
	targetObj(user, this);
	return(0x00);
}

trigger targetobj {
	if (usedon == NULL()) {
		return(0x00);
	}
	if (isAtHome(usedon)) {
		systemMessage(user, "That belongs to someone else.");
		return(0x00);
	}
	int Q62A = getObjType(this);
	int Q66P = getObjType(usedon);
	loc Q66U = getLocation(user);
	loc Q61U = getLocation(this);
	loc Q66N = getLocation(usedon);
	obj Q4EZ;
	list args;
	if (testAndLearnSkill(user, 0x08, 0x00, 0x50) > 0x00) {
		switch(Q62A) {
		case 0x1BD1
			switch(Q66P) {
			case 0x1BD4
				attachScript(user, "makingarrows");
				args = this, usedon;
				message(user, "makearrows", args);
				break;
			default
				systemMessage(user, "Can't use feathers on that.");
				return(0x00);
				break;
			}
			break;
		case 0x1BD4
			switch(Q66P) {
			case 0x1BD1
				attachScript(user, "makingarrows");
				args = usedon, this;
				message(user, "makearrows", args);
				break;
			default
				systemMessage(user, "Can't use shafts on that.");
				return(0x00);
				break;
			}
			break;
		default
			return(0x00);
			break;
		}
	} else {
		systemMessage(user, "Fletching failed.");
		int Q5MT;
		int Q4Q1;
		if (!random(0x00, 0x03)) {
			debugMessage("!rand");
			debugMessage("thistype = " + Q62A);
			if (Q62A == 0x1BD1) {
				systemMessage(user, "A feather was destroyed.");
				returnResourcesToBank(this, 0x01, "feathers");
				Q4Q1 = getResource(Q5MT, this, "feathers", 0x03, 0x02);
			}
			if (Q62A == 0x1BD4) {
				systemMessage(user, "A shaft was destroyed.");
				returnResourcesToBank(this, 0x01, "wood");
				Q4Q1 = getResource(Q5MT, this, "wood", 0x03, 0x02);
			}
			if (Q5MT < 0x01) {
				deleteObject(this);
			}
		}
	}
	return(0x01);
}
