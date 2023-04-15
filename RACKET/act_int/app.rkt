(define csharp-content (file->string "archivo.cs"))
(define css-styles
  (string-append
   "<style>"
   "pre { font-family: monospace; }"
   ".keyword { color: blue; }"
   ".string { color: green; }"
   ".comment { color: gray; font-style: italic; }"
   "</style>"))
   
(require syntax-coloring)

(define (highlight-csharp-code csharp-content)
  (define keyword-regex (regexp (regexp-opt '("abstract" "as" "base" "bool" "break" "byte" "case" "catch" "char" 
  "checked" "class" "const" "continue" "decimal" "default" "delegate" "do" "double" "else" "enum" "event" "explicit" 
  "extern" "false" "finally" "fixed" "float" "for" "foreach" "goto" "if" "implicit" "in" "int" "interface" "internal" 
  "is" "lock" "long" "namespace" "new" "null" "object" "operator" "out" "override" "params" "private" "protected" "public" 
  "readonly" "ref" "return" "sbyte" "sealed" "short" "sizeof" "stackalloc" "static" "string" "struct" "switch" "this" 
  "throw" "true" "try" "typeof" "uint" "ulong" "unchecked" "unsafe" "ushort" "using" "using static" "virtual" "void" 
  "volatile" "while")) #:whole-word? #t))
  (define string-regex (regexp "\"[^\"]*\""))
  (define comment-regex (regexp "//[^\n]*\n|/\\*[^\*]*\\*/"))
  (define csharp-rules (list (list keyword-regex 'keyword) (list string-regex 'string) (list comment-regex 'comment)))
  (syntax-color csharp-content csharp-rules))

(define highlighted-code (highlight-csharp-code csharp-content))
(define html-output (string-append css-styles highlighted-code))
(display html-output)