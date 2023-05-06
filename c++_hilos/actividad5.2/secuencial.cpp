#include <iostream>
#include <cmath>
#include <ctime>

bool verificarPrimo(int numero) {
    if (numero < 2) {
        return false;
    }

    int raiz = static_cast<int>(std::sqrt(numero));
    for (int indice = 2; indice <= raiz; ++indice) {
        if (numero % indice == 0) {
            return false;
        }
    }

    return true;
}

int main() {
    const int limiteNumeros = 5000000;
    long long acumulador = 0;
    std::clock_t tiempoInicio = std::clock();

    for (int contador = 2; contador < limiteNumeros; ++contador) {
        if (verificarPrimo(contador)) {
            acumulador += contador;
        }
    }

    std::clock_t tiempoFinal = std::clock();
    double duracion = static_cast<double>(tiempoFinal - tiempoInicio) / CLOCKS_PER_SEC;

    std::cout << "Suma de primos: " << acumulador << std::endl;
    std::cout << "Tiempo secuencial: " << duracion << " segundos" << std::endl;

    return 0;
}
