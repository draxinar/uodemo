trigger 0x03E8enterrange(0x05) {
	if (isPlayer(target)) {
		obj player = target;
		doLightning(target);
		loc Q5IZ = getLocation(player);
		sfx(Q5IZ, 0x020A, 0x020A);
		animateMobile(player, 0x14, 0x05, 0x01, 0x00, 0x00);
		doDamage(player, player, 0x0A);
	}
	return(0x01);
}
