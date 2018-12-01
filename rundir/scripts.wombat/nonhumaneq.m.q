inherits globals;

trigger creation {
	int Q4AY;
	obj Q4Q1;
	int Q48L = getObjType(this);
	if (Q48L == 0x29) {
		Q4Q1 = requestCreateObjectIn(0x13B4, this);
		if (Q4Q1 == NULL()) {
			setType(this, 0x11);
		}
		return(0x01);
	}
	if (Q48L == 0x07) {
		Q4Q1 = requestCreateObjectIn(0x1F0B, this);
		if (Q4Q1 == NULL()) {
			setType(this, 0x11);
			return(0x01);
		}
		Q4Q1 = requestCreateObjectIn(0x1443, this);
		if (Q4Q1 == NULL()) {
			setType(this, 0x11);
			return(0x01);
		}
		Q4Q1 = requestCreateObjectIn(0x13EC, this);
		if (Q4Q1 == NULL()) {
			setType(this, 0x11);
			return(0x01);
		}
	}
	if (Q48L == 0x2C) {
		Q4AY = random(0x01, 0x04);
		if (Q4AY == 0x01) {
			Q4Q1 = requestCreateObjectIn(0x1407, this);
		}
		if (Q4AY == 0x02) {
			Q4Q1 = requestCreateObjectIn(0x0F5C, this);
		}
		if (Q4AY == 0x03) {
			Q4Q1 = requestCreateObjectIn(0x143B, this);
		}
		if (Q4AY == 0x04) {
			Q4Q1 = requestCreateObjectIn(0x1439, this);
		}
		if (Q4Q1 == NULL()) {
			setType(this, 0x2A);
		}
		return(0x01);
	}
	if (Q48L == 0x2D) {
		Q4AY = random(0x01, 0x08);
		if (Q4AY == 0x01) {
			Q4Q1 = requestCreateObjectIn(0x1441, this);
		}
		if (Q4AY == 0x02) {
			Q4Q1 = requestCreateObjectIn(0x143F, this);
		}
		if (Q4AY == 0x03) {
			Q4Q1 = requestCreateObjectIn(0x13FF, this);
		}
		if (Q4AY == 0x04) {
			Q4Q1 = requestCreateObjectIn(0x0EFA, this);
		}
		if (Q4AY == 0x05) {
			Q4Q1 = requestCreateObjectIn(0x0F61, this);
		}
		if (Q4AY == 0x06) {
			Q4Q1 = requestCreateObjectIn(0x13B8, this);
		}
		if (Q4AY == 0x07) {
			Q4Q1 = requestCreateObjectIn(0x13B9, this);
		}
		if (Q4AY == 0x08) {
			Q4Q1 = requestCreateObjectIn(0x13B6, this);
		}
		if (Q4Q1 == NULL()) {
			setType(this, 0x2A);
		}
		return(0x01);
	}
	if (Q48L == 0x23) {
		Q4Q1 = requestCreateObjectIn(0x0F62, this);
		if (Q4Q1 == NULL()) {
			setType(this, 0x21);
		}
		return(0x01);
	}
	if (Q48L == 0x24) {
		Q4AY = random(0x01, 0x04);
		if (Q4AY == 0x01) {
			Q4Q1 = requestCreateObjectIn(0x1407, this);
		}
		if (Q4AY == 0x02) {
			Q4Q1 = requestCreateObjectIn(0x0F5C, this);
		}
		if (Q4AY == 0x03) {
			Q4Q1 = requestCreateObjectIn(0x143B, this);
		}
		if (Q4AY == 0x04) {
			Q4Q1 = requestCreateObjectIn(0x1439, this);
		}
		if (Q4Q1 == NULL()) {
			setType(this, 0x21);
		}
		return(0x01);
	}
	if (Q48L == 0x02) {
		Q4Q1 = requestCreateObjectIn(0x0F47, this);
		if (Q4Q1 == NULL()) {
			setType(this, 0x12);
		}
		return(0x01);
	}
	if (Q48L == 0x0A) {
		Q4AY = random(0x01, 0x08);
		if (Q4AY == 0x01) {
			Q4Q1 = requestCreateObjectIn(0x1441, this);
		}
		if (Q4AY == 0x02) {
			Q4Q1 = requestCreateObjectIn(0x143F, this);
		}
		if (Q4AY == 0x03) {
			Q4Q1 = requestCreateObjectIn(0x13FF, this);
		}
		if (Q4AY == 0x04) {
			Q4Q1 = requestCreateObjectIn(0x0EFA, this);
		}
		if (Q4AY == 0x05) {
			Q4Q1 = requestCreateObjectIn(0x0F61, this);
		}
		if (Q4AY == 0x06) {
			Q4Q1 = requestCreateObjectIn(0x13B8, this);
		}
		if (Q4AY == 0x07) {
			Q4Q1 = requestCreateObjectIn(0x13B9, this);
		}
		if (Q4AY == 0x08) {
			Q4Q1 = requestCreateObjectIn(0x13B6, this);
		}
		if (Q4Q1 == NULL()) {
			setType(this, 0x09);
		}
		return(0x01);
	}
	if (Q48L == 0x38) {
		Q4Q1 = requestCreateObjectIn(0x0F47, this);
		if (Q4Q1 == NULL()) {
			setType(this, 0x32);
		}
		return(0x01);
	}
	if (Q48L == 0x39) {
		Q4Q1 = requestCreateObjectIn(0x1B7A, this);
		if (Q4Q1 == NULL()) {
			setType(this, 0x32);
			return(0x01);
		}
		Q4AY = random(0x01, 0x08);
		if (Q4AY == 0x01) {
			Q4Q1 = requestCreateObjectIn(0x1441, this);
		}
		if (Q4AY == 0x02) {
			Q4Q1 = requestCreateObjectIn(0x143F, this);
		}
		if (Q4AY == 0x03) {
			Q4Q1 = requestCreateObjectIn(0x13FF, this);
		}
		if (Q4AY == 0x04) {
			Q4Q1 = requestCreateObjectIn(0x0EFA, this);
		}
		if (Q4AY == 0x05) {
			Q4Q1 = requestCreateObjectIn(0x0F61, this);
		}
		if (Q4AY == 0x06) {
			Q4Q1 = requestCreateObjectIn(0x13B8, this);
		}
		if (Q4AY == 0x07) {
			Q4Q1 = requestCreateObjectIn(0x13B9, this);
		}
		if (Q4AY == 0x08) {
			Q4Q1 = requestCreateObjectIn(0x13B6, this);
		}
		if (Q4Q1 == NULL()) {
			setType(this, 0x32);
		}
		return(0x01);
	}
	if (Q48L == 0x35) {
		Q4Q1 = requestCreateObjectIn(0x0F47, this);
		if (Q4Q1 == NULL()) {
			setType(this, 0x36);
		}
		return(0x01);
	}
	if (Q48L == 0x37) {
		Q4AY = random(0x01, 0x04);
		if (Q4AY == 0x01) {
			Q4Q1 = requestCreateObjectIn(0x1407, this);
		}
		if (Q4AY == 0x02) {
			Q4Q1 = requestCreateObjectIn(0x0F5C, this);
		}
		if (Q4AY == 0x03) {
			Q4Q1 = requestCreateObjectIn(0x143B, this);
		}
		if (Q4AY == 0x04) {
			Q4Q1 = requestCreateObjectIn(0x1439, this);
		}
		if (Q4Q1 == NULL()) {
			setType(this, 0x36);
		}
		return(0x01);
	}
	return(0x01);
}
