(defsystem "lem-tests"
  :class :package-inferred-system
  :depends-on ("lem-tests/lisp-syntax/indent-test"
               "lem-tests/lisp-syntax/defstruct-to-defclass"
               "lem-tests/syntax-test"
               "lem-tests/buffer-list-test")
  :pathname "tests"
  :perform (test-op (o c)
                    (symbol-call :rove :run c)))

(asdf:register-system-packages "lem-lisp-syntax" '(:lem-lisp-syntax.defstruct-to-defclass))
