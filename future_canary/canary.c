#include <stdio.h>
#include <stdlib.h>

int main() {
	// set random seed
	srand(time(NULL));
	
	// generate stack canary
	int i = 0;
	for(i = 0; i < 10; i++) {
		printf("%d", rand());
		if (i < 9) printf(", ");
	}
}
