double integral(double a, double b, double start, double finish) {
	double res = 0, i;
	for (i = start; i <= finish; i += 0.0001) {
		res += (a + b * i * i * i * i) * 0.0001;
	}
	if (i > finish) {
		res += (a + b * finish * finish * finish * finish) * (0.0001 - (i - finish));
	}
	return res;
}
