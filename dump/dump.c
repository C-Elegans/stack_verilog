#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
FILE *fp;
#define MAXBUFLEN 10000
uint16_t buffer[MAXBUFLEN];
int main(int argc, char** argv){
	if(argc != 2){
		puts("Usage ./dump file\n");
		exit(-1);
	}
	fp = fopen(argv[1], "rb");
	if(fp != NULL){
		size_t bytes = fread(buffer, sizeof(uint16_t), MAXBUFLEN, fp);
		for(int i=0; i<bytes;i++){
			printf("%04x\n",buffer[i]);
		}
		fclose(fp);
	}
	

}
