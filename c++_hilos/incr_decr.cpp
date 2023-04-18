#include <iostream>
#include <iomanip>
#include <pthread.h>
#include "utils.h"

using namespace std;

int count = 0;

void* decrement(void* param) {
  int i;
  for (i = 0; i < 10; i++) {
    cout << "before count = " << count << endl;
    count --;
    cout << "after count = " << count << endl;
  }
  pthread_exit(0);
}

void* increment(void* param) {
  int i;
  for (i = 0; i < 10; i++) {
    cout << "before count = " << count << endl;
    count ++;
    cout << "after count = " << count << endl;
  }
  pthread_exit(0);
}

int main(int argc, char* argv[]) {
  pthread_t tids[2];

  pthread_create(&tids[0], NULL, decrement, NULL);
  pthread_create(&tids[1], NULL, increment, NULL);

  pthread_join(tids[0], NULL);
  pthread_join(tids[1], NULL);

  cout << "count = " << count << endl;
  return 0;
}