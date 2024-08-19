(defsystem "liansp"
  :version "0.0.1"
  :author "yanchim"
  :license ""
  :depends-on ("alexandria" "clack" "com.inuoe.jzon" "ningle")
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "liansp/tests"))))

(defsystem "liansp/tests"
  :author ""
  :license ""
  :depends-on ("liansp"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for liansp"
  :perform (test-op (op c) (symbol-call :rove :run c)))
