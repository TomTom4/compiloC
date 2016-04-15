int main(){
int *a = 0;
int b = 12;
a = &b; 
 while( a == b){
 	a= a+b;
 	if (a == a+b){
 		printf(a);
 	}
 	else{
 		printf(12);
 	}
 }
 b= a*2;
}


