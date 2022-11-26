#include <stdio.h>

extern double integral(double a, double b, double start, double finish);

int main(int argc, char** argv) {
	FILE* input;
	FILE* output;
	char* instr;
	char* outstr;

	if (argc == 3) {
		instr = argv[1];
		outstr = argv[2];
	} else {
		printf("Incorect number of parameters.");
		return 1;
	}

	if (fopen(instr, "r") == NULL) {
		printf("Incorrect name of input file.");
		return 1;
	}

	input = fopen(instr, "r");
	output = fopen(outstr, "w");

	double a, b, start, finish;
	fscanf(input, "%lf%lf%lf%lf", &a, &b, &start, &finish);
	
	double res = integral(a, b, start, finish);
	fprintf(output, "%lf", res);

	fclose(input);
	fclose(output);	
}
