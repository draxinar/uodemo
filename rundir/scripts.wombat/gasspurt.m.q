inherits sndfx;

trigger 0x03E8enterrange(0x03) {
	if (isPlayer(target)) {
		obj player = target;
		loc Q5IZ = getLocation(player);
		
member loc Q5FI = getLocation(this);
		
member obj Q4R7 = requestCreateObjectAt(0x11A6, Q5FI);
		sfx(Q5FI, 0x0108, 0x0107);
	}
	return(0x01);
}

trigger 0xFAenterrange(0x01) {
	if (isPlayer(target)) {
		setPoisoned(target, 0x01);
		attachScript(target, "poisoned");
	}
	return(0x01)}

trigger 0x03E8enterrange(0x01) {
	if (isPlayer(target)) {
		int damage = random(0x01, 0x0A);
		loc Q5FI = getLocation(this);
		obj player = target;
		loc Q5IZ = getLocation(player);
		doDamage(player, player, damage);
		sfx(Q5IZ, 0x014C, 0x014C);
		animateMobile(player, 0x14, 0x01, 0x01, 0x00, 0x00);
	}
	return(0x01)}

trigger 0x03E8enterrange(0x00) {
	if (isPlayer(target)) {
		int damage = random(0x01, 0x1E);
		loc Q5IZ = getLocation(target);
		obj player = target;
		doDamage(player, player, 0x1E);
		sfx(Q5IZ, 0x014C, 0x014C);
		setPoisoned(player, 0x01);
		attachScript(player, "poisoned");
	}
	return(0x00)}

trigger 0x03E8leaverange(0x03) {
	deleteObject(Q4R7);
	return(0x01);
}
