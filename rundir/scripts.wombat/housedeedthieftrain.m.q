inherits housedeed;

function void Q4WV(obj Q5AO, loc Q5CV) {
	obj Q63A;
	if (Q5AO != NULL()) {
		setZ(Q5CV, getZ(Q5CV) + 0x07);
		setX(Q5CV, getX(Q5CV) - 0x02);
		setY(Q5CV, getY(Q5CV) + 0x01);
		Q63A = createGlobalObjectAt(0x1EC3, Q5CV);
		Q4X0(Q63A);
		setY(Q5CV, getY(Q5CV) - 0x03);
		setX(Q5CV, getX(Q5CV) + 0x03);
		Q63A = createGlobalObjectAt(0x1EC0, Q5CV);
		Q4X0(Q63A);
	}
	return();
}
