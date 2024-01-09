#include <stdio.h>
#include <stdlib.h>

void p1(){
    unsigned int x = 19653;
    FILE *fptr;

    fptr = fopen("output.dat","w");
    if (fptr == NULL) {
        printf("Error \n");
        exit(-1);
    }
    fprintf(fptr, "%d", x);
    fclose(fptr);
}

void p2(){
    unsigned int x = 19653;
    FILE *fptr;

    fptr = fopen("output.dat","wb");
    if (fptr == NULL) {
        printf("Error \n");
        exit(-1);
    }
    fwrite(&x, sizeof(x), 1, fptr);
    fclose(fptr);
}

int main(){
    p2();
    return(0);
}