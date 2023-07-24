 ;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
 ;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(after! doom-ui
  (abbrev-mode 1)
  (blink-cursor-mode 1)
  (display-line-numbers-mode -1)
  (global-hl-line-mode -1)
  (doom-modeline-mode 1)
  (global-hide-mode-line-mode -1))

(set (quote doom-theme)
     (quote doom-dracula))

(set (quote +snippets-dir)
     (or (expand-file-name "snippets" (file-truename doom-user-dir))
         (expand-file-name "snippets" (expand-file-name doom-user-dir))))

(set (quote initial-buffer-choice)
     (or (expand-file-name "dashboard.org" doom-user-dir)
         (expand-file-name "todo.org" org-directory)))

(set (quote safe-local-variable-values)
     (quote ((eval require 'dotfiles-emacs-macros))))

(set (quote comint-move-point-for-output)
     t)

(set (quote doom-modeline-major-mode-icon)
     t)

(set (quote doom-projectile-cache-blacklist)
     (quote ("/tmp")))

(set (quote bookmark-default-file)
     (expand-file-name "bookmarks.el" doom-user-dir))

(set (quote shift-select-mode)
     nil)

(set (quote display-line-numbers-type)
     (quote absolute))

(set (quote +python-ipython-repl-args)
     (quote ("-i" "--simple-prompt" "--no-color-info")))

(set (quote +python-jupyter-repl-args)
     (quote ("--simple-prompt")))

(after! org
  (set (quote org-agenda-files)
       (expand-file-name "agenda.lst" doom-user-dir))

  (set (quote default)
       (quote ((org-babel-default-header-args . (default-value (quote org-babel-default-header-args))))))

  (set (quote org-babel-default-header-args)
       (quote ((:session . "none")
               (:noweb . "yes")
               (:results . "replace silent")
               (:exports . "code")
               (:cache . "no")
               (:tangle-mode . 416)     ; #o0640
               (:comments . "link")
               (:hlines . "no")
               (:tangle . "no"))))

  (set (quote org-babel-default-header-args:python)
       (quote ((:results . "replace silent")
               (:tangle-mode . 448))))

  (set (quote org-babel-default-header-args:shell)
       (quote ((:session . "none")
               (:results . "replace silent")
               (:tangle-mode . 448)
               (:mkdirp . "yes"))))

  (ignore-errors
    (org-babel-lob-ingest (or (format "%s/lob.org" doom-user-dir))))

  (defun ek/babel-ansi ()
    (when-let ((beg (org-babel-where-is-src-block-result nil nil)))
      (save-excursion
        (goto-char beg)
        (when (looking-at org-babel-result-regexp)
          (let ((end (org-babel-result-end))
                (ansi-color-context-region nil))
            (ansi-color-apply-on-region beg end))))))
  (add-hook 'org-babel-after-execute-hook 'ek/babel-ansi))

(defmacro my/all-windows ()
  `(flatten-list (mapcar #'window-list (frame-list))))

(defmacro my/all-buffers ()
  `(flatten-list (mapcar #'buffer-list (frame-list))))

(defmacro my/all-window-buffers ()
  `(flatten-list (mapcar #'window-buffer (my/all-windows))))

(defmacro my/all-process-buffers ()
  `(flatten-list (mapcar #'process-buffer (process-list))))

(defmacro my/get-buffer ($buffer-name)
  `(get-buffer
    (with-temp-buffer
      (insert (with-output-to-string
                (princ (my/all-process-buffers))))
      (re-search-backward (rx ?* ,(eval $buffer-name) ?*) nil t)
      (buffer-substring (match-beginning 0)
                        (match-end 0)))))

(defun M-RET! (&rest BODY)
  (interactive)
  (eval (assoc-default major-mode my/compile)))
(defvar my/compile
  '(
    ;; EXPECT- / TCL-MODE
    (tcl-mode . (recompile))


    ;; YAML
    (yaml-mode .  (progn (when nil
                           (message "DEBUG")
                           (setq-local compile-command (format "command /usr/bin/env ./%" (buffer-file-name)))
                           (recompile))
                         (recompile)))

    ;; MAKEFILE
    (makefile-gmake-mode .  (recompile))

    ;; EMACS
    (emacs-lisp-mode .  (eval-buffer))

    ;; SHELL
    (sh-mode . (progn (let (($ (buffer-file-name))
                            (% (make-temp-file nil nil ".sh")))
                        (save-excursion
                          (goto-char 0)
                          (when (looking-at (rx "bash")) (setq-local compile-command (format "cp %s %s; bash $_" $ %))) ;; FIXME
                          (when (looking-at (rx "zsh")) (setq-local compile-command (format "cp %s %s; zsh $_" $ %)))) ;; FIXME
                        (when (projectile-project-name)
                          (recompile))
                        )))

    ;; PYTHON
    (python-mode . (progn
                     (let (($ python-shell-buffer-name)
                           (% (buffer-file-name))
                           (prev (get-buffer (buffer-name))))

                       (unless (my/is-running $)
                         (run-python))

                       (message "DEBUG:%s" %)

                       (python-shell-send-file %)

                       (unless (my/is-visible $)
                         (progn
                           (when (eq 1 (count-windows))
                             (split-window-sensibly))
                           (switch-to-buffer-other-window
                            (my/get-buffer python-shell-buffer-name)))))))))

(after! vterm
  (global-set-key (kbd "H-M-\\") #'+vterm/toggle)
  (global-set-key (kbd "H-\\") #'vterm))

(after! consult
  (global-set-key (kbd "H-r") #'consult-recent-file)
  (global-set-key (kbd "s-r") #'consult-recent-file))

(after! projectile
  (global-set-key (kbd "H-p") #'projectile-find-file)
  (global-set-key (kbd "s-p") #'projectile-find-file)
  (global-set-key (kbd "H-M-p") #'projectile-switch-project)
  (global-set-key (kbd "s-M-p") #'projectile-switcH-project)
  (global-set-key (kbd "s-r") #'consult-recent-file))

(global-set-key (kbd "M-RET") nil)
(global-set-key (kbd "H-SPC RET") #'M-RET!)
(global-set-key (kbd "s-SPC RET") #'M-RET!)

(global-set-key (kbd "s-SPC TAB") (cmd! (find-file initial-buffer-choice)))
(global-set-key (kbd "s-SPC b") #'doom-big-font-mode)
(global-set-key (kbd "s-SPC q") #'delete-other-windows)
(global-set-key (kbd "s-SPC s-q") #'delete-other-frames)
(global-set-key (kbd "s-<down>") #'my/clone-line-down)
(global-set-key (kbd "s-<up>") #'my/clone-line-up)
(global-set-key (kbd "s-SPC s") #'org-narrow-to-subtree)
(global-set-key (kbd "s-SPC w") #'writeroom-mode)
(global-set-key (kbd "s-M-k") #'doom/kill-this-buffer-in-all-windows)
(global-set-key (kbd "s-8") #'my/mark-all-like-this)
(global-set-key (kbd "H-SPC TAB") (cmd! (find-file initial-buffer-choice)))
(global-set-key (kbd "H-SPC b") #'doom-big-font-mode)
(global-set-key (kbd "H-SPC q") #'delete-other-windows)
(global-set-key (kbd "H-SPC H-q") #'delete-other-frames)
(global-set-key (kbd "H-<down>") #'my/clone-line-down)
(global-set-key (kbd "H-<up>") #'my/clone-line-up)
(global-set-key (kbd "H-SPC s") #'org-narrow-to-subtree)
(global-set-key (kbd "H-SPC w") #'writeroom-mode)
(global-set-key (kbd "H-SPC w") #'global-writeroom-mode)
(global-set-key (kbd "H-M-k") #'doom/kill-this-buffer-in-all-windows)
(global-set-key (kbd "M-s-k") #'doom/kill-this-buffer-in-all-windows)
(global-set-key (kbd "H-8") #'my/mark-all-like-this)
(global-set-key (kbd "H-i f") #'+default/insert-file-path)
(global-set-key (kbd "s-i f") #'+default/insert-file-path)
(global-set-key (kbd "H-SPC ]") #'mc/edit-enda-of-lines)
(global-set-key (kbd "H-SPC [") #'mc/edit-beginnings-of-lines)
(global-set-key (kbd "H-SPC a") #'mc/edit-beginnings-of-lines)
(global-set-key (kbd "H-SPC e") #'mc/edit-enda-of-lines)
(global-set-key (kbd "s-SPC [") #'mc/edit-beginnings-of-lines)
(global-set-key (kbd "s-SPC ]") #'mc/edit-enda-of-lines)
(global-set-key (kbd "s-SPC a") #'mc/edit-beginnings-of-lines)
(global-set-key (kbd "s-SPC e") #'mc/edit-enda-of-lines)
(global-set-key (kbd "H-}") #'flycheck-next-error)
(global-set-key (kbd "H-{") #'flycheck-previous-error)
(global-set-key (kbd "C-<tab>") #'flycheck-next-error)
(global-set-key (kbd "C-<iso-lefttab>") #'flycheck-previous-error)
(global-set-key (kbd "H-SPC n") #'org-capture)
(global-set-key (kbd "H-SPC m") #'mc/mark-all-like-this) ;FIXME
(global-set-key (kbd "H-.") #'dired-jump)
(global-set-key (kbd "s-.") #'dired-jump)
(global-set-key (kbd "H-<return>") #'bookmark-jump)
(global-set-key (kbd "s-<return>") #'bookmark-jump)
(global-set-key (kbd "H-l") #'display-line-numbers-mode)
(global-set-key (kbd "s-l") #'display-line-numbers-mode)
(global-set-key (kbd "H-M-l") #'toggle-truncate-lines)
(global-set-key (kbd "M-s-l") #'toggle-truncate-lines)
(global-set-key (kbd "H-m") #'hide-mode-line-mode)
(global-set-key (kbd "H-<backspace>") #'delete-pair)
(global-set-key (kbd "s-<backspace>") #'delete-pair)
(global-set-key (kbd "H-[") #'undo)
(global-set-key (kbd "H-]") #'undo-redo)
(global-set-key (kbd "H-/") #'+default/search-buffer)
(global-set-key (kbd "s-/") #'+default/searcH-buffer)
(global-set-key (kbd "H-SPC p") #'doom/goto-private-packages-file)
(global-set-key (kbd "s-SPC p") #'doom/goto-private-packages-file)
(global-set-key (kbd "H-SPC i") #'doom/goto-private-init-file)
(global-set-key (kbd "s-SPC i") #'doom/goto-private-init-file)
(global-set-key (kbd "H-SPC c") #'doom/goto-private-config-file)
(global-set-key (kbd "s-SPC c") #'doom/goto-private-config-file)
(global-set-key (kbd "H-SPC x") #'doom/open-scratch-buffer)
(global-set-key (kbd "s-SPC x") #'doom/open-scratcH-buffer)
(global-set-key (kbd "H-SPC l") #'my/open-library-of-babel)
(global-set-key (kbd "H-0") #'balance-windows)
(global-set-key (kbd "H-n") #'split-window-horizontally)
(global-set-key (kbd "H-n") #'split-window-horizontally)
(global-set-key (kbd "H-M-n") #'split-window-vertically)
(global-set-key (kbd "M-s-n") #'split-window-vertically)
(global-set-key (kbd "H-k") #'delete-window)
(global-set-key (kbd "H-M-[") #'winner-undo)
(global-set-key (kbd "H-M-]") #'winner-redo)
(global-set-key (kbd "s-]") 'undo-redo)
(global-set-key (kbd "s-[") 'undo)
(global-set-key (kbd "s-n") #'split-window-horizontally)
(global-set-key (kbd "M-s-n") #'split-window-vertically)
(global-set-key (kbd "M-]") #'next-error)
(global-set-key (kbd "M-[") #'previous-error)
(global-set-key (kbd "s-0") #'balance-windows)
(global-set-key (kbd "M-s-0") #'balance-windows-area)
(global-set-key (kbd "H-M-0") #'balance-windows-area)
(global-set-key (kbd "s-<return>") #'bookmark-jump)
(global-set-key (kbd "M-s-<return>") #'org-roam-node-find)
(global-set-key (kbd "<f12>") #'flycheck-list-errors)
(global-set-key (kbd "<f5>") #'call-last-kbd-macro)
(global-set-key (kbd "M-s-[") #'winner-undo)
(global-set-key (kbd "M-s-]") #'winner-redo)
(global-set-key (kbd "H-M-k") #'kill-buffer)
(global-set-key (kbd "M-s-k") #'kill-buffer)
(global-set-key (kbd "H-;") #'company-yasnippet)
(global-set-key (kbd "s-;") #'company-yasnippet)
(global-set-key (kbd "s-<up>") #'my/clone-line-up)
(global-set-key (kbd "s-k") #'delete-window)
(global-set-key (kbd "s-m s-m") #'mc/mark-all-like-this)
(global-set-key (kbd "C-.") #'mc/mark-next-like-this)
(global-set-key (kbd "C-c SPC SPC") #'my/refresh)
(global-set-key (kbd "H-SPC H-SPC") #'my/refresh)
(global-set-key (kbd "H-SPC h") (cmd! (dired "~")))
(global-set-key (kbd "H-SPC r") nil)
(global-set-key (kbd "H-SPC ~") (cmd! (dired "~")))
(global-set-key (kbd "s-SPC r") nil)
(global-set-key (kbd "s-g") #'magit-status)
(global-set-key (kbd "H-g") #'magit-status)
(global-set-key (kbd "s-<down>")  #'my/clone-line-down)
(global-set-key (kbd "s-SPC h") (cmd! (dired "~")))
(global-set-key (kbd "s-SPC s-SPC") #'my/refresh)
(global-set-key (kbd "s-SPC ~") (cmd! (dired "~")))

(map!
 (:map dired-mode-map
       "]"   #'dired-next-marked-file
       "["   #'dired-prev-marked-file
       "," nil
       (:prefix ","
                "," #'dired-unmark-all-marks)
       "." nil
       (:prefix "."
                "." #'dired-up-directory)
       (:prefix "/"
                "/" #'dired-mark-files-regexp
                "." #'dired-mark-files-containing-regexp)))

(defun my/refresh (&rest _)
  "TODO add `my/refresh' as hook to `display-buffer'"
  (interactive)
  (ignore-errors (doom/reload-font))

  (when (region-active-p)
    (yas-new-snippet))

  (if (region-active-p)
      (yas-new-snippet)                          ;active
    (let* ((window-count (length (window-list))) ;inactive
           (one-window (eq window-count 1))
           (indirect-buffer (message "TODO")))
      (widen)
      (whitespace-cleanup)
      (cond (one-window (writeroom-mode 1))
            (t
             (writeroom-mode -1)
             (balance-windows)))
      (cond ((eq major-mode 'python-mode)
             (unless (window--process-window-list)
               (run-python nil nil t)))
            (t nil))
      (cond ((eq major-mode 'org-mode)
             (org-babel-tangle))
            (t (save-window-excursion (org-babel-detangle))))))
  (recentf-cleanup))

(use-package! dotfiles-emacs-macros
  :load-path "~/git/dotfiles-emacs-macros"
  :demand t)

(use-package! dotfiles-emacs-bindings
  :after dotfiles-emacs-macros
  :load-path "~/git/dotfiles-emacs-bindings"
  :demand t)

(use-package! comint
  :custom
  (comint-buffer-maximum-size 20000 "Increase comint buffer size.")
  (comint-prompt-read-only t        "Make the prompt read only."))

(use-package! dockerfile-mode
  :init (setenv "DOCKER_BUILDKIT" "1")
  :mode "dockerfile\(?:\.[[:word:]]+\)?\'"
  :custom
  (dockerfile-mode-command "docker buildx build"))

(use-package! org-roam
  :demand t
  :if (string-match "sqlite3" (shell-command-to-string "command -v sqlite3"))
  :bind (("s-SPC SPC" . org-roam-node-find)
         ("H-SPC SPC" . org-roam-node-find))
  :catch (lambda (keyword err)
           (message (error-message-string err))))

(use-package! windmove
  :bind (("s-q"   . #'windmove-left)
         ("s-e"   . #'windmove-right)
         ("s-w"   . #'windmove-up)
         ("s-s"   . #'windmove-down)
         ("H-q"   . #'windmove-left)
         ("H-e"   . #'windmove-right)
         ("H-w"   . #'windmove-up)
         ("H-s"   . #'windmove-down)
         ("M-s-q" . #'windmove-swap-states-left)
         ("M-H-q" . #'windmove-swap-states-left)
         ("M-s-e" . #'windmove-swap-states-right)
         ("M-H-e" . #'windmove-swap-states-right)
         ("M-s-w" . #'windmove-swap-states-up)
         ("M-H-w" . #'windmove-swap-states-up)
         ("M-s-s" . #'windmove-swap-states-down)
         ("M-H-s" . #'windmove-swap-states-down)))

(use-package! org-crypt
  :catch (lambda (&rest -)))

(use-package! hi-lock
  :bind (("M-o l" . highlight-lines-matching-regexp)
         ("M-o r" . highlight-regexp)
         ("M-o w" . highlight-phrase)))

(use-package! modus-themes
  :ensure t
  :load-path "~/git/modus-themes"
  :config
  (modus-themes-select 'modus-vivendi-tinted)
  :custom
  (modus-themes-to-toggle
   (quote (modus-operandi-tinted modus-vivendi-tinted))))

(after! ob-async
  (setq ob-async-no-async-languages-alist '("ipython" "python")))

(ignore-errors
  (load-file (format "~/.%s.el" (getenv "HOSTNAME"))))
