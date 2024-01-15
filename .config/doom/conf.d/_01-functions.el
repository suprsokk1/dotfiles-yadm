;;; $DOOMDIR/conf.d/_functions.el -*- lexical-binding: t; -*-

(require 'dired)
(require 'rx)
(require 'async)
(require 'beacon nil t)



;;;###autoload
(defun ek/babel-ansi ()
  "TODO Apply ANSI colors on region after"
  (save-excursion
    (when (looking-at org-babel-result-regexp)
      (let ((end (org-babel-result-end))
            (ansi-color-context-region nil))
        (ansi-color-apply-on-region beg end)))))

;;;###autoload
(defun -clone-line-down (&rest args)
  (interactive "*p")
  (message "clone-line-up %s" (quote args))
  (save-excursion
    (beginning-of-line)
    (insert (buffer-substring (eol)(bol)) "\n")))


;;;###autoload
(defun -clone-line-up ()              ;FIXME
  (interactive "*p")
  (line! -1)
  (message "clone-line-down %s"))

;;;###autoload
;; TODO when symbol at point is interactive defun; display bindings

;;;###autoload
(defun -list (&rest list)
  (interactive)
  (insert
    (completing-read "Insert filename:"
                     (-fd "-tf --max-depth=${_FD_MAX_DEPTH:-4} . $HOME/"))))

;;;###autoload
(defun -zsh-history (&rest list)
  (interactive)
  (insert
    (completing-read "Insert zsh history"
                     (let ((exe "zsh")
                           (prefix "")
                           (args (format "-c '%s'"
                                         "print -ln ${(F)history}|sort|uniq")))
                       (delete nil (split-string
                                    (shell-command-to-string
                                     (concat prefix exe args (eval `(concat ,@ARGS))))
                                    "\n"))))))

;;;###autoload
(defun -fd (&rest ARGS)
  (let ((exe "fd")
        (prefix "/usr/bin/env -")
        (args (concat "--print0 --hidden")))
    (delete nil (split-string
                 (shell-command-to-string
                  (concat prefix exe args (eval `(concat ,@ARGS))))
                 "\0"))))

;;;###autoload
(defun -cmd-on-buffer (CMD)
  (shell-command-on-region (point-min) (point-max) CMD nil t))

;;;###autoload
(defun -command-on-buffer ()
  (interactive
   (-cmd-on-buffer (completing-read
                    "Apply script on buffer:"
                    (split-string-and-unquote (shell-command-to-string "bash -c 'compgen -A command'"))))))

;;;###autoload
(defun -script-on-buffer ()
  (interactive
   (-cmd-on-buffer (completing-read
                    "Apply script on buffer:"
                    (-fd "-tf -tx --max-depth=${_FD_MAX_DEPTH:-3} . $HOME/")))))


;; (defun M-RET! (&rest BODY)
;;   "Default M-RET action"
;;   (interactive)
;;   (cond
;;    ((eq major-mode (quote python-mode))
;;     (run-python)
;;     (unless (string-match "*Python*" (with-output-to-string (princ (-all-window-buffers))))
;;       (switch-to-buffer-other-window "*Python*"))
;;     (let ((% (buffer-file-name)))
;;       (if % (python-shell-send-file %) (python-shell-send-buffer))))
;;    (t (let ((compile-command (format "command ~/bin/, %s" (buffer-file-name))))
;;         (recompile)))))

;;; https://stackoverflow.com/questions/14201740/replace-region-with-result-of-calling-a-function-on-region
;;; Code from accepted answer
;;;###autoload
(defun -apply-function-to-region (fn)
  (interactive "XFunction to apply to region: ")
  (save-excursion
    (let* ((beg (region-beginning))
           (end (region-end))
           (resulting-text
            (funcall fn (buffer-substring-no-properties beg end))))
      (kill-region beg end)
      (insert resulting-text))))

;; (advice-remove 'M-RET! #'-debug)
;; (advice-remove 'M-RET! #'-print-func)
;; (advice-remove 'M-RET! #'-print-funcname)
;; (advice-remove 'M-RET! #'-print-interactive)
;; (advice-remove 'M-RET! #'-print-substring)
;; (advice-remove 'M-RET! #'-print-substring)
;; (advice-remove 'M-RET! #'-shell-command)

;; (advice-add 'M-RET! :around #'-debug)
;; (advice-add 'M-RET! :around #'-print-func)
;; (advice-add 'M-RET! :around #'-print-interactive)
;; (advice-add 'M-RET! :around #'-print-substring)
;; (advice-add 'M-RET! :around #'-shell-command)
;; (advice-add 'M-RET! :around #'-shell-command-on-region)

;;;###autoload
(defun wrapper/+lookup/definition (%orig-defun-name &rest args)
  "`TODO'"
  (when (getenv "DEBUG")
    (let ((LINE (buffer-substring (eol)(bol))))
      (message "LINE RAW:\n>>>\n%S\n<<<\nLINE RE MATCH:\n>>>\n%s\n<<<"
               LINE
               (with-temp-buffer
                 (insert LINE)
                 (list
                  (re-search-backward " ")
                  (re-search-forward " "))))))

  (let ((results (apply %orig-defun-name args))
        (line (buffer-substring (eol)
                                (bol))))
    (message "wrap post: %S" (or results "Exec fail")) results))

;;; https://www.emacswiki.org/emacs/DiredOmitMode
;;; – BenEills
;;;###autoload
(defun -dired-dotfiles-toggle ()
  "Show/hide dot-files"
  (interactive)
  (when (equal major-mode 'dired-mode)
    (if (or (not (boundp 'dired-dotfiles-show-p)) dired-dotfiles-show-p) ; if currently showing
	(progn
	  (set (make-local-variable 'dired-dotfiles-show-p) nil)
	  (message "h")
	  (dired-mark-files-regexp (rx bol ?.))
	  (dired-do-kill-lines))
      (progn (revert-buffer) ; otherwise just revert to re-show
	     (set (make-local-variable 'dired-dotfiles-show-p) t)))))

;; TODO custom self insert command


;; (compile-goto-error )

;;;###autoload
(defun M-RET! (&rest BODY)
  "Default `M-RET' action"
  (interactive)
  (message "M-RET!:START")
  (let ((HOME (getenv "HOME")))
    (async-start-process
     "comma"               ;process name
     ;; (format "%s/bin/," HOME)           ;process string
     "/home/geir/bin/,"                 ;process string
     (lambda (res) (message "M-RET!:%s" res))))
  ;; (shell-command "/home/geir/bin/,")
)

;;;###autoload
(defun grep! (PAT &rest STR)
 (let ((str (or (pop STR) (buffer-string))))
   (with-temp-buffer
     (insert str)
     (shell-command-on-region 1 (point-max) (format "/usr/bin/env --ignore-environment LC_ALL=C grep '%s'" PAT)  nil t)
     (string-trim (buffer-string)))))

;; (type-of (quote (foo)))

;;;###autoload
(defun make-symbols! (STRING)
 (mapcar #'make-symbol
         (split-string-and-unquote STRING  "\n")))

;;;###autoload
(defun -occur (&rest ARGS)
  (interactive)
  (when (boundp (quote ARGS)))
  (occur (or ARGS (symbol-name (symbol-at-point)))))

;; (grep! (rx bol any "defun"))

;; TODO exchange-point-and-mark

;; (not (eq (point)(point-max)))

(provide '_functions)
;;; _functions.el ends here
