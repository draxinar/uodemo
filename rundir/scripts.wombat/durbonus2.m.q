inherits spelskil;

trigger creation {
	int Q4G7 = getWeaponMaxHP(this);
	int Q5BV = Q4G7 + 0x14;
	int dummy = setWeaponMaxHP(this, Q5BV);
	return(0x00);
}
