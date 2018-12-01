inherits pet;

trigger use {
	if (isDead(user)) {
		return(0x00);
	}
	if (!hasObjListVar(this, "myBoss")) {
		barkTo(this, user, "That horse does not look broken! You would have to tame it to ride it.");
		return(0x00);
	}
	if (hasObjListVar(this, "myBoss")) {
		if (!Q4BD(this, user)) {
			barkTo(this, user, "This isn't your horse; it refuses to let you ride.");
			return(0x00);
		}
		return(0x01);
	}
	return(0x01);
}
