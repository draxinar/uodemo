trigger creation {
	list Q4QZ = 0x10F7, 0x10F8, 0x10F9, 0x10FA, 0x10FB, 0x10F9, 0x10F5;
	setObjVar(this, "AnimFrames", Q4QZ);
	setObjVar(this, "TrapDamage", 0x0F);
	attachScript(this, "trapped");
	return(0x01);
}
