trigger creation {
	setType(this, 0x375A);
	return(0x00);
}

trigger enterrange(0x01) {
	loc Q648 = 0x16C3, 0x0251, 0x00;
	if (!teleport(target, Q648)) {
		return(0x01);
	}
	return(0x00);
}
