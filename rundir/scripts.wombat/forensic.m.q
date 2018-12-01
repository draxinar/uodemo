inherits sk_table;

trigger message("canUseSkill") {
	return(0x00);
}

trigger callback(0x4D) {
	detachScript(this, "forensic");
	return(0x00);
}

trigger message("useSkill") {
	callback(this, 0x0A, 0x4D);
	systemMessage(this, "Show me the corpse.");
	targetObj(this, this);
	return(0x00);
}

trigger targetobj {
	if (usedon == NULL()) {
		return(0x00);
	}
	list users;
	string Q5KJ;
	int Q66P = getObjType(usedon);
	switch(Q66P) {
	case 0x3D67
	case 0x3D68
	case 0x2006
		if (hasObjVar(usedon, "forensicist")) {
			string Q4Q8 = getObjVar(usedon, "forensicist");
			barkTo(user, user, "The forensicist " + Q4Q8 + " has already discovered that:");
		} else {
			if (testAndLearnSkill(user, 0x13, 0x32, 0x64) <= 0x00) {
				barkTo(user, user, "You cannot determine anything useful.");
				return(0x00);
			}
			setObjVar(usedon, "forensicist", getName(user));
		}
		if (hasObjVar(usedon, "murderer")) {
			string murderer = getObjVar(usedon, "murderer");
			barkTo(user, user, "This person was killed by " + murderer + " .");
		}
		if (hasObjVar(usedon, "users")) {
			getObjListVar(users, usedon, "users");
			int Q5ED = numInList(users);
			string Q47R;
			Q47R = "This body has been disturbed by ";
			for (int i = 0x00; i < Q5ED; i++) {
				Q5KJ = users[i];
				Q47R = Q47R + Q5KJ;
				if (i < (Q5ED - 0x02)) {
					Q47R = Q47R + ", ";
				}
				if (i == (Q5ED - 0x02)) {
					Q47R = Q47R + ", and ";
				}
				if (i == (Q5ED - 0x01)) {
					Q47R = Q47R + ".";
				}
			}
			barkTo(user, user, Q47R);
		} else {
			barkTo(user, user, "This corpse has not been desecrated.");
		}
		break;
	default
		barkTo(user, user, "Can't use forensic skill on that.");
		break;
	}
	return(0x00);
}
