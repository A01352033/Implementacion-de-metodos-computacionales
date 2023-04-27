#include <iostream>
#include <pthread.h>
#include <unistd.h>
#include <vector>

// Variables globales
const int NUM_ESTUDIANTES = 5;  // Número de estudiantes
const int S = 8;                // Número de rebanadas de pizza
int rebanadas_disponibles = S;  // Rebanadas disponibles inicialmente
bool pizza_pedido = false;      // Indica si se ha pedido una pizza

// Mutex y variables de condición para la sincronización
pthread_mutex_t mutex_pizza = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond_pizza = PTHREAD_COND_INITIALIZER;
pthread_cond_t cond_entrega = PTHREAD_COND_INITIALIZER;

// Función para el hilo de cada estudiante
void *funcion_estudiante(void *arg) {
    int id = *(int *)arg;

    while (true) {
        pthread_mutex_lock(&mutex_pizza);  // Bloquear el mutex

        // Si no hay rebanadas y no se ha pedido pizza, pedir una
        if (rebanadas_disponibles == 0 && !pizza_pedido) {
            pizza_pedido = true;
            pthread_cond_signal(&cond_entrega);
            std::cout << "Estudiante " << id << " llama a la pizzería." << std::endl;
        }

        // Esperar a que haya rebanadas disponibles
        while (rebanadas_disponibles == 0) {
            pthread_cond_wait(&cond_pizza, &mutex_pizza);
        }

        // Tomar una rebanada de pizza y mostrar el mensaje
        rebanadas_disponibles--;
        std::cout << "Estudiante " << id << " toma una rebanada de pizza. Quedan " << rebanadas_disponibles << " rebanadas." << std::endl;

        pthread_mutex_unlock(&mutex_pizza);  // Desbloquear el mutex

        sleep(1);  // Estudiar y comer la pizza
    }

    return nullptr;
}

// Función para el hilo de la pizzería
void *funcion_pizzeria(void *arg) {
    while (true) {
        pthread_mutex_lock(&mutex_pizza);  // Bloquear el mutex

        // Esperar a que se pida una pizza
        if (!pizza_pedido) {
            pthread_cond_wait(&cond_entrega, &mutex_pizza);
        }

        sleep(2);  // Tiempo para entregar la pizza

        // Entregar la pizza y mostrar el mensaje
        rebanadas_disponibles = S;
        pizza_pedido = false;
        std::cout << "Pizza entregada. Hay " << S << " rebanadas disponibles." << std::endl;

        // Notificar a los estudiantes que hay rebanadas disponibles
        pthread_cond_broadcast(&cond_pizza);
        pthread_mutex_unlock(&mutex_pizza);  // Desbloquear el mutex
    }

    return nullptr;
}

int main() {
    // Crear hilos para estudiantes y pizzería
    std::vector<pthread_t> estudiantes(NUM_ESTUDIANTES);
    pthread_t hilo_pizzeria;
    pthread_create(&hilo_pizzeria, nullptr, funcion_pizzeria, nullptr);

    // Crear hilos para cada estudiante y asignarles un identificador
    int ids[NUM_ESTUDIANTES];
    for (int i = 0; i < NUM_ESTUDIANTES; i++) {
                ids[i] = i + 1;
        pthread_create(&estudiantes[i], nullptr, funcion_estudiante, &ids[i]);
    }

    // Esperar a que finalicen los hilos de los estudiantes (no ocurrirá en este caso)
    for (int i = 0; i < NUM_ESTUDIANTES; i++) {
        pthread_join(estudiantes[i], nullptr);
    }

    // Esperar a que finalice el hilo de la pizzería (no ocurrirá en este caso)
    pthread_join(hilo_pizzeria, nullptr);

    // Destruir el mutex y las variables de condición
    pthread_mutex_destroy(&mutex_pizza);
    pthread_cond_destroy(&cond_pizza);
    pthread_cond_destroy(&cond_entrega);

    return 0;
}

