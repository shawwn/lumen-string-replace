#!/usr/bin/env lumen

(define passed 0)
(define failed 0)
(define tests ())

(define reader (require 'reader))
(define compiler (require 'compiler))
(require (target lua: "init" js: "index"))

(define-macro test (x msg)
  `(if (not ,x)
       (do (set failed (+ failed 1))
           (return ,msg))
     (inc passed)))

(define equal? (a b)
  (if (atom? a) (= a b)
    (= (str a) (str b))))

(define-macro test= (a b)
  (let-unique (x y)
    `(let (,x ,a ,y ,b)
       (test (equal? ,x ,y)
             (cat "failed: expected " (str ,x) ", was " (str ,y))))))

(define-macro define-test (name rest: body)
  `(add tests (list ',name (fn () ,@body))))

(define-global run ()
  (each ((name f)) tests
    (let result (f)
      (when (string? result)
        (print (cat " " name " " result)))))
  (print (cat " " passed " passed, " failed " failed")))

(define-test simple
  (test= "fzz" (string-replace "foo" "o" "z"))
  (test= "f" (string-replace "foo" "o" ""))
  (test= "" (string-replace "ooo" "o" "")))

(define-test count
  (test= "foobar" (string-replace "foobar" "o" "z" 0))
  (test= "fzobar" (string-replace "foobar" "o" "z" 1))
  (test= "fzzbar" (string-replace "foobar" "o" "z" 2))
  (test= "fzzbar" (string-replace "foobar" "o" "z" 3)))

(define-test pos
  (test= "fzzbar" (string-replace "foobar" "o" "z" nil 0))
  (test= "fzzbar" (string-replace "foobar" "o" "z" nil 1))
  (test= "fozbar" (string-replace "foobar" "o" "z" nil 2))
  (test= "foobar" (string-replace "foobar" "o" "z" nil 3)))

(run)
