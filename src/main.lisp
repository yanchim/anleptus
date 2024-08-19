(defpackage liansp
  (:use #:cl #:alexandria #:clack #:com.inuoe.jzon #:ningle)
  (:local-nicknames
   (#:jzon #:com.inuoe.jzon)
   (#:alex #:alexandria)))

(in-package #:liansp)

(defparameter *app* (make-instance 'ningle:app)
  "Ningle application")

(defparameter *clack-server* nil
  "Variable holding clack server for graceful shutdowns etc.")

(defvar *password-db*)

(with-open-file (in "../data/password.lisp")
  (with-standard-io-syntax
    (setf *password-db* (read in))))

(defun respond-json (content)
  (appendf (lack.response:response-headers ningle:*response*)
           '("Content-Type" "application/json"))
  (jzon:stringify content))

(setf (ningle:route *app* "/")
      ;; (respond-json '(:hello "world"))
      "hello, world"
      )

(defun subscribe-get (name mobilep cnp)
  (format t "name: ~S, mobile: ~S, cn: ~S ~%" name mobilep cnp)

  (let ((password (getf *password-db* (intern (string-upcase name) :keyword))))
    (prin1-to-string (list name password mobilep cnp))
    ;; (jzon:stringify *password-db*)
    ))

(setf (ningle:route *app* "/subscribe")
      #'(lambda (params)
          (let ((name (cdr (assoc "name" params :test #'string=)))
                ;; The following two params are boolean so we use `car' here.
                (mobile (car (assoc "mobile" params :test #'string=)))
                (cn (car (assoc "cn" params :test #'string=))))
            (subscribe-get name (string= "mobile" mobile) (string= "cn" cn)))))

(defun start-server ()
  (setf *clack-server* (clack:clackup *app* :port 5477)))

(defun stop-server ()
  (clack:stop *clack-server*)
  (setf *clack-server* nil))

#|
(start-server)
|#
