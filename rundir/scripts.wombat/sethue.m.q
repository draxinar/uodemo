trigger use {
	int x = getHue(this);
	if (x < 0x0960) {
		x = 0x0960;
	}
	x = x + 0x01;
	if (x > 0x097D) {
		x = 0x0961;
	}
	setHue(this, x);
	string Q4XU = x;
	bark(this, Q4XU);
	return(0x01);
}
