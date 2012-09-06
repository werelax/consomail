;; #!/usr/bin/env sbcl --script

;; (load #P"/home/elias/quicklisp/setup.lisp")
;; (ql:quickload "cl-smtp")

(defpackage :consomail
  (:use :common-lisp)
  (:export :send-email))

(in-package :consomail)

; don't show the password when typing!

(defun disable-echo ()
  (sb-ext:run-program "/bin/stty" '("-echo") :input t :output t))

(defun enable-echo ()
  (sb-ext:run-program "/bin/stty" '("echo") :input t :output t))

(defun prompt (msg)
  (format t msg)
  (force-output)
  (read-line))

(defun pass-prompt ()
  (format t "password: ")
  (force-output)
  (disable-echo)
  (let ((pwd (read-line)))
    (enable-echo)
    pwd))

; email-sending thing

(defun send-email (to attachments)
  (let ((from "eliasagc@gmail.com")
        ;; (subject (prompt "Subject: "))
        ;; (body (prompt "Body: "))
        (subject "Here is the thing...")
        (body "Enjoy it and pay me in cash.")
        (passwd (pass-prompt)))
    (print attachments)
    (cl-smtp:send-email
      "smtp.gmail.com"
      from
      to
      subject
      body
      :authentication (list from passwd)
      :attachments attachments
      :ssl :tls)))

;; (send-email (cadr sb-ext:*posix-argv*)
;;            (cddr sb-ext:*posix-argv*))

;; (exit)
