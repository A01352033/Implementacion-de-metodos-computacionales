#lang racket
;;Manuel Villalpando Linares A01352033

;; 1. Farenheit a celcius. 
(define fahrenheit-to-celsius
  (lambda (f)
    (/ (* 5 (- f 32)) 9)))

;; 2. Detector de signo
(define sign
  (lambda (n)
    (cond ((positive? n) 1)
          ((negative? n) -1)
          (else 0))))

;; 3. Raices de 3 numeros
(define roots
  (lambda (a b c)
    (let ((discriminant (- (* b b) (* 4 a c))))
      (if (< discriminant 0)
          "No real roots"
          (/ (+ (- b) (sqrt discriminant)) (* 2 a))))))

;; 4. Calcular el BMI
(define BMI
  (lambda (h w)
    (let ((bmi (/ w (* h h))))
      (cond ((< bmi 20) "Underweight")
            ((and (<= 20 bmi) (< bmi 25)) "normal")
            ((and (<= 25 bmi) (< bmi 30)) "obese1")
            ((and (<= 30 bmi) (< bmi 40)) "obese2")
            ((<= bmi 40) "Overweight")))))

;; 5. Factorial de un numero
(define factorial
  (lambda (n)
    (cond
      ((<= n 0)1)
      [else(* n (factorial (- n 1)))])))

;; 6. Duplicar lista
(define duplicate
  (lambda (lst)
    (cond
      ((null? lst) '())
      [else(cons (car lst) (cons (car lst) (duplicate (cdr lst))))])))

;; 7. Pow
(define pow
  (lambda (a b)
    (cond
      ((= b 0) 1)
      [else(* a (pow a (- b 1)))])))

;; 8. Serie Fibonacci
(define fib
  (lambda (n)
    (cond
      ((<= n 1) n)
      (else (+ (fib (- n 1)) (fib (- n 2)))))))

;; 9. Enlistar elementos superiores
(define enlist
  (lambda (lst)
    (cond
      ((null? lst) '())
      (else (map (lambda (x) (list x)) lst)))))

;; 10. Cadenero de "Solo numeros positivos"
(define positives
  (lambda (lst)
    (cond
      ((null? lst) '())
      ((> (car lst) 0) (cons (car lst) (positives (cdr lst))))
      (else (positives (cdr lst))))))

;; 11. Sumar numeros dentro de la lista
(define add-list
  (lambda (lst)
    (cond
      ((null? lst) 0)
      (else (+ (car lst) (add-list (cdr lst)))))))

;; 12. Multiple swap en una lista
(define invert-pairs
  (lambda (lst)
    (map (lambda (pair) (list (cadr pair) (car pair))) lst)))

;; 13. Identifica si hay numeros dentro de la lista
(define list-of-symbols
  (lambda (lst)
    (cond
      ((null? lst) #t)
      ((symbol? (car lst)) (list-of-symbols (cdr lst)))
      (else #f))))

;; 14. Swapper
(define swapper
  (lambda (a b lst)
    (map (lambda (x) (if (eqv? x a) b (if (eqv? x b) a x))) lst)))

;; 16. Promedio de lista
(define average
  (lambda (lst)
    (cond
      ((null? lst) 0)
      [else(/ (apply + lst) (length lst))])))

;; 17. Desviacion estandar
(define (standard-deviation lst)
  (let ((n (length lst))
        (mean (/ (apply + lst) (length lst))))
    (cond
      ((null? lst) 0)
      [else(sqrt (/ (apply + (map (lambda (x) (expt (- x mean) 2)) lst)) n))])))

;; 18. Lista que replica valores
(define (replic n lst)
  (cond
    ((= n 0) '())
    [else(append (map (lambda (x) (make-list n x)) lst))]))