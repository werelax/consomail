(load #P"/home/elias/quicklisp/setup.lisp")
(ql:quickload "cl-smtp")

(compile-file "consomail")
(load "consomail")

(save-lisp-and-die "consomail.core")
