;;; =============================================================================
;;
;;  Programa:  Tarea 2.2
;;  Autor:     Dante David Pérez Pérez A01709226
;;              Manuel Villalpando 
;;  Fecha:     18/03/2023
;;; =============================================================================


#lang racket

;;; 1

(define (insert n lst)
    (cond ((null? lst) (list n))
        ((< n (car lst)) (cons n lst))
        (else (cons (car lst) (insert n (cdr lst))))))

(insert 4 '(5 6 7 8))
(insert 5 '(1 3 6 7 9 16))

;;; 2
(define (insert-sort lst)
    (define (insert n lst)
        (cond ((null? lst) (list n))
            ((< n (car lst)) (cons n lst))
            (else (cons (car lst) (insert n (cdr lst))))))
            
            (if (null? lst)
                '()
                (insert (car lst) (insert-sort (cdr lst)))))


(insert-sort '(4 3 6 8 3 0 9 1 7))

;;; 3
(define (rotate-left n lst)
    (let ((n (modulo n (length lst))))
        (if (zero? n)
            lst
            (append (drop lst n) (take lst n)))))

(rotate-left 1 '(a b c d e f g))

(rotate-left -1 '(a b c d e f g))

;;; 4

(define (prime-factors n)
    (let loop ((n n) (f 2) (factors '()))
        (cond ((<= n 1) factors)
            ((zero? (modulo n f)) (loop (/ n f) f (cons f factors)))
            (else (loop n (+ f 1) factors)))))

(prime-factors 96)

;;; 5
(define (gcd a b)
    (let loop ((a a) (b b))
        (if (= b 0)
            a
            (loop b (modulo a b)))))

(gcd 6307 1995)

;;; 6
(define (deep-reverse lst)
    (let deep-reverse-helper ((lst lst) (result '()))
        (cond ((null? lst) result)
            ((list? (car lst)) (deep-reverse-helper (cdr lst) (cons (deep-reverse (car lst)) result)))
            (else (deep-reverse-helper (cdr lst) (cons (car lst) result))))))

(deep-reverse '(a (b (c (d (e (f (g (h i j)))))))))

;;; 7
(define (insert-anywhere x lst)
    (cond ((null? lst) (list (list x)))
            ((cons? lst)
                (append (list (cons x lst))
                    (map (lambda (l) (cons (car lst) l))
                    (insert-anywhere x (cdr lst)))))))

(insert-anywhere 'x '(1 2 3 4 5 6 7 8 9 10))


;;; 8
(define (pack lst)
  (if (null? lst)
      '()
      (let ((first (car lst)))
        (let ((packed (pack (cdr lst))))
          (if (null? packed)
              (list (list first))
              (if (eq? first (caar packed))
                  (cons (cons first (car packed)) (cdr packed))
                  (cons (list first) packed)))))))



(pack '(a a a a b c c a a d e e e e))
(pack '())

;;; 9
(define (compress lst)
  (if (null? lst)
      '()
      (let ((first (car lst)))
        (let ((compressed (compress (cdr lst))))
          (if (null? compressed)
              (list first)
              (if (eq? first (car compressed))
                  compressed
                  (cons first compressed)))))))

(compress '(a a a a b c c a a d e e e e))

;;; 10
;;; La funci ́on encode toma una lista lst como entrada. Los elementos consecutivos en lst se codifican en listas
;;; de la forma: (n e), donde n es el n ́umero de ocurrencias del elemento e

(define (encode lst)
  (if (null? lst)
      '()
      (let ((first (car lst)))
        (let ((encoded (encode (cdr lst))))
          (if (null? encoded)
              (list (list 1 first))
              (if (eq? first (caar encoded))
                  (cons (list (+ 1 (car (car encoded))) first) (cdr encoded))
                  (cons (list 1 first) encoded)))))))

(encode '(a a a a b c c a a d e e e e))


;;; 11

(define (encode-modified lst)
  (define (make-run count element)
    (if (= count 1)
        element
        (list count element)))
  (define (encode-modified-aux lst current-count current-element result)
    (cond ((null? lst)
           (reverse (cons (make-run current-count current-element) result)))
          ((equal? (car lst) current-element)
           (encode-modified-aux (cdr lst) (add1 current-count) current-element result))
          (else
           (encode-modified-aux (cdr lst) 1 (car lst) (cons (make-run current-count current-element) result)))))
  (if (null? lst)
      '()
      (encode-modified-aux (cdr lst) 1 (car lst) '())))

(encode-modified '(a a a a b c c a a d e e e e))

;;; 12

(define decode
  (lambda (lst)
    (define (expand x)
      (if (list? x)
          (make-list (car x) (cadr x))
          (list x)))
    (apply append (map expand lst))))


(decode '((4 a) b (2 c) (2 a) d (4 e)))
(decode '((9 9)))


;;; 13

(define args-swap
  (lambda (f)
    (lambda (x y)
      (apply f (list y x)))))

((args-swap /) 8 2)
((args-swap cons) '(1 2 3) '(4 5 6))


;;; 14
(define (there-exists-one? pred lst)
  (= 1 (length (filter pred lst))))

(there-exists-one? positive? '(1 2 3 4 5 6 7 8 9 10))
(there-exists-one? negative? '(-1))
(there-exists-one? symbol? '(4 8 15 sixteen 23 42))

;;; 15

(define (linear-search lst x eq-fun)
  (let loop ((i 0) (lst lst))
    (cond ((null? lst) #f)
          ((eq-fun x (car lst)) i)
          (else (loop (+ i 1) (cdr lst)))))) 

(linear-search '(48 77 30 31 5 20 91 92 69 97 28 32 17 18 96) 5 =)
(linear-search '("red" "blue" "green" "black" "white") "black" string=?)


;;; 16

(define (deriv f h)
  (lambda (x)
    (/ (- (f (+ x h)) (f x))
       h)))

(define f (lambda (x) (* x x x)))
(define df (deriv f 0.001))
(define ddf (deriv df 0.001))
(define dddf (deriv ddf 0.001))
(df 5) ; returns 75.01500100002545
(ddf 5) ; returns 30.006000002913424
(dddf 5) ; returns 5.999993391014868


;;; 17

(define (newton f n)
  (define df (lambda (x) (/ (- (f (+ x 0.0001)) (f x)) 0.0001)))
  (define (newton-iter x i)
    (if (= i n)
        x
        (newton-iter (- x (/ (f x) (df x))) (+ i 1))))
  (newton-iter 0 0))


(newton (lambda (x) (- x 10)) 1)
(newton (lambda (x) (+ (* x x x) 1)) 50)
(newton (lambda (x) (+ (cos x) (* 0.5 x))) 5)

