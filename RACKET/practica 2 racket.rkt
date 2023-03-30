(define addl
  (lambda (lst)
    (cond
      [(empty? lst) '()]
      [else (cons (+ (car lst) 1)
                  (addl (cdr lst)))])))

(define squares
  (lambda (lst)
    (cond
      [(empty? lst) '()]
      [else (cons (* (car lst) (car lst))
                 (addl (cdr lst)))])))

(define map-alt
  (lambda (fn lst)
    (cond
      [(empty? lst) '()]
      [else (cons (fn (car lst))
                  (map-alt fn (cdr lst)))])))

(define deep-list
  '((1 2 (3) (4 5 (6)) 7) 8 (9 (10))))

(define deep-sum-list
  (lambda (deep-lst)
    (cond
      [(empty? deep-lst) 0]
      [(list? (car deep-lst))
       (+ (deep-sum-list (car deep-lst))
          (deep-sum-list (cdr deep-lst)))]
      [else (+ (car deep-lst)
               (deep-sum-list (cdr deep-lst