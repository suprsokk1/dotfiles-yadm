;;; $DOOMDIR/conf.d/_02-on-fucus-change-hook.el -*- lexical-binding: t; -*-
(require 'rx)

;;;###autoload
(defun -on-focus-change (func &rest args)
  ;; (message "-on-focus-change-hook:\n %S\n%S" args)
  (apply func args))

(advice-add 'after-focus-change-function
            :around #'-on-focus-change)

;;;###autoload
(defun -on-focus-change:advice (func &rest args)
  (message "-on-focus-change:advice:\n %S\n%S" func args))

(advice-add '-on-focus-change
            :around #'-on-focus-change-hook:advice)

;; (run-hooks )

;; (advice-remove 'after-focus-change-function #'-on-focus-change-hook)

;;;###autoload
;; (defmacro -- (DECR)
;;   `(- ,DECR 1)

;;   )

;; (let ((foo 10))
;;   (while (-- foo))
;;   )

;; (defmacro -repeat (REPEAT &rest WHAT)
;;   `(let ((rep ,REPEAT))
;;      ,@WHAT
;;      (while rep
;;        (setq-local rep (- rep 1)))
;;      )
;;   )

;; (-repeat 10 (princ (rx ?=)))

;; (add-hook 'focus-in-hook)
;; (advice-add 'display- )

;; (apropos (rx "columns") )
;; (repeat )
;; (with-output-to-string
;;   (princ (mapc
;;           (lambda (x)
;;             (pop x)
;;             (eq 'integer (type-of x))
;;             )
;;           (buffer-local-variables))))
