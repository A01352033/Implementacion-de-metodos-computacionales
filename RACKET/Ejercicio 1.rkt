#lang racket

;;Ejercicio 1

;; Attendees: number -> number
(define attendees
 (lambda (ticket-price)
   (+ 120
      (* (/ 15 0.10) (- 5.00 ticket-price)))))
;;(Attendees 4.90) -> 134.99

;;Revenue: number -> number
(define revenue
  (lambda (ticket-price)
    (* (attendees ticket-price) ticket-price)))
;;(Eevenue 4.90) -> 661.49

;;Cost: number -> number
(define cost
  (lambda (ticket-price)
    (+ 180
       (* 0.04 (attendees ticket-price)))))
;;(Cost 4.90) -> 185.40

;;Best-ticket-price: number number -> number
(define best-ticket-price
  (lambda (ticket-price best)
    (cond
      [(<= ticket-price 0.0) 'not_found]
      [(> (- (revenue ticket-price)
             (cost ticket-price)) best)
       (best-ticket-price (- ticket-price 0.10)
                          (- (revenue ticket-price)
                             (cost ticket-price)))]
      [else ticket-price])))

(define list '(1 2 3 4 5 6 7 8 9 10))

;;Size list-of-number -> number
(define size
  (lambda (list)
    (cond
      [(empty? list)0]
      [else (+ 1 (size (cdr list)))])))

;;Size-tall: list-of-number -> number
(define size-tall
  (lambda (list acc)
    (cond
      [(empty? list) acc]
      [else (size-tall (rest list) (+ acc 1))])))

;;Sum-list-head: list-of-number -> number
(define sum-list-head
  (lambda (list)
    (cond
      [(empty? list) 0]
      [else (+ (car list) (sum-list-head (cdr list)))])))

;;Sum-list-tall: list-of-number -> number
(define sum-list-tall
  (lambda (list acc)
    (cond
      [(empty? list) acc]
      [else (sum-list-tall (cdr list)(+ acc (car list)))])))

;;Average: list-of-number -> number
(define average
  (lambda (list)
    (/ (sum-list-tall list 0)
       (size-tall list 0))))

;;Maximum-tall: list-of-number -> number
(define maximum-tall
  (lambda (list best)
    (cond
      [(empty? list) best]
      [(> (car list) best) (maximum-tall (cdr list)
                                        (car list))]
       [else (maximum-tall (cdr list) best)])))

;;Maximum-head: list-of-number -> number
(define maximum-head
  (lambda (list)
    (cond
      [(empty? list)0]
      [(> (car list) (maximum-head (cdr list))) (car list)]
      [else (maximum-head (cdr list))])))

;;List-of-number: number number -> list-of-numbers
(define list-of-numbers
  (lambda (start end)
    (cond
      [(> start end) (list-of-numbers end start)]
      [(eq? start end) (const start '())]
      [else (cons start
                  (list-of-numbers (+ start 1) end))])))

;;Evens: list-of-numbers -> list-of-numbers
;;(define evens
;;  (lambda (l


;;More than: number list-of-numbers -> list-of-numbers
(define more-than
  (lambda (n list)
    (cond
      [(empty? list) '()]
      [(> (car list) n) (cons (car list)
                              (more-than n (cdr list)))]
      [else (more-than n (cdr list))])))

;;Less than: number list-of-numbers -> list-of-numbers
(define less-than
  (lambda (n list)
    (cond
      [(empty? list) '()]
      [(> (car list) n) (cons (car list)
                              (less-than n (cdr list)))]
      [else (less-than n (cdr list))])))


;;Quick-sort: list-of-number -> list-of-number
(define quick-sort
  (lambda (list)
    (cond
      [(empty? list) '()]