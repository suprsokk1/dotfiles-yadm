;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(after! doom-ui
  (require '-functions nil t)
  (setq -reloaded (boundp '-reloaded)
        -toggle (boundp '-reloaded))
  (blink-cursor-mode 1)
  (global-hide-mode-line-mode 1)
  (set-frame-parameter nil 'alpha-background 100)
  ;; (set-frame-parameter nil 'alpha-background 90) ;uncomment to enable opacity
  ;; (add-to-list (quote so-long-minor-modes) (quote smartparens-mode))
  (setq-hook! (quote conf-mode-hook js-mode)
    display-line-numbers-type (quote absolute)))

;; EXAMPLE
(quote
 (setq doom-font            (font-spec :family "Input Mono Narrow" :size 12 :weight 'semi-light)
  doom-variable-pitch-font (font-spec :family "Fira Sans") ; inherits `doom-font''s :size
  doom-unicode-font        (font-spec :family "Input Mono Narrow" :size 12)
  doom-big-font            (font-spec :family "Fira Mono" :size 19)))

(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 13 :weight (quote light)))

  ;; (add-to-list 'default-frame-alist
;;              '(font . ""))

(set (quote +snippets-dir)
     (or (expand-file-name "snippets" (file-truename doom-user-dir))
         (expand-file-name "snippets" (expand-file-name doom-user-dir))))

(set (quote doom-theme)
     (quote doom-dracula))

(set (quote doom-scratch-initial-major-mode)
     (quote fundamental-mode))

(global-set-key (kbd "H-b") 'backward-word) ; H is for hyper

;; (set (quote doom-modeline-mode-alist) )

(mkdir "~/.local/emacs" t)

(set (quote custom-file)
     (expand-file-name "custom.el" "~/.local/emacs"))

;; (set (quote global-hide-mode-line-mode) 1)

;; (set (quote initial-buffer-choice)
;;      (or (expand-file-name "dashboard.org" doom-user-dir)
;;          (expand-file-name "todo.org" org-directory)))

(set (quote comint-move-point-for-output)
     t)

(set (quote doom-modeline-major-mode-icon)
     t)

;; (set (quote dired-listing-switches) "--ahl -v --group-directories-first")

(set (quote -dired-longopts)
     (mapconcat (quote symbol-name)
                (quote (--block-size=1
                        --group-directories-first
                        --human-readable
                        --no-group
                        --numeric-uid-gid
                        --ignore-backups
                        --color=never
                        --no-group)) " "))


(set (quote -dired-ignore)
     (concat "--ignore=*."
             (mapconcat (quote symbol-name)
                        (quote (zip gz)) " --ignore=*.")))

(set (quote dired-listing-switches)
     (concat -dired-ignore
             " "
             -dired-longopts))

(set (quote doom-projectile-cache-blacklist)
     (quote ("/tmp")))

(set (quote bookmark-default-file)
     (expand-file-name "_bookmarks.el" doom-user-dir))

(set (quote shift-select-mode)
     nil)

(set (quote display-line-numbers-type)
     nil)

(set-ligatures! (quote org-mode)
  :src_block "#+src_begin"
  :true "yes" :false "no"
  )

(plist-put! +ligatures-extra-symbols
  ;; org
  :name          "»"
  :src_block     "»"
  :src_block_end "«"
  :quote         "“"
  :quote_end     "”"
  ;; ;; Functional
  ;; :lambda        "λ"
  ;; :def           "ƒ"
  ;; :composition   "∘"
  ;; :map           "↦"
  ;; ;; Types
  ;; :null          "∅"
  ;; :true          "𝕋"
  ;; :false         "𝔽"
  ;; :int           "ℤ"
  ;; :float         "ℝ"
  ;; :str           "𝕊"
  ;; :bool          "𝔹"
  ;; :list          "𝕃"
  ;; ;; Flow
  ;; :not           "￢"
  ;; :in            "∈"
  ;; :not-in        "∉"
  ;; :and           "∧"
  ;; :or            "∨"
  ;; :for           "∀"
  ;; :some          "∃"
  ;; :return        "⟼"
  ;; :yield         "⟻"
  ;; ;; Other
  ;; :union         "⋃"
  ;; :intersect     "∩"
  ;; :diff          "∖"
  ;; :tuple         "⨂"
  ;; :pipe          "" ;; FIXME: find a non-private char
  ;; :dot           "•"
  )

;; (highlight-regexp
;;  (rx ?' ?\\  ?' ?')
;;  'hi-pink
;;  )

;; '\''

(quote
 (setq +ligatures-extra-alist
  (quote
   ((dired-mode
     ("rwx" . "7")
     ("rw-" . "6")
     ("r-x" . "5")
     ("r--" . "4")
     ("-wx" . "3")
     ("-r-" . "2")
     ("--x" . "1")
     ("---" . "0")
     )
    (emacs-lisp-mode
     ("lambda" . "λ")
     ("'\\\\''" . "⍞")
     )
    (org-mode
     ("#+BEGIN_QUOTE" . "“")
     ("#+BEGIN_SRC" . "»")
     ("#+END_QUOTE" . "”")
     ("#+END_SRC" . "«")
     ("#+NAME:" . "»")
     ("#+NAME:" . "»"))
    ("#+begin_quote" . "“")
    ("#+begin_src" . "»")
    ("#+end_quote" . "”")
    ("#+end_src" . "«")
    ("#+name:" . "»")
    ("no" . "𝔽")
    ("yes" . "𝕋")
    (sh-mode
     ("function" . "ƒ")
     ("true" . "𝕋")
     ("false" . "𝔽")
     ("!" . "￢")
     ("&&" . "∧")
     ("||" . "∨")
     ("in" . "∈")
     ("for" . "∀")
     ("return" . "⟼")
     ("." . "•")
     ("source" . "•")
     ("function" . "ƒ")
     ("true" . "𝕋")
     ("false" . "𝔽")
     ("!" . "￢")
     ("&&" . "∧")
     ("||" . "∨")
     ("in" . "∈")
     ("for" . "∀")
     ("return" . "⟼")
     ("." . "•")
     ("source" . "•")
     ("function" . "ƒ")
     ("true" . "𝕋")
     ("false" . "𝔽")
     ("!" . "￢")
     ("&&" . "∧")
     ("||" . "∨")
     ("in" . "∈")
     ("for" . "∀")
     ("return" . "⟼")
     ("." . "•")
     ("source" . "•")
     ("." . "•")
     ("return" . "⟼")
     ("for" . "∀")
     ("in" . "∈")
     ("||" . "∨")
     ("&&" . "∧")
     ("!" . "￢")
     ("false" . "𝔽")
     ("true" . "𝕋")
     ("function" . "ƒ"))
    (t)))))

(after! python
  (set (quote +python-ipython-repl-args)
       (quote ("-i" "--simple-prompt" "--no-color-info")))

  (set (quote +python-jupyter-repl-args)
       (quote ("--simple-prompt"))))

(after! org
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
           (unless (string= "-" (projectile-project-name))
             (recompile))))
  (eval (assoc-default major-mode -compile)))

(defun M-RET! (&rest BODY)
  "Default M-RET action"
  (interactive)
  (let ((compile-command (format "command /usr/bin/env , %s" (buffer-file-name))))
    (recompile)))

(defvar -compile
  (quote
     ;; EXPECT / TCL
   ((tcl-mode . (recompile))

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
                            (-get-buffer python-shell-buffer-name))))))))))

(global-set-key (kbd "M-RET") #'M-RET!)
(global-set-key (kbd "s-p") (quote projectile-find-file))

(map!
 "<f12>"           #'flycheck-list-errors
 "<f5>"            #'call-last-kbd-macro
 "C-."             #'mc/mark-next-like-this
 "C-<iso-lefttab>" #'flycheck-previous-error
 "C-<tab>"         #'flycheck-next-error
 "C-c SPC SPC"     #'-refresh
 "H-."             #'dired-jump
 "H-/"             #'+default/search-buffer
 "H-0"             #'balance-windows
 "H-8"             #'-mark-all-like-this
 "H-;"             #'company-yasnippet
 "H-<backspace>"   #'delete-pair
 "H-<down>"        #'-clone-line-down "s-<down>"        #'-clone-line-down
 "H-<return>"      #'bookmark-jump
 "H-<up>"          #'-clone-line-up "s-<up>" #'-clone-line-up
 "H-M-0"           #'balance-windows-area
 "H-M-["           #'winner-undo
 "H-M-]"           #'winner-redo
 "H-M-k"           #'doom/kill-this-buffer-in-all-windows
 "H-M-l"           #'toggle-truncate-lines
 "H-M-n"           #'split-window-vertically
 "H-M-p"           #'projectile-switch-project
 "H-SPC ."         #'dired-jump
 "H-SPC H-SPC"     #'-refresh
 "H-SPC H-q"       #'delete-other-frames
 "H-SPC TAB" (cmd! (find-file initial-buffer-choice))
 "H-SPC ["         #'mc/edit-beginnings-of-lines
 "H-SPC ]"         #'mc/edit-enda-of-lines
 "H-SPC a"         #'mc/edit-beginnings-of-lines
 "H-SPC b"         #'doom-big-font-mode
 "H-SPC c"         #'doom/goto-private-config-file
 "H-SPC e"         #'mc/edit-enda-of-lines
 "H-SPC h"         #'(cmd! (dired "~"))
 "H-SPC l"         #'-open-library-of-babel
 "H-SPC m"         #'mc/mark-all-like-this ;FIXME
 "H-SPC n"         #'org-capture
 "H-SPC q"         #'delete-other-windows
 "H-SPC r" nil
 "H-SPC s"         #'org-narrow-to-subtree
 "H-SPC x"         #'doom/open-scratch-buffer
 "H-SPC ~"         #'(cmd! (dired "~"))
 "H-["             #'undo
 "H-]"             #'undo-redo
 "H-g"             #'magit-status
 "H-i f"           #'+default/insert-file-path
 "H-k"             #'delete-window
 "H-l"             #'display-line-numbers-mode
 "H-m"             #'+zen/toggle-fullscreen
 "H-n"             #'split-window-horizontally
 "H-p"             #'projectile-find-file
 "H-{"             #'flycheck-previous-error
 "H-}"             #'flycheck-next-error
 "M-["             #'previous-error
 "M-]"             #'next-error
 "M-s-0"           #'balance-windows-area
 "M-s-<return>"    #'org-roam-node-find
 "M-s-["           #'winner-undo
 "M-s-]"           #'winner-redo
 "M-s-k"           #'doom/kill-this-buffer-in-all-windows
 "M-s-l"           #'toggle-truncate-lines
 "M-s-n"           #'split-window-vertically
 "s-."             #'dired-jump
 "s-/"             #'+default/search-buffer
 "s-0"             #'balance-windows
 "s-8"             #'-mark-all-like-this
 "s-;"             #'company-yasnippet
 "s-<backspace>"   #'delete-pair

 "s-<return>"      #'bookmark-jump

 "s-M-k"           #'doom/kill-this-buffer-in-all-windows
 "s-M-p"           #'projectile-switch-project
 "s-SPC ."         #'dired-jump
 "s-SPC TAB"       #'(cmd! (find-file initial-buffer-choice))
 "s-SPC ["         #'mc/edit-beginnings-of-lines
 "s-SPC ]"         #'mc/edit-enda-of-lines
 "s-SPC a"         #'mc/edit-beginnings-of-lines
 "s-SPC b"         #'doom-big-font-mode
 "s-SPC c"         #'doom/goto-private-config-file
 "s-SPC e"         #'mc/edit-enda-of-lines
 "s-SPC h"         #'(cmd! (dired "~"))
 "s-SPC q"         #'delete-other-windows
 "s-SPC r"         nil
 "s-SPC s"         #'org-narrow-to-subtree
 "s-SPC s-SPC"     #'-refresh
 "s-SPC s-q"       #'delete-other-frames
 "s-SPC x"         #'doom/open-scratch-buffer
 "s-SPC ~"         #'(cmd! (dired "~"))
 "s-["             'undo
 "s-]"             'undo-redo
 "s-g"             #'magit-status
 "s-i f"           #'+default/insert-file-path
 "s-k"             #'delete-window
 "s-l"             #'display-line-numbers-mode
 "s-m s-m"         #'mc/mark-all-like-this
 "s-n"             #'split-window-horizontally
 "s-p"             #'projectile-find-file
 )
 ;; "H-SPC i" #'doom/goto-private-init-file
 ;; "H-SPC p" #'doom/goto-private-packages-file
 ;; "s-SPC i" #'doom/goto-private-init-file
 ;; "s-SPC p" #'doom/goto-private-packages-file
(after! conf-mode
  (highlight-phrase "bindsym" 'bold )
  ;; (highlight-phrase "")
  )

(map!
 (:after dired :map dired-mode-map
         "r" #'dired-do-rename-regexp)
 (:map global-map
       "H-r" #'consult-buffer
       "s-r" #'consult-buffer
       "H-M-k" #'doom/kill-this-buffer-in-all-windows
       "M-s-k" #'doom/kill-this-buffer-in-all-windows
       (:prefix "H-SPC"
                "i" nil
                "H-q" #'delete-other-windows
                (:prefix "i"
                         "f" #'-list
                         "u" #'insert-char)
                "H-a" (cmd! (org-agenda nil "t"))
                ))

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
                "." #'dired-mark-files-containing-regexp))

 (:mode multiple-cursors-mode
  :prefix "s-SPC"
        )

 (:mode multiple-cursors-mode
  :prefix "H-SPC"
  "c" 'mc/insert-numbers
  )

 (:mode multiple-cursors-mode
  :prefix "s-m"
  "c" 'mc/insert-numbers
  "l" 'mc/insert-letters
  )
 (:mode multiple-cursors-mode
  :prefix "H-m"
  "c" 'mc/insert-numbers
  )
 )

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

;; (use-package! ob-shell
;;   :custom
;;   (org-babel-shell-names (quote "sh tmux bash zsh fish csh ash dash ksh mksh posh")))

(use-package! org
  :requires ob-shell
  :config (progn
            (defun my/org-mode-hook ()
              (setq truncate-lines t
                    display-line-numbers-mode -1)))
  :hook ((org-mode . my/org-mode-hook))
  :config

  (add-to-list (quote org-babel-shell-names)
               (quote "tmux"))
  (add-to-list (quote so-long-minor-modes)
               (quote display-line-numbers-mode))

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
  :load-path "~/src/modus-themes"
  :config (modus-themes-select 'modus-vivendi-tinted)
  :custom
  (modus-themes-variable-pitch-ui t)
  (modus-themes-to-toggle (quote (modus-operandi-tinted modus-vivendi-tinted))))

(use-package! writeroom
  :no-require t
  :bind (("s-SPC w" . #'writeroom-mode)
         ("H-SPC w" . #'writeroom-mode)))

(use-package! vterm
  :defer 10
  :bind (("H-\\" . #'+vterm/toggle)
         ("s-\\" . #'+vterm/toggle))
  :custom
  (vterm-shell "/bin/zsh"))

(use-package! flycheck
  :custom
  (flycheck-mode-hook nil))

(use-package tramp
  :init
  (defun yadm ()
    (interactive)
    (magit-status "/yadm::"))
  :config
  (add-to-list (quote tramp-methods)
               (quote ("yadm"
                       (tramp-login-program "yadm")
                       (tramp-login-args (("enter")))
                       (tramp-login-env (("SHELL") ("/bin/sh")))
                       (tramp-remote-shell "/bin/sh")
                       (tramp-remote-shell-args ("-c"))))))

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
