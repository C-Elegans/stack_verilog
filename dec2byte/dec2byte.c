#include <stdio.h>
#include <stdlib.h>
char line[1024], *p,*e;
long v;
int main(void){

while(fgets(line,sizeof(line),stdin)){
	p = line;
	for(p=line; ; p=e){
		v = strtol(p,&e,10);
		if(p == e) break;
		printf("%d\n",(unsigned char)v);
	
	}

}
}


