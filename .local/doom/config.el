;;; config.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024 geir
;;
;; Author: geir <geir@fedora>
;; Maintainer: geir <geir@fedora>
;; Created: February 24, 2024
;; Modified: February 24, 2024
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/geir/config
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:


;; (quote (let ((ELC (file-expand-wildcards (concat (expand-file-name "conf.d" (dir!)) "/*.elc"))))
;;         (mapc #'load-file ELC)))

;; (load-file
;;  (nth 0 (file-expand-wildcards (concat (dir!! "conf.d") "/*refresh*.el"))))

(after! rainbow-delimiters
  ;; (add-hook! 'python-mode-hook (quote rainbow-delimiters-mode))
  (custom-set-faces
   '(rainbow-delimiters-depth-1-face ((t (:foreground "gray"))))))

(after! tramp
  (defun yadm ()
    (interactive)
    (magit-status "/yadm::"))

  (add-to-list (quote tramp-methods)
               (quote ("yadm"
                       (tramp-login-program "yadm")
                       (tramp-login-args (("enter")))
                       (tramp-login-env (("SHELL") ("/bin/sh")))
                       (tramp-remote-shell "/bin/sh")
                       (tramp-remote-shell-args ("-c"))))))

;; (after! ob-async
;;   (setq ob-async-no-async-languages-alist '("ipython" "python")))

(defmacro dir!! (NAME)
  `(expand-file-name ,NAME (dir!)))

(defmacro load!! (NAME)
  `(expand-file-name ,NAME (dir!)))

(quote (setq-hook! (quote (fundamental-mode))
        header-line-format (quote ("%e" (:eval)))))

(defun -minor-mode (minor-mode)
  (with-output-to-temp-buffer
      (princ (local-minor-modes))
    (re-search-backward minor-mode)))

(defun -byte-compile-conf.d ()
  (interactive)
  (let ((EL (file-expand-wildcards (concat (expand-file-name "conf.d" (dir!)) "/*.el"))))
    (mapc #'byte-compile-file EL)))

(defun -yadm-refresh-cache ()
  (setq yadm-cache (split-string-and-unquote
                    (shell-command-to-string "yadm s | colrm 1 3") "\n")))

(defun -cron-hourly (&rest REST)
  (when (boundp 'REST) (message "%S" REST))
  (-yadm-refresh-cache)
  (split-window-sensibly
   (org-agenda nil "t")))

(defun M-RET! (&rest BODY)
  "`M-RET' action"
  (interactive)
  (message "M-RET#var:BODY=%S" BODY)
  (if (eq major-mode 'dired-mode)
      (if dired-hide-details-mode
          (dired-hide-details-mode -1)
        (dired-hide-details-mode 1))
    (eval
     (let ((git (eq 0 (shell-command "git rev-parse --show-toplevel")))
           (compile (boundp 'compile-command)))
       (if git
           (if compile
               (quote (recompile))
             (quote (projectile-compile-project))))
       (assoc-default
        (string-replace "-mode" "" (symbol-name major-mode))
        (quote
         (("org" . (org-babel-tangle))
          ("python" . (progn ))
          ("yaml" . (progn ))
          ("emacs-lisp" . (progn
                            ;; TODO (file-ex (expand-file-name "conf.d" doom-user-dir))
                            (when (byte-compile (buffer-string))
                              (eval-buffer)))))))))))

(defun -frame-title (&rest BODY)
  "`frame-title-format'"
  "%b %f")

(defun -frame-title:after (&rest BODY)
  ;; (global-hide-mode-line-mode 1)
  ;; (hide-mode-line-mode -1)
  nil
  )


(defun -frame-title:before (&rest BODY)
  nil)

(defun -mark-word (&rest BODY)          ;FIXME
  (interactive)
  (let ((REGEXP (rx blank)))
   (when (looking-at (rx (not blank)))
     (unless (region-active-p)
       (set-mark-command 0)
       (re-search-backward (rx blank) nil t)
       (re-search-forward (rx blank) nil t)
       )
     ))
  )

(map! "M-+" #'-mark-word)

(setq-default frame-title-format (quote (:eval (-frame-title)))
              )

(advice-add '-frame-title :after  #'-frame-title:after)
(advice-add '-frame-title :before #'-frame-title:before)
