#include <iostream>
#include <iomanip>
#include <pthread.h>

using namespace std;

const int CELLS = 10;


pthread_cond_t spaces = PTHREAD_COND_INITIALIZER;
pthread_cond_t items = PTHREAD_COND_INITIALIZER;
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

typedef struct {
    int data[CELLS];
    int front, rear, count;
}Queue;

void put(Queue &q, int value)
{
    data[q.rear] = value;
    q.rear = (q.rear + 1) % CELLS;
    q.count++;
}

int get(Queue &q)
{
    int result = data[q.front];
    q.front = (q.front + 1) % CELLS;
    q.count--;
}