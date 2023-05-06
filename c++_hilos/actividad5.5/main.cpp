#include <iostream>
#include <pthread.h>
#include <unistd.h>

using namespace std;

// Variables compartidas
int count = 0;
int direction = 0; // 0 = ninguna, 1 = Norte, 2 = Sur
pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;

void* ArriveBridge(void* arg) {
    int dir = *(int*)arg;
    
    while (true) {
        // Adquirir el mutex
        pthread_mutex_lock(&mtx);
        
        // Verificar si es seguro cruzar el puente en la dirección deseada
        if (count < 3 && (count == 0 || direction == dir)) {
            // Incrementar el contador de vehículos en el puente y establecer la dirección actual
            count++;
            direction = dir;
            
            // Liberar el mutex
            pthread_mutex_unlock(&mtx);
            
            // Cruzar el puente
            cout << "Vehículo en dirección " << dir << " cruzando el puente." << endl;
            sleep(1); // Simulación del cruce del puente
            
            // Salir del puente
            pthread_mutex_lock(&mtx);
            
            // Decrementar el contador de vehículos en el puente
            count--;
            
            // Verificar si no hay más vehículos en la misma dirección esperando para cruzar
            if (count == 0) {
                // Establecer la dirección actual en ninguna
                direction = 0;
                
                // Notificar a los vehículos en la otra dirección que pueden cruzar el puente
                pthread_mutex_unlock(&mtx);
                break;
            }
            
            // Liberar el mutex
            pthread_mutex_unlock(&mtx);
            break;
        }
        
        // Liberar el mutex y esperar
        pthread_mutex_unlock(&mtx);
        usleep(500);
    }
    
    return NULL;
}

void ExitBridge(int dir) {
    // Adquirir el mutex
    pthread_mutex_lock(&mtx);
    
    // Decrementar el contador de vehículos en el puente
    count--;
    
    // Verificar si no hay más vehículos en la misma dirección esperando para cruzar
    if (count == 0) {
        // Establecer la dirección actual en ninguna
        direction = 0;
        
        // Notificar a los vehículos en la otra dirección que pueden cruzar el puente
        pthread_mutex_unlock(&mtx);
        return;
    }
    
    // Liberar el mutex y notificar a los vehículos en la misma dirección que pueden cruzar el puente
    pthread_mutex_unlock(&mtx);
}

int main() {
    pthread_t t1, t2;
    int dir1 = 1, dir2 = 2;
    
    pthread_create(&t1, NULL, ArriveBridge, &dir1); // Vehículo en dirección Norte
    pthread_create(&t2, NULL, ArriveBridge, &dir2); // Vehículo en dirección Sur
    
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    
    return 0;
}
