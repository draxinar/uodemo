inherits globals;

forward void Q4N7();

trigger creation {
	int Q62A = getObjType(this);
	switch(Q62A) {
	case 0x0D94
	case 0x0D98
	case 0x0D9C
	case 0x0DA0
	case 0x0DA4
	case 0x0DA8
	case 0x0CA8
	case 0x0CAA
	case 0x0CAB
	case 0x0C95
	case 0x0C96
		callback(this, 0x04B0, 0x40);
		break;
	}
	return(0x00);
}

trigger callback(0x40) {
	int Q4Q1;
	int Q4R1;
	Q4Q1 = getResource(Q4R1, this, "fruit", 0x03, 0x02);
	if (Q4R1 > 0x01) {
		loc Q61U = getLocation(this);
		int Q62A = getObjType(this);
		int fruit;
		switch(Q62A) {
		case 0x0D94
		case 0x0D98
			fruit = 0x09D0;
			break;
		case 0x0D9C
		case 0x0DA0
			fruit = 0x09D2;
			break;
		case 0x0DA4
		case 0x0DA8
			fruit = 0x172D;
			break;
		case 0x0CA8
		case 0x0CAA
		case 0x0CAB
			fruit = 0x171F;
			break;
		case 0x0C95
			fruit = 0x1726;
			break;
		case 0x0C96
			fruit = 0x1727;
			break;
		}
		loc destination = Q61U;
		list Q4R2;
		getObjectsInRangeOfType(Q4R2, Q61U, 0x03, fruit);
		int Q5L7 = random(0x01, 0x06);
		if (Q5L7 == 0x01) {
			if (numInList(Q4R2) < 0x05) {
				int Q5L9 = 0x02 - random(0x00, 0x04);
				int Q5LA = 0x02 - random(0x00, 0x04);
				changeLoc(destination, Q5L9, Q5LA, 0x00);
				obj Q4EY = createNoResObjectAt(fruit, destination);
				transferResources(Q4EY, this, 0x02, "fruit");
			}
		}
	}
	callback(this, 0x04B0, 0x40);
	return(0x00);
}

trigger use {
	int Q62A = getObjType(this);
	int Q52L = 0x00;
	int fruit;
	switch(Q62A) {
	case 0x0D94
	case 0x0D98
		Q52L = 0x00;
		fruit = 0x09D0;
		break;
	case 0x0D95
	case 0x0D96
	case 0x0D97
	case 0x0D99
	case 0x0D9A
	case 0x0D9B
		Q52L = 0x01;
		fruit = 0x09D0;
		break;
	case 0x0D9C
	case 0x0DA0
		Q52L = 0x00;
		fruit = 0x09D2;
		break;
	case 0x0D9D
	case 0x0D9E
	case 0x0D9F
	case 0x0DA1
	case 0x0DA2
	case 0x0DA3
		Q52L = 0x01;
		fruit = 0x09D2;
		break;
	case 0x0DA4
	case 0x0DA8
		Q52L = 0x00;
		fruit = 0x172D;
		break;
	case 0x0DA5
	case 0x0DA6
	case 0x0DA7
	case 0x0DA9
	case 0x0DAA
	case 0x0DAB
		Q52L = 0x01;
		fruit = 0x172D;
		break;
	case 0x0CA8
	case 0x0CAA
	case 0x0CAB
		Q52L = 0x00;
		fruit = 0x171F;
		break;
	case 0x0C95
		Q52L = 0x00;
		fruit = 0x1726;
		break;
	case 0x0C96
		Q52L = 0x00;
		fruit = 0x1727;
		break;
	}
	obj Q551;
	loc Q61V = getLocation(this);
	if (Q52L == 0x01) {
		switch(fruit) {
		case 0x09D0
		case 0x0D94
		case 0x0D98
			Q551 = getFirstObjectOfType(Q61V, 0x0D94);
			if (Q551 == NULL()) {
				Q551 = getFirstObjectOfType(Q61V, 0x0D98);
			}
			break;
		case 0x09D2
		case 0x0D9C
		case 0x0DA0
			Q551 = getFirstObjectOfType(Q61V, 0x0D9C);
			if (Q551 == NULL()) {
				Q551 = getFirstObjectOfType(Q61V, 0x0DA0);
			}
			break;
		case 0x172D
		case 0x0DA4
		case 0x0DA8
			Q551 = getFirstObjectOfType(Q61V, 0x0DA4);
			if (Q551 == NULL()) {
				Q551 = getFirstObjectOfType(Q61V, 0x0DA8);
			}
			break;
		}
	} else {
		Q551 = this;
	}
	if (Q551 == NULL()) {
		systemMessage(user, "couldn't find a tree");
		return(0x00);
	}
	int Q4R1;
	int Q4Q1 = getResource(Q4R1, Q551, "fruit", 0x03, 0x02);
	if (Q4R1 > 0x01) {
		obj Q47F = getBackpack(user);
		obj Q4EY = createNoResObjectIn(fruit, Q47F);
		transferResources(Q4EY, Q551, 0x02, "fruit");
		systemMessage(user, "You pick some fruit and put it in your backpack.");
	} else {
		systemMessage(user, "There is no more fruit on this tree");
	}
	return(0x00);
}
