inherits globals;

trigger time("min:**") {
	if (hasObjVar(this, "drunk")) {
		int Q4EJ = getObjVar(this, "drunk");
		if (Q4EJ > 0x00) {
			Q4EJ = Q4EJ - 0x01;
			if (random(0x01, 0x0A) == 0x01) {
				setObjVar(this, "drunk", Q4EJ);
			}
			loseFatigue(this, 0x01);
			loseMana(this, 0x01);
			if (random(0x01, 0x04) == 0x01) {
				if (getItemAtSlot(this, 0x19) == NULL()) {
					int Q4ID = random(0x01, 0x08);
					faceHere(this, Q4ID);
					if (!isDead(this)) {
						animateMobile(this, 0x20, 0x05, 0x01, 0x00, 0x01);
					}
				}
				list Q5J1;
				getPlayersInRange(Q5J1, getLocation(this), 0x0A);
				for (int i = 0x00; i < numInList(Q5J1); i++) {
					obj Q4VU = Q5J1[i];
					barkTo(this, Q4VU, "*hic*");
				}
			}
			return(0x00);
		} else {
			barkTo(this, this, "You feel sober.");
			removeObjVar(this, "drunk");
		}
	}
	detachScript(this, "drunk");
	return(0x00);
}
