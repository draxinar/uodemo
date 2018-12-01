inherits spelskil;

member int Q4R0;

member int Q5JF;

member int strength;

member int Q42Y;

member int Q4FG;

function void Q5JB(obj victim, int strength) {
	Q4FG = getCurHP(victim);
	switch(strength) {
	case 0x01
		actionBark(victim, 0x21, "* You feel a bit nauseous... *", "* " + getName(victim) + " looks ill. *");
		Q42Y = Q4FG / 0x14;
		break;
	case 0x02
		actionBark(victim, 0x21, "* You feel disoriented and nauseous! *", "* " + getName(victim) + " looks extremely ill. *");
		Q42Y = Q4FG / 0x0F;
		Q4R0 = 0x0A;
		break;
	case 0x03
		actionBark(victim, 0x21, "* You begin to feel pain throughout your body! *", "* " + getName(victim) + " stumbles around in confusion and pain. *");
		Q42Y = Q4FG / 0x08;
		Q4R0 = 0x0A;
		break;
	case 0x04
		actionBark(victim, 0x21, "* You feel extremely weak and are in severe pain! *", "* " + getName(victim) + " is wracked with extreme pain. *");
		Q42Y = Q4FG / 0x04;
		Q4R0 = 0x05;
		break;
	case 0x05
		actionBark(victim, 0x21, "* You are in extreme pain, and require immediate aid! *", "* " + getName(victim) + " begins to spasm uncontrollably. *");
		Q42Y = Q4FG / 0x02;
		Q4R0 = 0x05;
		break;
	}
	return();
}

function int Q5JE(obj victim) {
	if (isDead(this)) {
		return(0x00);
	}
	if (!hasObjVar(this, "poison_strength")) {
		setObjVar(this, "poison_strength", 0x01);
		return(0x01);
	}
	if (getCurHP(this) < 0x00) {
		return(0x00);
	}
	return(0x01);
}

trigger creation {
	if (!Q5JE(this)) {
		Q660(this);
		return(0x00);
	}
	strength = getObjVar(this, "poison_strength");
	setPoisoned(this, 0x01);
	Q4R0 = 0x0F;
	Q5JB(this, strength);
	Q5JF = (random(0x0A, 0x14) * strength);
	callBack(this, Q4R0, 0x53);
	return(0x01);
}

trigger callback(0x53) {
	if (!Q5JE(this)) {
		Q660(this);
		return(0x00);
	}
	Q5JF--;
	if (Q5JF < 0x01) {
		systemMessage(this, "The poison seems to have worn off.");
		Q660(this);
		return(0x00);
	}
	doDamageType(NULL(), this, (Q42Y + 0x02), 0x08);
	if (!Q5JE(this)) {
		Q660(this);
		return(0x00);
	} else {
		if (!random(0x00, 0x02)) {
			strength = getObjVar(this, "poison_strength");
			Q5JB(this, strength);
		}
		callBack(this, Q4R0, 0x53);
		return(0x00);
	}
	Q660(this);
	return(0x00);
}

trigger ishealthy {
	return(0x00);
}
