#lang racket
(define l1 (list 1 2 3 4 5 6 7 8 9))
(define l2 (list 'a 'b 'c 'd 'e 'f 'g))

(define reverse
  (lambda (lst)
    (cond
      [(empty? lst) '()]
      [else (append (reverse (cdr lst)) (lista (car lst)))])))

reverse l1
reverse l2

;;https://www.youtube.com/watch?v=SXUVY1FGcWk