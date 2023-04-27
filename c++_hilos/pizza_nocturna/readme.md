A01334318 Erik Cabrera
A01352033 Manuel Villalpando

El problema consiste en sincronizar los hilos de los estudiantes y el hilo de entrega de pizza, asegurándose de que ningún estudiante tome un trozo de pizza que ya ha sido tomado por otro estudiante, y de que sólo un estudiante llame a la pizzería a la vez. Si un estudiante descubre que la pizza se ha acabado, el estudiante se va a dormir hasta que llegue otra pizza. El primer estudiante que descubre que el grupo no tiene pizza llama a la pizzería “All Night Long” para pedir otra pizza antes de irse a dormir.

Para resolver este problema, se pueden utilizar semáforos o mutexes. En mi solución, utilicé la librería semaphore para crear dos semáforos: uno para asegurarme de que sólo un estudiante tome un trozo de pizza a la vez, y otro para asegurarme de que sólo un estudiante llame a la pizzería a la vez. La función sem_wait se utiliza para tomar un semáforo, mientras que la función sem_post se utiliza para liberarlo.

El programa crea N hilos para los estudiantes y un hilo para la pizzería. Cada hilo de estudiante ejecuta la función eat_pizza, que utiliza el semáforo mutex para controlar el acceso a la pizza. Si un estudiante encuentra que no hay pizza, llama a la pizzería y espera a que llegue la pizza utilizando el semáforo pizzeria. Cuando llega la pizza, el hilo de la pizzería libera el semáforo mutex para notificar a los estudiantes que hay pizza disponible.

En resumen, se utiliza la sincronización mediante semáforos para asegurarse de que sólo un hilo acceda a los recursos compartidos a la vez, evitando condiciones de carrera e interbloqueos. Esto permite que los estudiantes coman pizza sin problemas y que la pizzería entregue pizza cuando sea necesario, sin que se presenten problemas de concurrencia.