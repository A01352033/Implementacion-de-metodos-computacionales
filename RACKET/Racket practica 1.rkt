#lang racket
;;Author: Pedro Perez
;;Session 1

(define a 5)

(define fnl
 (lambda (x)
   (+ x 5)))

(define fn2
  (lambda (x y)
    (+ x y)))

(define fn3
  (lambda (x)
    (lambda (y)
      (+ x y))))

;;Sum of squares: number number ->
(define sum-of-squares
  (lambda (x y)
    (+ (* x x)(* y y))))
;;(Sum of squares 1 2) => 3
;;(Sum of squres 1 2)

;;Area-of-disk: number -> number
(define area-of-disk
  (lambda(radius)
    (* 3.1415 radius radius)))
;;(Area-of-disk 10) => 314.15
;;(Area-of-disk 10)

;;Area-of-ring: number number => number
(define area-of-ring
  (lambda (outer inner)
    (- (area-of-disk outer)
       (area-of-disk inner))))

;;Wage: number number -> number
(define wage
  (lambda (payment hours)
    (* payment hours)))
;;(wage 12 2) -> 24
;;(wage 12 2)

;;tax: number number -> number
(define tax
  (lambda (wage rate)
    (* wage rate)))
;;(tax 100 0.15) -> 15
;;(tax 100 0.15)

;;netpay: number number number -> number
(define netpay
  (lambda (payment hours rate)
    (- (wage payment hours)
       (tax (wage payment hours) rate))))
;;(netpay 12 48 0.15) -> 488
(netpay 12 40 0.15)

;;Maximum number number -> number
(define maximum
  (lambda (a b)
    (cond
     [(a > b) a]
     [else b])))
;;The interest for <$500 is $20
;;The interest for <$2000 is $90
;;The interest for <$10,000 is $500

(define interest
  (lambda (amount)
    (cond
      [( < amount 500) 20]
      [( < amount 2000) 90]
      [( < amount 10000) 500])))

(define fibo
  (lambda (n)
    (cond
      [(= n 1) 1]
      [(= n 2) 1]
      [else (+ (fibo (- n 1))
               (fibo (- n 2)))])))
;;(fibo 7) -> 13

;;sum: number number -> number
(define sum
  (lambda (start end)
    (cond
      [(> start end) sum end start]
      [(= end start) start]
      [else(+ end (sum start (- end 1)))])))
      