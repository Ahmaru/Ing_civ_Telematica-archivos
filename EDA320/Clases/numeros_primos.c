#include <stdio.h>

int main(){

	long int n = 0;

	printf("NUMERO: \n");
	scanf("%ld",&n);
	
	long int noEsPrimo[n-1];

	for (long int i = 2; i<n; i++){
		for (long int j = 2; i*j<n; j++){
			if (noEsPrimo[i-2] == 1) break;
			noEsPrimo[i*j-2] = 1;
		};
	};

	if (noEsPrimo[n-2] == 0){
		printf("Numero primo. \n");
	}else if (noEsPrimo[n-2] == 1) {
		printf("Numero compuesto. \n");
	}

	return 0;
};