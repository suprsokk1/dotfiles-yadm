;;; $DOOMDIR/config.el -*- mode: emacs-lisp; lexical-binding: t; -*-

;; TODO focus-{in,out}-hook is depricated, find replacement
;; TODO sway-mode
;; TODO magit + yadm: list todos, but limit to files git
;; TODO change alpha when loosing frame focus ()

(setq! display-line-numbers-type        nil

       query-all-font-backends         t

       custom-file                     (expand-file-name "custom.el" (dir!))

       frame-title-format              "%b %f"

       ;; header-line-format              "%b %V" ;(quote ("%e" (:eval)))
       header-line-format              nil ;(quote ("%e" (:eval)))

       shift-select-mode               nil

       comint-move-point-for-output    t

       +snippets-dir                   (or (expand-file-name "snippets" (file-truename doom-user-dir))
                                           (expand-file-name "snippets" (expand-file-name doom-user-dir)))

       async-bytecomp-package-mode      t

       doom-modeline-major-mode-icon      t

       org-log-state-notes-into-drawer    t

       initial-buffer-choice            (or initial-buffer-choice
                                            (expand-file-name "dashboard.org" doom-user-dir))

       doom-scratch-initial-major-mode (quote fundamental-mode)

       doom-projectile-cache-blacklist (quote "/tmp")

       bookmark-default-file           (expand-file-name "_bookmarks.el" doom-user-dir)

       compile-command                   "~/bin/c"


       vterm-shell                       "/bin/zsh"

       global-hl-line-mode              -1

       company-minimum-prefix-length     2   ;performance
       company-idle-delay                2   ;wait n secs before rendering completion

       doom-font                         (font-spec :family  "Iosevka Nerd Font Mono"
                                                    :foundry "UKWN"
                                                    :slant   'normal
                                                    :weight  'light
                                                    :height   98
                                                    :width   'normal)

       doom-big-font                    (font-spec :family  "Iosevka Nerd Font Mono"
                                                   :foundry "UKWN"
                                                   :slant   'normal
                                                   :weight  'light
                                                   :height  1.5
                                                   :width   'normal)
       )

;;; `workflow'
;;; jump to *scratch* buffer split words into lines
;;; -activate multiple-cursors
(setq-hook! 'fundamental-mode
  fill-column 1)

(setq-hook! '(prog-mode text-mode)
  fill-column 80)

(setq-hook! 'comint-mode-hook
  comint-buffer-maximum-size    20000   ; Increase comint buffer size.
  comint-prompt-read-only       t)      ; Make the prompt read only.


;; https://github.com/hlissner/.doom.d/blob/6af0a541e0b6b6ec9aee4cb9f05e5cbec0800d91/config.el
(add-to-list
 'default-frame-alist '(inhibit-double-buffering . t))

(quote (let ((ELC (file-expand-wildcards (concat (expand-file-name "conf.d" (dir!)) "/*.elc"))))
        (mapc #'load-file ELC)))

(defmacro dir!! (NAME)
  `(expand-file-name ,NAME (dir!)))

(defmacro load!! (NAME)
  `(expand-file-name ,NAME (dir!)))

(load-file
 (nth 0 (file-expand-wildcards (concat (dir!! "conf.d") "/*refresh*.el"))))

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

(after! dired
  (setq! dired-mode-hook
         '(doom--recentf-add-dired-directory-h
           +dired-disable-gnu-ls-flags-maybe-h
           dired-omit-mode
           nerd-icons-dired-mode
           diredfl-mode))

  (map!
   "H-SPC /" #'dired-jump
   "s-SPC /" #'dired-jump
   (:map dired-mode-map
         ;; "D"   (cmd! (quote (dired-)))  ;NOTE dired cleanup?
         "/" nil
         ;; "/ ." #'dired-mark-files-regexp
         "/ ." (cmd! (dired-))
         ;; (:prefix "h"
         ;;          "h" (cmd! (dired "~")))

         (:prefix ","
                  ","   #'dired-unmark-all-marks)

         "."   #'dired-up-directory
         "["   #'dired-prev-marked-file
         "]"   #'dired-next-marked-file
         ;; "~"   (cmd! dired "~")
         "~"   nil
         "r"   #'dired-do-rename-regexp
         "s-." #'dired-jump)))

(map!
 "<f12>" #'flycheck-list-errors
 "<f5>" #'call-last-kbd-macro
 "C-." #'mc/mark-next-like-this
 "C-<iso-lefttab>" #'flycheck-previous-error
 "C-<tab>" #'flycheck-next-error
 "C-c SPC SPC" #'-refresh
 "C-c m m" 'mc/mark-all-like-this
 "H-/" #'+default/search-buffer
 "H-0" #'balance-windows
 
 "H-<backspace>" #'delete-pair
 "H-<down>" #'-clone-line-down "s-<down>" #'-clone-line-down
 "H-<return>" #'bookmark-jump
 "H-<up>" #'-clone-line-up "s-<up>" #'-clone-line-up
 "H-M-0" #'balance-windows-area
 "H-M-[" #'winner-undo
 "H-M-]" #'winner-redo
 "H-M-k" #'doom/kill-this-buffer-in-all-windows
 "H-M-k" #'doom/kill-this-buffer-in-all-windows
 "H-M-l" #'toggle-truncate-lines
 "H-M-n" #'split-window-vertically
 "H-M-p" #'projectile-switch-project
 "H-SPC y Y" #'+default/yank-buffer-contents
 "H-SPC y y" #'+default/yank-buffer-path-relative-to-project
 "H-[" #'undo
 "H-\\" #'+vterm/toggle
 "H-]" #'undo-redo
 "H-e" #'windmove-right
 "H-g" #'magit-status
 "H-i f" #'+default/insert-file-path
 "H-k" #'delete-window
 "H-m" #'+zen/toggle-fullscreen
 "H-n" #'split-window-horizontally
 "H-p" #'projectile-find-file
 "H-q" #'windmove-left
 "H-r" #'consult-buffer
 "H-s" #'windmove-down
 "H-w" #'windmove-up
 "H-{" #'flycheck-previous-error
 "H-}" #'flycheck-next-error
 "M-H-e" #'windmove-swap-states-right
 "M-H-q" #'windmove-swap-states-left
 "M-H-s" #'windmove-swap-states-down
 "M-H-w" #'windmove-swap-states-up
 "M-[" #'previous-error
 "M-]" #'next-error
 "M-o l" #'highlight-lines-matching-regexp
 "M-o r" #'highlight-regexp
 "M-o w" #'highlight-phrase
 "M-s-0" #'balance-windows-area
 "M-s-<return>" #'org-roam-node-find
 "M-s-[" #'winner-undo
 "M-s-]" #'winner-redo
 "M-s-e" #'windmove-swap-states-right
 "M-s-k" #'doom/kill-this-buffer-in-all-windows
 "M-s-k" #'doom/kill-this-buffer-in-all-windows
 "M-s-l" #'toggle-truncate-lines
 "M-s-n" #'split-window-vertically
 "M-s-q" #'windmove-swap-states-left
 "M-s-s" #'windmove-swap-states-down
 "M-s-w" #'windmove-swap-states-up
 "s-/" #'+default/search-buffer
 "s-0" #'balance-windows
 "s-8"             (lambda (&rest BODY) (interactive)(isearch-forward-symbol-at-point)(apply (quote occur) BODY))
 
 "s-<backspace>" #'delete-pair
 "s-<return>" #'bookmark-jump
 "s-M-k" #'doom/kill-this-buffer-in-all-windows
 "s-M-p" #'projectile-switch-project
 "s-["             'undo
 "s-\\" #'+vterm/toggle
 "s-]"             'undo-redo
 "s-e" #'windmove-right
 "s-g" #'magit-status
 "s-i f" #'+default/insert-file-path
 "s-k" #'delete-window
 
 "s-m s-m" #'mc/mark-all-like-this
 "s-n" #'split-window-horizontally
 "s-p" #'projectile-find-file
 "s-q" #'windmove-left
 "s-r" #'consult-buffer
 "s-s" #'windmove-down
 "s-w" #'windmove-up
 ;; "H-8" #'-mark-all-like-this
 ;; "s-8" #'(cmd! (isearch-forward-symbol-at-point)(occur))
 ;; "s-8" #'-mark-all-like-this

 (:prefix "s-SPC"
          "m"   #'+zen/toggle-fullscreen
          "SPC" #'org-roam-node-find

          "TAB" #'(cmd! (find-file initial-buffer-choice))
          "["   #'mc/edit-beginnings-of-lines
          "]"   #'mc/edit-enda-of-lines
          "a"   #'mc/edit-beginnings-of-lines
          "b"   #'doom-big-font-mode
          "c"   #'doom/goto-private-config-file
          "e"   #'mc/edit-enda-of-lines

          "n" (cmd! (org-capture ))
          "q" #'delete-other-windows
          "r" nil
          "s" #'org-narrow-to-subtree
          "s-SPC" #'-refresh
          "s-q" #'delete-other-frames
          "x" #'doom/open-scratch-buffer)

 (:prefix "H-SPC"

          "H-SPC" #'-refresh
          "H-q" #'delete-other-frames
          "TAB" #'(cmd! (find-file initial-buffer-choice))
          "[" #'mc/edit-beginnings-of-lines
          "]" #'mc/edit-enda-of-lines
          "a" #'mc/edit-beginnings-of-lines
          "b" #'doom-big-font-mode
          "c" #'doom/goto-private-config-file
          "e" #'mc/edit-enda-of-lines

          "l" #'-open-library-of-babel
          "m" #'mc/mark-all-like-this ;FIXME
          "n" #'org-capture
          "q" #'delete-other-windows
          "r"         nil
          "s" #'org-narrow-to-subtree
          "x" #'doom/open-scratch-buffer
          )

 "M-o l" #'highlight-lines-matching-regexp
 "M-o r" #'highlight-regexp
 "M-o w" #'highlight-phrase

 "<f12>" #'flycheck-list-errors
 "<f5>" #'call-last-kbd-macro
 "C-." #'mc/mark-next-like-this
 "C-<iso-lefttab>" #'flycheck-previous-error
 "C-<tab>" #'flycheck-next-error
 "C-c SPC SPC" #'-refresh

 "H-/" #'+default/search-buffer
 "H-0" #'balance-windows
 ;; "H-8" #'-mark-all-like-this
 ;; "s-8" #'(cmd! (isearch-forward-symbol-at-point)(occur))
 "s-8"             (lambda (&rest BODY) (interactive)(isearch-forward-symbol-at-point)(apply (quote occur) BODY))
 
 "H-<backspace>" #'delete-pair
 "H-<down>" #'-clone-line-down "s-<down>" #'-clone-line-down
 "H-<return>" #'bookmark-jump
 "H-<up>" #'-clone-line-up "s-<up>" #'-clone-line-up
 "H-M-0" #'balance-windows-area
 "H-M-[" #'winner-undo
 "H-M-]" #'winner-redo
 "H-M-k" #'doom/kill-this-buffer-in-all-windows
 "H-M-l" #'toggle-truncate-lines
 "H-M-n" #'split-window-vertically
 "H-M-p" #'projectile-switch-project
 "H-[" #'undo
 "H-]" #'undo-redo
 "H-g" #'magit-status
 "H-i f" #'+default/insert-file-path
 "H-k" #'delete-window
 
 "H-m" #'+zen/toggle-fullscreen
 "H-n" #'split-window-horizontally
 "H-p" #'projectile-find-file
 "H-{" #'flycheck-previous-error
 "H-}" #'flycheck-next-error
 "M-[" #'previous-error
 "M-]" #'next-error
 "M-s-0" #'balance-windows-area
 "M-s-<return>" #'org-roam-node-find
 "M-s-[" #'winner-undo
 "M-s-]" #'winner-redo
 "M-s-k" #'doom/kill-this-buffer-in-all-windows
 "M-s-l" #'toggle-truncate-lines
 "M-s-n" #'split-window-vertically

 "s-/" #'+default/search-buffer
 "s-0" #'balance-windows
 ;; "s-8" #'-mark-all-like-this
 
 "s-<backspace>" #'delete-pair
 "s-<return>" #'bookmark-jump
 "s-M-k" #'doom/kill-this-buffer-in-all-windows
 "s-M-p" #'projectile-switch-project

 "s-["             'undo
 "s-]"             'undo-redo
 "s-g" #'magit-status
 "s-i f" #'+default/insert-file-path
 "s-k" #'delete-window
 
 "s-m s-m" #'mc/mark-all-like-this
 "s-n" #'split-window-horizontally
 "s-p" #'projectile-find-file

 (:prefix "s-SPC"
          "m"         '+zen/toggle-fullscreen
          "SPC" #'org-roam-node-find

          "TAB" #'(cmd! (find-file initial-buffer-choice))
          "[" #'mc/edit-beginnings-of-lines
          "]" #'mc/edit-enda-of-lines
          "a" #'mc/edit-beginnings-of-lines
          "b" #'doom-big-font-mode
          "c" #'doom/goto-private-config-file
          "e" #'mc/edit-enda-of-lines

          "n" #'org-capture
          "q" #'delete-other-windows
          "r"         nil
          "s" #'org-narrow-to-subtree
          "s-SPC" #'-refresh
          "s-q" #'delete-other-frames
          "x" #'doom/open-scratch-buffer)

 (:prefix "H-SPC"

          "H-SPC" #'-refresh
          "H-q" #'delete-other-frames
          "TAB" #'(cmd! (find-file initial-buffer-choice))
          "[" #'mc/edit-beginnings-of-lines
          "]" #'mc/edit-enda-of-lines
          "a" #'mc/edit-beginnings-of-lines
          "b" #'doom-big-font-mode
          "c" #'doom/goto-private-config-file
          "e" #'mc/edit-enda-of-lines

          "l" #'-open-library-of-babel
          "m" #'mc/mark-all-like-this ;FIXME
          "n" #'org-capture
          "q" #'delete-other-windows
          "r"         nil
          "s" #'org-narrow-to-subtree
          "x" #'doom/open-scratch-buffer
          )

 "H-r" #'consult-buffer
 "s-r" #'consult-buffer
 "H-M-k" #'doom/kill-this-buffer-in-all-windows
 "M-s-k" #'doom/kill-this-buffer-in-all-windows
 "H-\\" #'+vterm/toggle
 "s-\\" #'+vterm/toggle
 "M-o l" #'highlight-lines-matching-regexp
 "M-o r" #'highlight-regexp
 "M-o w" #'highlight-phrase
 "s-q" #'windmove-left
 "s-e" #'windmove-right
 "s-w" #'windmove-up
 "s-s" #'windmove-down
 "H-q" #'windmove-left
 "H-e" #'windmove-right
 "H-w" #'windmove-up
 "H-s" #'windmove-down
 "M-s-q" #'windmove-swap-states-left
 "M-H-q" #'windmove-swap-states-left
 "M-s-e" #'windmove-swap-states-right
 "M-H-e" #'windmove-swap-states-right
 "M-s-w" #'windmove-swap-states-up
 "M-H-w" #'windmove-swap-states-up
 "M-s-s" #'windmove-swap-states-down
 "M-H-s" #'windmove-swap-states-down
 "C-c m m" 'mc/mark-all-like-this

 "<f12>" #'flycheck-list-errors
 "<f5>" #'call-last-kbd-macro
 "C-." #'mc/mark-next-like-this
 "C-<iso-lefttab>" #'flycheck-previous-error
 "C-<tab>" #'flycheck-next-error
 "C-c SPC SPC" #'-refresh

 "H-/" #'+default/search-buffer
 "H-0" #'balance-windows
 ;; "H-8" #'-mark-all-like-this
 ;; "s-8" #'(cmd! (isearch-forward-symbol-at-point)(occur))
 "s-8"             (lambda (&rest BODY) (interactive)(isearch-forward-symbol-at-point)(apply (quote occur) BODY))
 "H-;" #'company-yasnippet
 "H-<backspace>" #'delete-pair
 "H-<down>" #'-clone-line-down "s-<down>" #'-clone-line-down
 "H-<return>" #'bookmark-jump
 "H-<up>" #'-clone-line-up "s-<up>" #'-clone-line-up
 "H-M-0" #'balance-windows-area
 "H-M-[" #'winner-undo
 "H-M-]" #'winner-redo
 "H-M-k" #'doom/kill-this-buffer-in-all-windows
 "H-M-l" #'toggle-truncate-lines
 "H-M-n" #'split-window-vertically
 "H-M-p" #'projectile-switch-project

 "H-[" #'undo
 "H-]" #'undo-redo
 "H-g" #'magit-status
 "H-i f" #'+default/insert-file-path
 "H-k" #'delete-window
 "H-l" #'display-line-numbers-mode
 "H-m" #'+zen/toggle-fullscreen
 "H-n" #'split-window-horizontally
 "H-p" #'projectile-find-file
 "H-{" #'flycheck-previous-error
 "H-}" #'flycheck-next-error
 "M-[" #'previous-error
 "M-]" #'next-error
 "M-s-0" #'balance-windows-area
 "M-s-<return>" #'org-roam-node-find
 "M-s-[" #'winner-undo
 "M-s-]" #'winner-redo
 "M-s-k" #'doom/kill-this-buffer-in-all-windows
 "M-s-l" #'toggle-truncate-lines
 "M-s-n" #'split-window-vertically

 "s-/" #'+default/search-buffer
 "s-0" #'balance-windows
 ;; "s-8" #'-mark-all-like-this
 "s-;" #'company-yasnippet
 "s-<backspace>" #'delete-pair
 "s-<return>" #'bookmark-jump
 "s-M-k" #'doom/kill-this-buffer-in-all-windows
 "s-M-p" #'projectile-switch-project

 "s-["             'undo
 "s-]"             'undo-redo
 "s-g" #'magit-status
 "s-i f" #'+default/insert-file-path
 "s-k" #'delete-window
 "s-l" #'display-line-numbers-mode
 "s-m s-m" #'mc/mark-all-like-this
 "s-n" #'split-window-horizontally
 "s-p" #'projectile-find-file

 (:prefix
  "s-SPC"
  "m"         '+zen/toggle-fullscreen
  "SPC" #'org-roam-node-find

  ;; "TAB" #'(cmd! (find-file initial-buffer-choice))
  "TAB" nil
  "["   #'mc/edit-beginnings-of-lines
  "]" #'mc/edit-enda-of-lines
  "a" #'mc/edit-beginnings-of-lines
  "b" #'doom-big-font-mode
  "c" #'doom/goto-private-config-file
  "e" #'mc/edit-enda-of-lines

  "n" #'org-capture
  "q" #'delete-other-windows
  "r"         nil
  "s" #'org-narrow-to-subtree
  "s-SPC" #'-refresh
  "s-q" #'delete-other-frames
  "x" #'doom/open-scratch-buffer

  )

 (:prefix "H-SPC"
          "H-SPC" #'-refresh
          "H-q" #'delete-other-frames
          "TAB" #'(cmd! (find-file initial-buffer-choice))
          "[" #'mc/edit-beginnings-of-lines
          "]" #'mc/edit-enda-of-lines
          "a" #'mc/edit-beginnings-of-lines
          "b" #'doom-big-font-mode
          "c" #'doom/goto-private-config-file
          "e" #'mc/edit-enda-of-lines

          "l" #'-open-library-of-babel
          "m" #'mc/mark-all-like-this ;FIXME
          "n" #'org-capture
          "q" #'delete-other-windows
          "r" nil
          "s" #'org-narrow-to-subtree
          "x" #'doom/open-scratch-buffer)

 "s-." nil

 ;; "s-." #'dired-jump

 (:map emacs-lisp-mode-map
       "C-M-<right>" nil
       "M-<right>"   nil
       "M-<right>"   #'forward-sexp
       "M-<left>"    nil
       "M-<left>"    #'backward-sexp
       )
 )

(global-set-key (kbd "H-g")        #'magit-status)
(global-set-key (kbd "s-g")        #'magit-status)
(global-set-key (kbd "M-RET")      #'M-RET!)
(global-set-key (kbd "M-<return>") #'M-RET!)

(global-set-key (kbd "H-SPC .") #'-occur)
(global-set-key (kbd "s-SPC .") #'-occur)

(global-set-key (kbd "M-RET") #'M-RET!)
(global-set-key (kbd "M-<return>") #'M-RET!)

(global-set-key (kbd "s-t") #'+treemacs/toggle)
(global-set-key (kbd "H-t") #'+treemacs/toggle)

(global-set-key (kbd "H-b") 'backward-word) ; H = Hyper modifier

(global-set-key (kbd "s-b") 'backward-word) ; H = Hyper modifier

(global-set-key (kbd "s-p") (quote projectile-find-file))
(global-set-key (kbd "H-p") (quote projectile-find-file))

(global-set-key (kbd "s-SPC l") (quote +emacs-lisp/open-repl))
(global-set-key (kbd "H-SPC l") (quote +emacs-lisp/open-repl))

(global-set-key (kbd "s-SPC w") (quote ace-swap-window))
(global-set-key (kbd "H-SPC w") (quote ace-swap-window))

(global-set-key (kbd "s-SPC t") (quote +tmux/send-region))
(global-set-key (kbd "H-SPC t") (quote +tmux/send-region))

(global-set-key (kbd "s-SPC g") (quote magit-status))
(global-set-key (kbd "H-SPC g") (quote +tmux/send-region))

(map! :map org-agenda-mode-map "RET" #'org-agenda-goto) ;original: org-agenda-switch-to

(map! (:prefix  "H-SPC" "h" #'+default/man-or-woman)
      (:prefix "s-SPC"  "h" #'+default/man-or-woman)
      )

(map!
 "C-;" #'+company/complete
 "s-=" #'doom/increase-font-size
 "s--" #'doom/decrease-font-size
 "H-=" #'doom/increase-font-size
 "H--" #'doom/decrease-font-size
 "s-." (cmd!
        (let ((w (window-buffer))
              (n (buffer-file-name))
              (s (symbol-at-point))
              (c "~/bin/c emacs_super_dot_callback"))
          (shell-command
           (concat "echo " (string-join (list n s) " ")))))
 )

`(quote
 (defun advice/indent-for-tab-command (funcname &rest arguments)
  (apply funcname arguments))

 (advice-add 'indent-for-tab-command :around 'advice/indent-for-tab-command)
 (advice-remove 'indent-for-tab-command 'advice/indent-for-tab-command)
 )

;; (map! :desc ""  "<f11>" nil )

;; `(quote
;;   A convenience macro for defining keybinds, powered by `general'.

;;   If evil isn't loaded, evil-specific bindings are ignored.

;;   Properties
;;   :leader [...]                   an alias for (:prefix doom-leader-key ...)
;;   :localleader [...]              bind to localleader; requires a keymap
;;   :mode [MODE(s)] [...]           inner keybinds are applied to major MODE(s)
;;   :map [KEYMAP(s)] [...]          inner keybinds are applied to KEYMAP(S)
;;   :prefix [PREFIX] [...]          set keybind prefix for following keys. PREFIX
;;   can be a cons cell: (PREFIX . DESCRIPTION)
;;   :prefix-map [PREFIX] [...]      same as :prefix, but defines a prefix keymap
;;   where the following keys will be bound. DO NOT
;;   USE THIS IN YOUR PRIVATE CONFIG.
;;   :after [FEATURE] [...]          apply keybinds when [FEATURE] loads
;;   :textobj KEY INNER-FN OUTER-FN  define a text object keybind pair
;;   :when [CONDITION] [...]
;;   :unless [CONDITION] [...]

;;   Any of the above properties may be nested, so that they only apply to a
;;   certain group of keybinds.

;;   States
;;   :n  normal
;;   :v  visual
;;   :i  insert
;;   :e  emacs
;;   :o  operator
;;   :m  motion
;;   :r  replace
;;   :g  global  (binds the key without evil `current-global-map')

;;   These can be combined in any order, e.g. :nvi will apply to normal, visual and
;;   insert mode. The state resets after the following key=>def pair. If states are
;;   omitted the keybind will be global (no emacs state; this is different from
;;                                          evil's Emacs state and will work in the absence of `evil-mode').

;;   These must be placed right before the key string.

;;   Do
;;   (map! :leader :desc "Description" :n "C-c" #'dosomething)
;;   Don't
;;   (map! :n :leader :desc "Description" "C-c" #'dosomething)
;;   (map! :leader :n :desc "Description" "C-c" #'dosomething)
;;   )


(map!
 "M-RET" nil
 "M-<return>" nil

 ;; "f"    nil
 ;; "f"    #'self-insert-command

 )

(defmacro -re-elisp (REGEX &rest BODY)
  `(with-temp-buffer
     (insert (with-output-to-string (princ ,@BODY)))
     (re-search-backward (or ,REGEX (eval ,REGEX)) nil t)))

`(quote
  (defmacro default! (SYMBOL &optional DEFAULT)
    `(or
      (or (bound-and-true-p ,SYMBOL)
          (bound-and-true-p ,DEFAULT)
          (ignore-errors (default-value (quote ,SYMBOL))))))

  (defun shell! (COMMAND &optional ASYNC SPLIT OUTBUF ERRBUF)
    "`SPLIT': split window (default: false)"
    (let ((ASYNC (default! ASYNC t))
          (SPLIT (default! SPLIT nil))
          (OUTBUF (default! OUTBUF ))
          (ERRBUF (default! ERRBUF )))
      )))

;; (default! bar 'baz)

(map!
 ;; :after python-mode
 :map python-mode-map

 ;; "TAB" nil
 ;; "TAB" '+company/complete
 ;; "TAB" #'indent-for-tab-command

 ;; "<right>" (cmd! (apply python-indent-shift-right (flatten-list (list (region-bounds) ))))

 "M-<return>"  (cmd!
                (message "%S"
                         (let ((COMMAND (concat (getenv "HOME") "/bin/c callback")))
                           (save-window-excursion
                            (async-shell-command COMMAND))))

                ;; (message (if (eq major-mode 'python-mode)
                ;;              (progn
                ;;                ;; (interactive)
                ;;                ;; (run-python)
                ;;                (let ((BUFFER (format "*%s*" python-shell-buffer-name)))
                ;;                  ;; (with-temp-buffer (switch-to-buffer BUFFER)
                ;;                  ;;                   (erase-buffer))
                ;;                  (unless (-re-elisp BUFFER (window-list))
                ;;                    (switch-to-buffer-other-window BUFFER)))

                ;;                (python-shell-send-file (buffer-file-name))

                ;;                ;; (python-shell-restart t)
                ;;                ;; (save-window-excursion (python-shell-restart nil))
                ;;                ;; (other-window (previous-window))

                ;;                "whoppie")
                ;;            "wtf?"))
                )

 )

(setq! vterm-shell "/bin/tmux")

(map! ;:mode vterm-mode
      :map vterm-mode-map
      "<wheel-up>"      nil
      "<wheel-down>"    nil
      "<-wheel-up>"      nil
      "<-wheel-down>"    nil
      "<tripple-wheel-up>"      nil
      "<tripple-wheel-down>"    nil

      "<header-line> <mouse-4>" nil
      "<header-line> <mouse-5>" nil
      "<header-line> <mouse-6>" nil
      "<header-line> <mouse-7>" nil
      "<header-line> <wheel-down>" nil
      "<header-line> <wheel-left>" nil
      "<header-line> <wheel-right>" nil
      "<header-line> <wheel-up>" nil
      "<horizontal-scroll-bar> <mouse-4>" nil
      "<horizontal-scroll-bar> <mouse-5>" nil
      "<horizontal-scroll-bar> <mouse-6>" nil
      "<horizontal-scroll-bar> <mouse-7>" nil
      "<horizontal-scroll-bar> <wheel-down>" nil
      "<horizontal-scroll-bar> <wheel-left>" nil
      "<horizontal-scroll-bar> <wheel-right>" nil
      "<horizontal-scroll-bar> <wheel-up>" nil
      "<left-fringe> <mouse-4>" nil
      "<left-fringe> <mouse-5>" nil
      "<left-fringe> <mouse-6>" nil
      "<left-fringe> <mouse-7>" nil
      "<left-fringe> <wheel-down>" nil
      "<left-fringe> <wheel-left>" nil
      "<left-fringe> <wheel-right>" nil
      "<left-fringe> <wheel-up>" nil
      "<left-margin> <mouse-4>" nil
      "<left-margin> <mouse-5>" nil
      "<left-margin> <mouse-6>" nil
      "<left-margin> <mouse-7>" nil
      "<left-margin> <wheel-down>" nil
      "<left-margin> <wheel-left>" nil
      "<left-margin> <wheel-right>" nil
      "<left-margin> <wheel-up>" nil
      "<mode-line> <mouse-4>" nil
      "<mode-line> <mouse-5>" nil
      "<mode-line> <mouse-6>" nil
      "<mode-line> <mouse-7>" nil
      "<mode-line> <wheel-down>" nil
      "<mode-line> <wheel-left>" nil
      "<mode-line> <wheel-right>" nil
      "<mode-line> <wheel-up>" nil
      "<mouse-4>" nil
      "<mouse-5>" nil
      "<mouse-6>" nil
      "<mouse-7>" nil
      "<right-fringe> <mouse-4>" nil
      "<right-fringe> <mouse-5>" nil
      "<right-fringe> <mouse-6>" nil
      "<right-fringe> <mouse-7>" nil
      "<right-fringe> <wheel-down>" nil
      "<right-fringe> <wheel-left>" nil
      "<right-fringe> <wheel-right>" nil
      "<right-fringe> <wheel-up>" nil
      "<right-margin> <mouse-4>" nil
      "<right-margin> <mouse-5>" nil
      "<right-margin> <mouse-6>" nil
      "<right-margin> <mouse-7>" nil
      "<right-margin> <wheel-down>" nil
      "<right-margin> <wheel-left>" nil
      "<right-margin> <wheel-right>" nil
      "<right-margin> <wheel-up>" nil
      "<vertical-scroll-bar> <mouse-4>" nil
      "<vertical-scroll-bar> <mouse-5>" nil
      "<vertical-scroll-bar> <mouse-6>" nil
      "<vertical-scroll-bar> <mouse-7>" nil
      "<vertical-scroll-bar> <wheel-down>" nil
      "<vertical-scroll-bar> <wheel-left>" nil
      "<vertical-scroll-bar> <wheel-right>" nil
      "<vertical-scroll-bar> <wheel-up>" nil
      "<wheel-down>" nil
      "<wheel-left>" nil
      "<wheel-right>" nil
      "<wheel-up>" nil
      "M-<mouse-4>" nil
      "M-<mouse-5>" nil
      "M-<mouse-6>" nil
      "M-<mouse-7>" nil
      "M-<wheel-down>" nil
      "M-<wheel-lefppt>" nil
      "M-<wheel-right>" nil
      "M-<wheel-up>" nil
      "S-<mouse-4>" nil
      "S-<mouse-5>" nil
      "S-<mouse-6>" nil
      "S-<mouse-7>" nil
      "S-<wheel-down>" nil
      "S-<wheel-left>" nil
      "S-<wheel-right>" nil
      "S-<wheel-up>" nil

      )
