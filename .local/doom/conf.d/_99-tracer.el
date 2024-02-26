;;; conf.d/_99-tracer.el -*- lexical-binding: t; -*-

;; (compile-goto-error)
;;;###autoload
(defun -tracer (func &rest args)
  (apply func args)
  (message ">>>>>>\n%S\n%s\n<<<<<<\n" func args))

;;;###autoload
(defmacro -add-tracer (FUNC)
  `(advice-add (quote ,FUNC) :around #'-tracer))

;;;###autoload
(defmacro -remove-tracer (FUNC)
  `(advice-remove (quote ,FUNC) #'-tracer))

(advice-add 'compile-goto-error :around #'-tracer)

;; (advice-remove 'compile-goto-error #'-compile-goto-error:trace)
