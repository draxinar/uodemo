inherits platemail;

trigger creation {
	setObjVar(this, "plateMailCost", 0x02);
	return(0x01);
}
