;;; conf.d/_org.el -*- lexical-binding: t; -*-
(with-eval-after-load 'org
  (setq-local so-long-minor-modes
              `(display-line-numbers-mode ,@so-long-minor-modes)))

(after! org
  (add-to-list 'doom-large-file-excluded-modes 'org-mode t)

  (use-package! ob-tmux
    ;; Install package automatically (optional)
    :ensure t
    :custom
    (org-babel-default-header-args:tmux
     '((:results . "silent")	;
       (:session . "default")	; The default tmux session to send code to
       (:socket  . nil)))		; The default tmux socket to communicate with
    ;; The tmux sessions are prefixed with the following string.
    ;; You can customize this if you like.
    (org-babel-tmux-session-prefix "ob-")
    ;; The terminal that will be used.
    ;; You can also customize the options passed to the terminal.
    ;; The default terminal is "gnome-terminal" with options "--".
    (org-babel-tmux-terminal "alacritty")
    (org-babel-tmux-terminal-opts '("-T" "ob-tmux" "-e"))
    ;; Finally, if your tmux is not in your $PATH for whatever reason, you
    ;; may set the path to the tmux binary as follows:
    (org-babel-tmux-location "/usr/bin/tmux"))

  (let ((% (expand-file-name "agenda.lst" doom-user-dir)))
    (unless (file-exists-p %)
      (write-file % nil))
    (set (quote org-agenda-files) %))

  (set (quote default)
       (quote ((org-babel-default-header-args . (default-value (quote org-babel-default-header-args))))))

  (set (quote org-babel-default-header-args)
       (quote ((:session . "none")
               (:noweb . "yes")
               (:exports . "code")
               (:mkdirp . "yes")
               (:cache . "no")
               (:tangle-mode . 384)     ; (identity #o0600)
               (:results . "replace")
               (:comments . "link")
               (:hlines . "no")
               (:tangle . "no"))))

  (set (quote org-babel-default-header-args:python)
       (quote ((:tangle-mode . 448))))

  (set (quote org-babel-default-header-args:sh)
       (quote ((:session . "none")
               (:tangle-mode . 448)
               (:mkdirp . "yes"))))

  (set (quote org-babel-default-header-args:zsh)
       (quote ((:results . "raw replace drawer"))))

  (set (quote org-babel-default-header-args:bash)
       (quote ((:session . "none")
               (:tangle-mode . 448)
               (:prologue . ". ~/.functions;. ~/.aliases")
               (:results . "raw replace drawer")
               (:mkdirp . "yes"))))

  (set (quote org-babel-default-header-args:cat)
       (quote ()))

  ;; (org-babel-shell-initialize)

  ;; (add-to-list 'org-babel-shell-names "cat")

  (ignore-errors
    (org-babel-lob-ingest (or (format "%s/_lob.org" doom-user-dir))))

  (defun -babel-ansi ()
    "TODO Apply ANSI colors on region after"
    (save-excursion
      (when (looking-at org-babel-result-regexp)
        (let ((end (org-babel-result-end))
              (ansi-color-context-region nil))
          (ansi-color-apply-on-region beg end)))))

  (add-hook 'org-babel-after-execute-hook 'ek/babel-ansi))
