inherits spelskil;

function void Q65X() {
	setDefaultReturn(0x01);
	Q42D(this, 0x01, 0x00);
	handleHealthGain(this);
	return();
}

trigger message("cancelmagic") {
	Q65X();
	return(0x01);
}

trigger callback(0x6A) {
	Q65X();
	return(0x01);
}

trigger ishealthy {
	return(0x00);
}
