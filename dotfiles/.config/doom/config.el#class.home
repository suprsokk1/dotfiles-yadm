;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-


(after! doom-ui
  (require '-functions nil t)
  (setq -reloaded (boundp '-reloaded))
  (setq -toggle (boundp '-reloaded))
  (setq-hook! (quote conf-mode-hook js-mode)
    display-line-numbers-type (quote absolute)))

(set (quote +snippets-dir)
     (or (expand-file-name "snippets" (file-truename doom-user-dir))
         (expand-file-name "snippets" (expand-file-name doom-user-dir))))

(set (quote doom-theme)
     (quote doom-dracula))

(set (quote doom-scratch-initial-major-mode)
     (quote fundamental-mode))

;; (set (quote doom-modeline-mode-alist) )

(set (quote custom-file)
     (expand-file-name "_custom.el" doom-private-dir))

;; (set (quote global-hide-mode-line-mode) 1)

;; (set (quote initial-buffer-choice)
;;      (or (expand-file-name "dashboard.org" doom-user-dir)
;;          (expand-file-name "todo.org" org-directory)))

(set (quote comint-move-point-for-output)
     t)

(set (quote doom-modeline-major-mode-icon)
     t)

(set (quote doom-projectile-cache-blacklist)
     (quote ("/tmp")))

(set (quote bookmark-default-file)
     (expand-file-name "_bookmarks.el" doom-user-dir))

(set (quote shift-select-mode)
     nil)

(set (quote display-line-numbers-type)
     nil)

(after! python
  (set (quote +python-ipython-repl-args)
       (quote ("-i" "--simple-prompt" "--no-color-info")))

  (set (quote +python-jupyter-repl-args)
       (quote ("--simple-prompt"))))

(after! org
  (set (quote org-agenda-files)
       (expand-file-name "agenda.lst" doom-user-dir))

  (set (quote default)
       (quote ((org-babel-default-header-args . (default-value (quote org-babel-default-header-args))))))

  (set (quote org-babel-default-header-args)
       (quote ((:session . "none")
               (:noweb . "yes")
               (:exports . "code")
               (:cache . "no")
               (:tangle-mode . 416)     ; (identity #o0640)
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

  (set (quote org-babel-default-header-args:bash)
       (quote ((:session . "none")
               (:tangle-mode . 448)
               (:prologue . ". ~/.functions;. ~/.aliases")
               (:results . "raw replace drawer")
               (:mkdirp . "yes"))))

  (ignore-errors
    (org-babel-lob-ingest (or (format "%s/_lob.org" doom-user-dir))))

  (defun ek/babel-ansi ()
    (when-let ((beg (org-babel-where-is-src-block-result nil nil)))
      (save-excursion
        (goto-char beg)
        (when (looking-at org-babel-result-regexp)
          (let ((end (org-babel-result-end))
                (ansi-color-context-region nil))
            (ansi-color-apply-on-region beg end))))))

  (defun -babel-ansi ()
    "TODO Apply ANSI colors on region after"
    (save-excursion
      (when (looking-at org-babel-result-regexp)
        (let ((end (org-babel-result-end))
              (ansi-color-context-region nil))
          (ansi-color-apply-on-region beg end)))))

  (add-hook 'org-babel-after-execute-hook 'ek/babel-ansi))

(defmacro sh!! (CMDLINE)
  `(ignore-errors
     (string= "0" (string-trim (shell-command-to-string (concat ,CMDLINE " &> /dev/null; echo $?"))))))

(defmacro ENV! ()
  "Convert environment vars into assoc list (hash table)"
  `(mapcar
    (lambda (_)
      (let* ((LIST (split-string-and-unquote _ "="))
             (KEY (car LIST))
             (VALUE (mapconcat (lambda(_)_) (cdr LIST) "=")))
        `(,(intern KEY) . ,VALUE)))
    (split-string-and-unquote (sh! "cat /proc/$PPID/environ") "\0")))

(defun M-RET! (&rest BODY)
  "Default M-RET action"
  (interactive)
  (quote (progn
           TODO
           (unless (string= "-" (projectile-project-name))
             (recompile))))
  (eval (assoc-default major-mode -compile)))

(defvar -compile
  '(
    ;; EXPECT- / TCL-MODE
    (tcl-mode . (recompile))

    ;; YAML
    (yaml-mode .  (progn (when nil
                           (setq-local compile-command (format "command /usr/bin/env ./%" (buffer-file-name)))
                           (recompile))
                         (recompile)))

    ;; MAKEFILE
    (makefile-gmake-mode .  (recompile))

    ;; EMACS LISP
    (emacs-lisp-mode .  (eval-buffer))

    ;; SHELL
    (sh-mode . (progn (let (($ (buffer-file-name))
                            (% (make-temp-file nil nil ".sh")))
                        (save-excursion
                          (goto-char 0)
                          (when (looking-at (rx "bash")) (setq-local compile-command (format "cp %s %s; bash $_" $ %))) ;; FIXME
                          (when (looking-at (rx "zsh")) (setq-local compile-command (format "cp %s %s; zsh $_" $ %)))) ;; FIXME
                        (unless (string= "-" (projectile-project-name))
                          (recompile)))))

    ;; PYTHON
    (python-mode . (progn
                     (let (($ python-shell-buffer-name)
                           (% (buffer-file-name))
                           (prev (get-buffer (buffer-name))))

                       (unless (-is-running $)
                         (run-python))

                       (message "DEBUG:%s" %)

                       (python-shell-send-file %)

                       (unless (-is-visible $)
                         (progn
                           (when (eq 1 (count-windows))
                             (split-window-sensibly))
                           (switch-to-buffer-other-window
                            (-get-buffer python-shell-buffer-name)))))))))

(global-set-key (kbd "M-RET") #'M-RET!)

(after! projectile
  (global-set-key (kbd "H-p") #'projectile-find-file)
  (global-set-key (kbd "s-p") #'projectile-find-file)
  (global-set-key (kbd "H-M-p") #'projectile-switch-project)
  (global-set-key (kbd "s-M-p") #'projectile-switcH-project))

(map!
 "s-SPC TAB" (cmd! (find-file initial-buffer-choice))
 "s-SPC b" #'doom-big-font-mode
 "s-SPC q" #'delete-other-windows
 "s-SPC s-q" #'delete-other-frames
 "s-<down>" #'-clone-line-down
 "s-<up>" #'-clone-line-up
 "s-SPC s" #'org-narrow-to-subtree
 "s-M-k" #'doom/kill-this-buffer-in-all-windows
 "s-8" #'-mark-all-like-this
 "H-SPC TAB" (cmd! (find-file initial-buffer-choice))
 "H-SPC b" #'doom-big-font-mode
 "H-SPC q" #'delete-other-windows
 "H-SPC H-q" #'delete-other-frames
 "H-<down>" #'-clone-line-down
 "H-<up>" #'-clone-line-up
 "H-SPC s" #'org-narrow-to-subtree
 "H-M-k" #'doom/kill-this-buffer-in-all-windows
 "M-s-k" #'doom/kill-this-buffer-in-all-windows
 "H-8" #'-mark-all-like-this
 "H-i f" #'+default/insert-file-path
 "s-i f" #'+default/insert-file-path
 "H-SPC ]" #'mc/edit-enda-of-lines
 "H-SPC [" #'mc/edit-beginnings-of-lines
 "H-SPC a" #'mc/edit-beginnings-of-lines
 "H-SPC e" #'mc/edit-enda-of-lines
 "s-SPC [" #'mc/edit-beginnings-of-lines
 "s-SPC ]" #'mc/edit-enda-of-lines
 "s-SPC a" #'mc/edit-beginnings-of-lines
 "s-SPC e" #'mc/edit-enda-of-lines
 "H-}" #'flycheck-next-error
 "H-{" #'flycheck-previous-error
 "C-<tab>" #'flycheck-next-error
 "C-<iso-lefttab>" #'flycheck-previous-error
 "H-SPC n" #'org-capture
 "H-SPC m" #'mc/mark-all-like-this ;FIXME
 "H-." #'dired-jump
 "s-." #'dired-jump
 "H-<return>" #'bookmark-jump
 "s-<return>" #'bookmark-jump
 "H-l" #'display-line-numbers-mode
 "s-l" #'display-line-numbers-mode
 "H-M-l" #'toggle-truncate-lines
 "M-s-l" #'toggle-truncate-lines
 "H-m" #'+zen/toggle-fullscreen
 "H-<backspace>" #'delete-pair
 "s-<backspace>" #'delete-pair
 "H-[" #'undo
 "H-]" #'undo-redo
 "H-/" #'+default/search-buffer
 "s-/" #'+default/searcH-buffer
 "H-SPC p" #'doom/goto-private-packages-file
 "s-SPC p" #'doom/goto-private-packages-file
 "H-SPC i" #'doom/goto-private-init-file
 "s-SPC i" #'doom/goto-private-init-file
 "H-SPC c" #'doom/goto-private-config-file
 "s-SPC c" #'doom/goto-private-config-file
 "H-SPC x" #'doom/open-scratch-buffer
 "s-SPC x" #'doom/open-scratcH-buffer
 "H-SPC l" #'-open-library-of-babel
 "H-0" #'balance-windows
 "H-n" #'split-window-horizontally
 "H-n" #'split-window-horizontally
 "H-M-n" #'split-window-vertically
 "M-s-n" #'split-window-vertically
 "H-k" #'delete-window
 "H-M-[" #'winner-undo
 "H-M-]" #'winner-redo
 "s-]" 'undo-redo
 "s-[" 'undo
 "s-n" #'split-window-horizontally
 "M-s-n" #'split-window-vertically
 "M-]" #'next-error
 "M-[" #'previous-error
 "s-0" #'balance-windows
 "M-s-0" #'balance-windows-area
 "H-M-0" #'balance-windows-area
 "s-<return>" #'bookmark-jump
 "M-s-<return>" #'org-roam-node-find
 "<f12>" #'flycheck-list-errors
 "<f5>" #'call-last-kbd-macro
 "M-s-[" #'winner-undo
 "M-s-]" #'winner-redo
 "H-;" #'company-yasnippet
 "s-;" #'company-yasnippet
 "s-<up>" #'-clone-line-up
 "s-k" #'delete-window
 "s-m s-m" #'mc/mark-all-like-this
 "C-." #'mc/mark-next-like-this
 "C-c SPC SPC" #'-refresh
 "H-SPC H-SPC" #'-refresh
 "H-SPC h" (cmd! (dired "~"))
 "H-SPC r" nil
 "H-SPC ~" (cmd! (dired "~"))
 "s-SPC r" nil
 "s-g" #'magit-status
 "H-g" #'magit-status
 "s-<down>"  #'-clone-line-down
 "s-SPC h" (cmd! dired "~")
 "s-SPC s-SPC" #'-refresh
 "s-SPC ~" (cmd! dired "~"))

(map!
 (:after dired :map dired-mode-map
         "r" #'dired-do-rename-regexp)
 (:map global-map
       "H-r" #'consult-buffer
       "H-M-k" #'doom/kill-this-buffer-in-all-windows
       "M-s-k" #'doom/kill-this-buffer-in-all-windows
       (:prefix "H-SPC"
                "i" nil
                (:prefix "i"
                         "f" #'-list
                         "u" #'insert-char)
                "H-q" #'delete-other-windows
                (:prefix
                 )))

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

(use-package! doom-ui
  :custom
  (hide-mode-line-mode t))

(use-package! comint
  :custom
  (comint-buffer-maximum-size 20000 "Increase comint buffer size.")
  (comint-prompt-read-only t        "Make the prompt read only."))

(use-package! dockerfile-mode
  :init (setenv "DOCKER_BUILDKIT" "1")
  :mode "dockerfile\(?:\.[[:word:]]+\)?\'"
  :custom
  (dockerfile-mode-command "docker buildx build"))

(use-package! org
  :config (progn
            (defun my/org-mode-hook ()
              (setq truncate-lines t
                    display-line-numbers-mode -1)))
  :hook ((org-mode . my/org-mode-hook))
  :custom
  (display-line-numbers-mode -1)
  (org-mode-hook nil))

(use-package! org-roam
  :if (string-match "sqlite3" (shell-command-to-string "command -v sqlite3"))
  :bind (("s-SPC SPC" . org-roam-node-find)
         ("H-SPC SPC" . org-roam-node-find)
         ("H-SPC t"   . org-roam-tag-add))
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

(use-package! org-crypt)

(use-package! hi-lock
  :bind (("M-o l" . highlight-lines-matching-regexp)
         ("M-o r" . highlight-regexp)
         ("M-o w" . highlight-phrase)))

(use-package! modus-themes
  :ensure t
  :load-path "~/git/modus-themes"
  :config
  (modus-themes-select 'modus-vivendi-tinted)
  (setq modus-themes-variable-pitch-ui t)
  :custom
  (modus-themes-to-toggle (quote (modus-operandi-tinted modus-vivendi-tinted))))

(use-package! writeroom
  :no-require t
  :bind (("s-SPC w" . #'writeroom-mode)
         ("H-SPC w" . #'writeroom-mode)))

(use-package! vterm
  :bind (("H-\\" . #'+vterm/toggle))
  :custom
  (vterm-shell "/bin/zsh"))

(use-package! flycheck
  :custom
  (flycheck-mode-hook nil))

(use-package! -macros
  :no-require t
  :config
  (defmacro -all-windows ()
    `(flatten-list (mapcar #'window-list (frame-list))))

  (defmacro -all-buffers ()
    `(flatten-list (mapcar #'buffer-list (frame-list))))

  (defmacro -all-window-buffers ()
    `(flatten-list (mapcar #'window-buffer (-all-windows))))

  (defmacro -all-process-buffers ()
    `(flatten-list (mapcar #'process-buffer (process-list))))

  (defmacro -get-buffer ($buffer-name)
    `(get-buffer
      (with-temp-buffer
        (insert (with-output-to-string
                  (princ (-all-process-buffers))))
        (re-search-backward (rx ?* ,(eval $buffer-name) ?*) nil t)
        (buffer-substring (match-beginning 0)
                          (match-end 0))))))

;; ;; minor mode to hide
;; (use-package! so-long
;;   :custom
;;   (so-long-minor-modes
;;    (quote (
;;            auto-composition-mode
;;            better-jumper-local-mode
;;            diff-hl-amend-mode
;;            diff-hl-flydiff-mode
;;            diff-hl-mode
;;            display-line-numbers-mode
;;            dtrt-indent-mode
;;            eldoc-mode
;;            flycheck-mode
;;            flymake-mode
;;            flyspell-mode
;;            glasses-mode
;;            goto-address-mode
;;            goto-address-prog-mode
;;            hi-lock-mode
;;            highlight-changes-mode
;;            highlight-indent-guides-mode
;;            highlight-numbers-mode
;;            hl-fill-column-mode
;;            hl-line-mode
;;            hl-sexp-mode
;;            idle-highlight-mode
;;            linum-mode
;;            nlinum-mode
;;            prettify-symbols-mode
;;            rainbow-delimiters-mode
;;            smartparens-mode
;;            smartparens-strict-mode
;;            spell-fu-mode
;;            undo-tree-mode
;;            visual-line-mode
;;            whitespace-mode
;;            ws-butler-mode
;;            ))))

(use-package! -functions
  :no-require t
  :config
  (defun -refresh (&rest _)
    "TODO add `-refresh' as hook to `display-buffer'"
    (interactive)
    (ignore-errors (doom/reload-font))
    (when (region-active-p)
      (yas-new-snippet))

    (if (region-active-p)
        (yas-new-snippet)                          ;active
      (let* ((window-count (length (window-list))) ;inactive
             (one-window (eq window-count 1))
             (writeroom (featurep 'writeroom-room))
             (indirect-buffer (message "TODO")))
        (widen)
        (whitespace-cleanup)
        (bookmark-save)
        ;; (sh!! "git rev-parse --show-toplevel")
        (cond (one-window (cond
                           (writeroom
                            (writeroom-mode 1))
                           (t nil)))
              (t
               (cond (writeroom
                      (writeroom-mode -1))
                     (t nil))
               (balance-windows)))
        (cond ((eq major-mode 'python-mode)
               (unless (window--process-window-list)
                 (run-python nil nil t)))
              (t nil))
        (cond ((eq major-mode 'org-mode)
               (org-babel-tangle))
              (t (save-window-excursion (org-babel-detangle))))))
    (recentf-cleanup))

  (defun -clone-line-down (&rest args)
    (interactive "*p")
    (message "clone-line-up %s" (quote args))
    (save-excursion
      (beginning-of-line)
      (insert (buffer-substring (eol)(bol)) "\n")))

  (defun -clone-line-up ()
    (interactive "*p")
    (line! -1)
    (message "clone-line-down %s"))

  (defun -list (&rest list)
    (interactive
     (insert
      (completing-read "Insert filename:"
                       (-fd "-tf --max-depth=${_FD_MAX_DEPTH:-4} . $HOME/")))))

  (defun -fd (&rest ARGS)
    (let ((exe "fd")
          (prefix "/usr/bin/env -")
          (args (concat "--print0 --hidden")))
      (delete nil (split-string
                   (shell-command-to-string
                    (format "%s %s %s %s" prefix exe args (eval `(concat ,@ARGS))))
                   "\0"))))

  (defun -cmd-on-buffer (CMD)
    (shell-command-on-region (point-min) (point-max) CMD nil t))

  (defun -command-on-buffer (&rest list)
    (interactive
     (-cmd-on-buffer
      (completing-read
       "Apply script on buffer:"
       (split-string-and-unquote (shell-command-to-string "bash -c 'compgen -A command'"))))))

  (defun -script-on-buffer (&rest list)
    (interactive
     (-cmd-on-buffer
      (completing-read
       "Apply script on buffer:"
       (-fd "-tf -tx --max-depth=${_FD_MAX_DEPTH:-3} . $HOME/"))))))

(after! ob-async
  (setq ob-async-no-async-languages-alist '("ipython" "python")))

(ignore-errors
  (load-file (format "~/.%s.el" (getenv "HOSTNAME"))))

(defmacro sh! (CMDLINE)
  `(ignore-errors (string-trim
                   (shell-command-to-string (concat CMDLINE)))))
