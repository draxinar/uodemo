trigger use {
	bark(this, "I should be animating");
	doLocAnimation(getLocation(this), 0x1109, 0x02, 0x14, 0x00, 0x00);
	return(0x00);
}
