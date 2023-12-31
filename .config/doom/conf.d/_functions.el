;;; $DOOMDIR/conf.d/_functions.el -*- lexical-binding: t; -*-

;;;###autoload
(defun -refresh (&rest _)
  "TODO add `-refresh' as hook to `display-buffer'"
  (interactive)
  (ignore-errors (doom/reload-font))
  (recentf-cleanup)
  (if (region-active-p)
      (yas-new-snippet)
    (let ((window-count (length (window-list)))) ;
      (let ((one-window (eq window-count 1))
            (xdg-dir (getenv "XDG_RUNTIME_DIR"))
            (writeroom (featurep 'writeroom-room))
            (org (eq major-mode 'org-mode))
            (python (eq major-mode 'python-mode))
            (py (eq major-mode 'python-mode))
            (elisp (eq major-mode 'emacs-lisp-mode))
            (el (eq major-mode 'emacs-lisp-mode))
            (indirect-buffer (quote TODO)))
        (quote (when xdg-dir           ;FIXME
                (let ((desktop-dir (expand-file-name "desktop" xdg-dir))
                      (PARENTS t))
                  (mkdir desktop-dir PARENTS)
                  (if one-window
                      (desktop-change-dir desktop-dir) ;; FIXME
                    (desktop-save desktop-dir))))))))

  (widen)
  (whitespace-cleanup)
  (bookmark-save)
  (balance-windows)

  (cond (python
         (python-shell-restart)))
  (cond (org
         (org-babel-tangle))
        (t (save-window-excursion (org-babel-detangle)))))


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
  (interactive
   (insert
    (completing-read "Insert filename:"
                     (-fd "-tf --max-depth=${_FD_MAX_DEPTH:-4} . $HOME/")))))

;;;###autoload
(defun -zsh-history (&rest list)
  (interactive
   (insert
    (completing-read "Insert zsh history"
                     (let ((exe "zsh")
                           (prefix "")
                           (args (format "-c '%s'"
                                         "print -ln ${(F)history}|sort|uniq")))
                       (delete nil (split-string
                                    (shell-command-to-string
                                     (concat prefix exe args (eval `(concat ,@ARGS))))
                                    "\n")))))))

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
   (-cmd-on-buffer
    (completing-read
     "Apply script on buffer:"
     (split-string-and-unquote (shell-command-to-string "bash -c 'compgen -A command'"))))))

;;;###autoload
(defun -script-on-buffer ()
  (interactive
   (-cmd-on-buffer
    (completing-read
     "Apply script on buffer:"
     (-fd "-tf -tx --max-depth=${_FD_MAX_DEPTH:-3} . $HOME/")))))

;;;###autoload
(defun M-RET! (&rest BODY)
  "Default M-RET action"
  (interactive)
  (cond
   ((eq major-mode (quote python-mode))
    (run-python)
    (unless (string-match "*Python*" (with-output-to-string (princ (-all-window-buffers))))
      (switch-to-buffer-other-window "*Python*"))
    (let ((% (buffer-file-name)))
      (if % (python-shell-send-file %) (python-shell-send-buffer))))
   (t (let ((compile-command (format "command ~/bin/, %s" (buffer-file-name))))
        (recompile)))))

;;;###autoload
(defun wrapper/+lookup/definition (%orig-defun-name &rest args)
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

(provide '_functions)
