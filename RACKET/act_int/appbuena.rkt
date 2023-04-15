;;Resaltador de sintaxis para C#

#lang racket

(require 2htdp/batch-io)
(define keyword
  '("abstract" "as"
               "base"
               "bool"
               "break"
               "byte"
               "case"
               "catch"
               "char"
               "checked"
               "class"
               "const"
               "continue"
               "decimal"
               "default"
               "delegate"
               "do"
               "double"
               "else"
               "enum"
               "event"
               "explicit"
               "extern"
               "false"
               "finally"
               "fixed"
               "float"
               "for"
               "foreach"
               "goto"
               "if"
               "implicit"
               "in"
               "int"
               "interface"
               "internal"
               "is"
               "lock"
               "long"
               "namespace"
               "new"
               "null"
               "object"
               "operator"
               "out"
               "override"
               "params"
               "private"
               "protected"
               "public"
               "readonly"
               "ref"
               "return"
               "sbyte"
               "sealed"
               "short"
               "sizeof"
               "stackalloc"
               "static"
               "string"
               "struct"
               "switch"
               "this"
               "throw"
               "true"
               "try"
               "typeof"
               "uint"
               "ulong"
               "unchecked"
               "unsafe"
               "ushort"
               "using"
               "virtual"
               "void"
               "volatile"
               "while"))

(define system '("system" "Console" "Program"))

(define operator
  '("+" "-"
        "*"
        "/"
        "%"
        "&"
        "|"
        "^"
        "!"
        "~"
        "="
        "<"
        ">"
        "+="
        "-="
        "*="
        "/="
        "%="
        "&="
        "|="
        "^="
        "<<"
        ">>"
        ">>>"
        "<<="
        ">>="
        ">>>="
        "=="
        "!="
        "<="
        ">="
        "&&"
        "||"
        "++"
        "--"
        "?"
        "??"))

(define separator '(";" "," "." "(" ")" "[" "]" "{" "}" "<" ">" ":" "::" "..." "=>" "??"))

(define number (regexp "(\\b[0-9]+(\\.[0-9]*)?\\b)"))

(define string (regexp "(\"(\\\\.|[^\\\\\"])*\")"))

(define comment (regexp "(//.*|/\\*.*\\*/|/\\*.*|.*\\*/)"))

(define identifier (regexp "[a-zA-Z_][a-zA-Z0-9_]*$"))

(define (replace-comment text)
  (string-append "<span class=\"comment\">" text "</span>"))

(define (categorize-token text)
  (let ((tag (or (keyword-tag text)
                 (operator-tag text)
                 (separator-tag text)
                 (system-tag text)
                 (number-tag text)
                 (string-tag text)
                 (comment-tag text)
                 (identifier-tag text))))
    (if tag
        (string-append "<span class=\"" tag "\">" text "</span>")
        text)))

(define (keyword-tag text)
  (if (member text keyword)
      "keywords"
      #f))

(define (operator-tag text)
  (if (member text operator)
      "operators"
      #f))

(define (separator-tag text)
  (if (member text separator)
      "separator"
      #f))

(define (system-tag text)
  (if (member text system)
      "system"
      #f))

(define (number-tag text)
  (if (regexp-match number text)
      "number"
      #f))

(define (string-tag text)
  (if (regexp-match string text)
      "strings"
      #f))

(define (comment-tag text)
  (if (regexp-match comment text)
      "comment"
      #f))

(define (identifier-tag text)
  (if (regexp-match identifier text)
      "identifier"
      #f))


(define (replace-all-tokens text open-block-comment)
  (define word '())
  (define list-line '())
  (define open-quotes #f)
  (define possible-line-comment #f)
  (define open-line-comment #f)

  (define ch (regexp-split #px"" text))

  (for/last ([char ch])
    (when (and (eq? char (last ch)) (or open-line-comment open-block-comment))
      (set! list-line (append list-line (list word))))

    (cond
      [open-block-comment (set! word (append word (list char)))]
      [(regexp-match #rx"#" char) (set! word (append word (list char)))]
      [(regexp-match? #rx"[a-zA-Z0-9_]" char) (set! word (append word (list char)))]

      [(regexp-match #px"/" char)
       (cond
         [possible-line-comment
          ((lambda ()
             (set! possible-line-comment #f)
             (set! open-line-comment #t)
             (set! word (append word (list char)))))]
         [else
          ((lambda ()
             (set! possible-line-comment #t)
             (set! word (append word (list char)))))])]

      [open-line-comment (set! word (append word (list char)))]

      [(regexp-match? #px"\"" char)
       ((lambda ()
          (set! open-quotes (not open-quotes))
          (set! word (append word (list char)))))]

      [open-quotes (set! word (append word (list char)))]

      [(member char operator)
       ((lambda ()
          (set! list-line (append list-line (list word)))
          (set! word '())
          (set! word (append word (list char)))
          (set! list-line (append list-line (list word)))
          (set! word '())))]

      [(member char separator)
       ((lambda ()
          (set! list-line (append list-line (list word)))
          (set! word '())
          (set! word (append word (list char)))
          (set! list-line (append list-line (list word)))
          (set! word '())))]

      [else
       ((lambda ()
          (set! list-line (append list-line (list word)))
          (set! word '())))]))

  (define (categorize-tokens tokens)
  (define (loop tokens open-block-comment result)
    (cond
      [(null? tokens) (reverse result)]
      [(and (string=? (car tokens) "/*") (not open-block-comment))
       (loop (cdr tokens) #t (cons (categorize-token (car tokens)) result))]
      [(and (string=? (car tokens) "*/") open-block-comment)
       (loop (cdr tokens) #f (cons (categorize-token (car tokens)) result))]
      [open-block-comment
       (loop (cdr tokens) #t (cons (replace-comment (car tokens)) result))]
      [(string=? (car tokens) "//")
       (loop (cdr tokens) #f (cons (replace-comment (car tokens)) result))]
      [else
       (loop (cdr tokens) #f (cons (categorize-token (car tokens)) result))]))
  (loop tokens #f '()))

(define tokens (map (λ (x) (string-join x "")) list-line))


  (categorize-tokens tokens))

(define input-file "input.cs")

(define output-file "output.html")

(define html-header
  "<!DOCTYPE html>
<html>
<head>
  <meta chet=\"utf-8\">
  <title>Actividad integradora</title>
  <link rel=\"stylesheet\" href=\"styles.css\">
</head>
<body>
  <pre>")

(define html-footer "</pre>
</body>
</html>")

(define (Run input-file output-file)
  (define input-lines (file->lines input-file))
  (define output-port (open-output-file output-file))
  (write-string html-header output-port)

  (define open-block-comment #f)

  (for-each (lambda (text)
              (when (not open-block-comment)
                (set! open-block-comment (regexp-match? #px"/\\*" text)))

              (define tokens (replace-all-tokens text open-block-comment))
              (define formatted-line (string-join tokens " "))

              (when open-block-comment
                (set! open-block-comment (not (regexp-match? #px"\\*/" text))))

              (write-string (string-append "<pre>" formatted-line "</pre>") output-port))
            input-lines)

  (write-string html-footer output-port)
  (close-output-port output-port))

(time (Run input-file output-file))
