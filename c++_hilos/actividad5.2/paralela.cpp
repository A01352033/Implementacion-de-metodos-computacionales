#include <iostream>
#include <cmath>
#include <ctime>
#include <pthread.h>
#include <vector>

struct InfoHilo {
    int id;
    int comienzo;
    int termino;
    long long suma_resultante;
};

bool esPrimo(const int num) {
    if (num < 2) return false;
    for (int i = 2, limite = static_cast<int>(std::sqrt(num)); i <= limite; ++i) {
        if (num % i == 0) return false;
    }
    return true;
}

void calcularSumaPrimos(int inicio, int fin, long long& suma) {
    suma = 0;
    for (int i = inicio; i < fin; ++i) {
        if (esPrimo(i)) {
            suma += i;
        }
    }
}

void* invocarCalculoSumaPrimos(void* argumentos) {
    InfoHilo* datos_hilo = static_cast<InfoHilo*>(argumentos);
    calcularSumaPrimos(datos_hilo->comienzo, datos_hilo->termino, datos_hilo->suma_resultante);
    return nullptr;
}

int main() {
    const int tope = 5000000;
    const int num_hilos = 4;
    std::vector<InfoHilo> hilos_info(num_hilos);
    std::vector<pthread_t> hilos(num_hilos);

    std::clock_t inicio_paralelo = std::clock();

    int rango = tope / num_hilos;
    for (int idx = 0; idx < num_hilos; ++idx) {
        hilos_info[idx].id = idx;
        hilos_info[idx].comienzo = idx * rango + 2;
        hilos_info[idx].termino = (idx + 1) * rango + 2;
        pthread_create(&hilos[idx], nullptr, invocarCalculoSumaPrimos, &hilos_info[idx]);
    }

    long long suma_paralela = 0;
    for (int idx = 0; idx < num_hilos; ++idx) {
        pthread_join(hilos[idx], nullptr);
        suma_paralela += hilos_info[idx].suma_resultante;
    }

    std::clock_t fin_paralelo = std::clock();
    double duracion_paralela = static_cast<double>(fin_paralelo - inicio_paralelo) / CLOCKS_PER_SEC;

    std::cout << "Suma de primos: " << suma_paralela << std::endl;
    std::cout << "Tiempo paralelo: " << duracion_paralela << " segundos" << std::endl;

    return 0;
}
