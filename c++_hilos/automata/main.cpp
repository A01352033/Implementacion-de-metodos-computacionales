#define MAXEST 10
#define MAXSIM 2
#define NULO -1

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <conio.h>
#include <dos.h>

void pantalla();
void mensaje(int);
void Beep();

int main(){
    int est[MAXEST], sim[MAXSIM], estini, estfin[MAXEST], funtra[MAXSIM][MAXEST], cad[MAXEST];
    int i, j, lin, col, maxlin, maxcol, ap;
    char c;

    pantalla();

    // Inicializar variables

    i=j=0;
    while (i < MAXSIM){ // Funcion de trancision
        while (j < MAXEST){
            funtra[i][j] = NULO;
            j++;
        }
        j=0;
        i++;
    }
    i=0;
    while (i < MAXSIM) {
        sim[i] = NULO;
        i++;
    }
}