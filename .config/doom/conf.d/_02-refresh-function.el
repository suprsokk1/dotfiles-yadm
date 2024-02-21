;;; $DOOMDIR/conf.d/_functions.el -*- lexical-binding: t; -*-

;; TODO rewrite into core function with post/pre hooks or advice for added functionality

(require 'dired)
(require 'rx)
(require 'async)
(require 'beacon nil t)

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
            (is-git (not (eq 128 (string-to-number (shell-command-to-string "git rev-parse --show-toplevel &>/dev/null; echo -en $?")))))
            (is-file (eq 'string (type-of (buffer-file-name))))
            (xdg-dir (getenv "XDG_RUNTIME_DIR"))
            (writeroom (featurep 'writeroom-room))
            (org (eq major-mode 'org-mode))
            (dired (eq major-mode 'dired-mode))
            (sh (eq major-mode 'sh-mode))
            (make (eq major-mode 'makefile-gmake-mode))
            (python (eq major-mode 'python-mode))
            (py (eq major-mode 'python-mode))
            (elisp (eq major-mode 'emacs-lisp-mode))
            (el (eq major-mode 'emacs-lisp-mode))
            (MODE (make-symbol (string-replace "-mode" "" (symbol-name major-mode))))
            (indirect-buffer (quote TODO)))

        (assoc-default MODE
                       (quote ((org . (org-babel-tangle))
                               (dired . (quote TODO))
                               (python . (python-shell-restart))
                               (emacs-lisp . (quote TODO)))))

        (assoc-default 'foo (quote ((foo . bar))))
        (quote
         (when xdg-dir           ;FIXME
          (let ((desktop-dir (expand-file-name "desktop" xdg-dir))
                (PARENTS t))
            (mkdir desktop-dir PARENTS)

            (if one-window
                (desktop-change-dir desktop-dir) ;; FIXME
              (desktop-save desktop-dir)))))

        ;; (projectile-invalidate-cache nil)

        (when python
          (python-sort-imports)
          (python-shell-restart))

        (when (and is-git (or make sh))
          (+tmux/cd-to-here)
          (+tmux/run "swaymsg 'focus; [floating] move to scratchpad; [con_mark=terminal] scratchpad show'")
          (+tmux/run "clear")
          ;; (+tmux/run (concat "set - " (buffer-file-name)))
          (let ((NORETURN t)
                (SEND (eval `(assoc-default major-mode
                              (quote ((emacs-lisp-mode . ":*(")
                                      (sh-mode . ,(buffer-file-name))
                                      (makefile-gmake-mode . "make")))))))
          (when SEND (+tmux/run  NORETURN))))

        ;; (cond (python)
        ;;       (org )
        ;;       (t (save-window-excursion (org-babel-detangle))))

        (let ((_ (widen))
              (_ (whitespace-cleanup))
              (_ (bookmark-save))
              (_ (text-scale-adjust 0))
              ;; (_ (balance-windows-area))
              ))
        ;; (member 'prog-mode)

        ))))
