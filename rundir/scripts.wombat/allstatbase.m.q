inherits spelskil;

function int Q4IT(obj user, obj usedon, int Q4ID, int Q5NM) {
	int Q5NC = 0x00;
	if (Q50G(usedon)) {
		int Q4NC;
		loc Q4VS = getLocation(user);
		loc there = getLocation(usedon);
		int Q5VZ;
		faceHere(user, getDirectionInternal(Q4VS, there));
		if (hasObjVar(this, "magicItemModifier")) {
			int Q52W = getObjVar(this, "magicItemModifier");
			Q4NC = 0x06 * Q52W;
			Q5VZ = Q52W;
		} else {
			Q4NC = 0x06 * getSkillLevel(user, 0x19) / 0x05;
			Q5VZ = (getSkillLevel(user, 0x19) / 0x0A) + 0x01;
		}
		int Q5A7 = 0x373A;
		int Q5AN = 0x01EA;
		if (!Q4ID) {
			Q5A7 = 0x374A;
			Q5AN = 0x01E1;
			Q5VZ = 0x00 - Q5VZ;
		}
		sfx(there, 0x01EA, 0x00);
		doMobAnimation(usedon, Q5A7, 0x0A, 0x0F, 0x00, 0x00);
		for (int s = 0x00; s < 0x03; s++) {
			if (Q41Q(usedon, s, Q5VZ, Q4NC)) {
				Q5NC = 0x01;
			}
		}
		if (!Q4ID) {
			Q422(user, usedon, 0x00, Q5NM);
			Q5UK(user, usedon, 0x02, Q5NM);
			Q41C(user, usedon, Q5NM);
			receiveUnhealthyActionFrom(usedon, user);
		}
	}
	Q5UQ(this);
	return(Q5NC);
}
