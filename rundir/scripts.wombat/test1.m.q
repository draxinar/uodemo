inherits trap_single;

trigger enterrange(0x05) {
	bark(this, "I have been triggered.")int Q64U = Q64S(0x05, target, 0x1463, 0x0247, 0x00);
	string Q445 = Q64U;
	bark(this, "I did this much damage");
	bark(this, Q445);
	bark(this, "to:");
	bark(this, getName(target));
	return(0x00);
}
