;;; conf.d/_00-line-numbers.el -*- lexical-binding: t; -*-
(setq-default
 global-display-line-numbers-mode -1
 display-line-numbers-type 'absolute
 display-line-numbers-width     1
 )

(setq-hook! (quote emacs-lisp-mode-hook)
  display-line-numbers-mode 1)

(setq-hook! (quote org-mode-hook)
  display-line-numbers-mode -1)

;; (after! display-line-numbers

;;   )
