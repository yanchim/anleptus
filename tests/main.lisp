(defpackage liansp/tests/main
  (:use :cl :liansp :rove))

(in-package :liansp/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :liansp)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
