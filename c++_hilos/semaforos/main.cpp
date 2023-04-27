#include <iostream>
#include <iomanip>
#include <unistd.h>
#include <pthread.h>
#include <random>

using namespace std;

const int NUM_POINTS = 1000000; // Número total de puntos a generar
int points_in_circle = 0; // Contador de puntos dentro del círculo
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER; // Mutex para actualizar points_in_circle en un entorno multiproceso

void* generate_points(void* arg) { // Función que genera puntos al azar y cuenta cuántos caen dentro del círculo
    int num_points = *(int*)arg; // Número de puntos que debe generar este hilo

    random_device rd; // Generador de números aleatorios
    mt19937 gen(rd()); // Inicialización del generador con una semilla aleatoria
    uniform_real_distribution<double> dis(-1.0, 1.0); // Distribución uniforme en el rango [-1.0, 1.0]

    int local_points_in_circle = 0; // Contador de puntos dentro del círculo generado por este hilo
    for (int i = 0; i < num_points; ++i) { // Genera num_points puntos al azar
        double x = dis(gen); // Coordenada x del punto
        double y = dis(gen); // Coordenada y del punto
        if (x * x + y * y <= 1.0) { // Si el punto está dentro del círculo
            ++local_points_in_circle; // Incrementa el contador local
        }
    }

    pthread_mutex_lock(&mutex); // Bloquea el mutex para actualizar points_in_circle de manera segura
    points_in_circle += local_points_in_circle; // Suma el contador local al global
    pthread_mutex_unlock(&mutex); // Desbloquea el mutex

    pthread_exit(NULL); // Termina el hilo
}

int main() {
    int num_threads = 4; // Número de hilos a crear
    int points_per_thread = NUM_POINTS / num_threads; // Número de puntos que debe generar cada hilo

    pthread_t threads[num_threads]; // Arreglo de hilos
    int thread_args[num_threads]; // Arreglo de argumentos para cada hilo
    for (int i = 0; i < num_threads; ++i) { // Crea num_threads hilos
        thread_args[i] = points_per_thread; // Asigna el número de puntos a generar a este hilo
        int result = pthread_create(&threads[i], NULL, generate_points, &thread_args[i]); // Crea el hilo y le pasa thread_args[i] como argumento
        if (result != 0) { // Si hay un error al crear el hilo
            cerr << "Error creating thread " << i << endl; // Imprime un mensaje de error
            return 1; // Termina el programa con un código de error
        }
    }

    for (int i = 0; i < num_threads; ++i) { // Espera a que todos los hilos terminen
        pthread_join(threads[i], NULL);
    }

    double pi_estimate = 4.0 * points_in_circle / NUM_POINTS; // Calcula la estimación de pi
    cout << setprecision(10) << pi_estimate << endl; // Imprime la estimación de pi con 10 decimales de precisión

    return 0; // Termina el programa con éxito
}