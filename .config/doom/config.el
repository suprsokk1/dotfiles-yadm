;;; $DOOMDIR/config.el -*- mode: emacs-lisp; lexical-binding: t; -*-

;; TODO focus-{in,out}-hook is depricated, find replacement
;; TODO sway-mode
;; TODO magit + yadm: list todos, but limit to files git
;; TODO change alpha when loosing frame focus ()
;; TODO delete sexp; then delete whitespace around point

(setq-default
 ;; frame-title-format "%b %f"
 frame-title-format (quote (:eval (-frame-title-format)))
 frame-title-format "%b %f"

 ;; frame-title-format nil
 header-line-format (quote (:eval (-header-title-format)))
 header-line-format nil
)

(setq!
 display-line-numbers-type nil

 query-all-font-backends t

 custom-file (expand-file-name "~/.local/doom/_custom.el")

 initial-buffer-choice (or initial-buffer-choice
                           (expand-file-name "notes.org" org-directory))

 ;; header-line-format "%b %V"
 ;; header-line-format  (quote ("%e" (:eval)))
 ;; header-line-format nil

 shift-select-mode nil

 comint-move-point-for-output t

 +snippets-dir (or (expand-file-name "snippets" (file-truename doom-user-dir))
                   (expand-file-name "snippets" (expand-file-name doom-user-dir)))

 async-bytecomp-package-mode t

 doom-theme 'modus-vivendi
 doom-modeline-major-mode-icon t
 doom-scratch-initial-major-mode (quote fundamental-mode)
 doom-projectile-cache-blacklist (quote "/tmp")

 bookmark-default-file (expand-file-name "_bookmarks.el" doom-user-dir)

 compile-command "~/bin/c callback compile-command"

 vterm-shell "/bin/tmux"

 global-hl-line-mode -1

 ;;performance
 ;; company-minimum-prefix-length 2
 company-minimum-prefix-length 1

 ;;wait `n' secs before lookup
 ;; company-idle-delay 2
 company-idle-delay 0

 org-log-state-notes-into-drawer t
 )


;;; `workflow'
;;; jump to *scratch* buffer split words into lines
;;; -activate multiple-cursors
(setq-hook! 'fundamental-mode
  fill-column 1)

(setq-hook! 'comint-mode-hook
  comint-buffer-maximum-size    20000   ; Increase comint buffer size.
  comint-prompt-read-only       t)      ; Make the prompt read only.

;; https://github.com/hlissner/.doom.d/blob/6af0a541e0b6b6ec9aee4cb9f05e5cbec0800d91/config.el
(add-to-list
 'default-frame-alist '(inhibit-double-buffering . t))

(add-to-list 'load-path (expand-file-name "~/.local/doom"))

(with-temp-buffer
  (expand-file-name "_init.org" "~/.local/doom")
  (org-babel-execute-buffer))

(defun advice:after:+lookup/definition (FUNC &rest ARGS)
  "TODO"

  (let ((res (apply FUNC ARGS)))
    (message "res %s" res)))



;; (map! :mode ()  "M-RET" :desc "Default compile" #'M-RET)

(map! :desc "Next file in current directory" "s-\\" (cmd! (save-excursion (dired (dir!)) (dired-next-line 1) (dired-find-file))))
(map! :desc "Previous file in current directory" "s-'"  (cmd! (save-excursion (dired (dir!)) (dired-next-line -1) (dired-find-file))))

(map!
 "s-/"        #'+default/search-buffer

 "s-<return>" #'bookmark-jump
 "s-<return>" nil
 "s-<return>"  (cmd! (consult-buffer (quote ;FIXME
                                      (consult--source-bookmark
                                       consult--source-hidden-buffer
                                       consult--source-modified-buffer
                                       consult--source-buffer
                                       consult--source-recent-file
                                       consult--source-file-register
                                       consult--source-project-buffer-hidden
                                       consult--source-project-recent-file-hidden))))

 "s-r"          (cmd! (consult-buffer (quote ;FIXME
                                       (consult--source-recent-file
                                        consult--source-bookmark
                                        consult--source-hidden-buffer
                                        consult--source-modified-buffer
                                        consult--source-buffer
                                        consult--source-file-register
                                        consult--source-project-buffer-hidden
                                        consult--source-project-recent-file-hidden))))

 "s-k"        #'delete-window
 "M-s-k"      #'doom/kill-this-buffer-in-all-windows
 "M-s-k"      nil
 "M-s-k"      #'doom/kill-this-buffer-in-all-windows

 "s-n"        #'split-window-right
 "M-s-n"      #'split-window-below

 "s-["        #'undo
 "s-]"        #'undo-redo

 "s-."        #'dired-jump
 "M-s-."      (cmd! (message "TODO"))

 "s-0"        #'balance-windows

 "M-s-e"      #'windmove-swap-states-right
 "M-s-q"      #'windmove-swap-states-left
 "M-s-s"      #'windmove-swap-states-down
 "M-s-w"      #'windmove-swap-states-up
 "s-e"        #'windmove-right
 "s-q"        #'windmove-left
 "s-s"        #'windmove-down
 "s-w"        #'windmove-up

 "M-s-["      #'winner-undo
 "M-s-}"      #'winner-redo
 "M-s-<return>" (cmd! (winner-remember) (message "winner-remember"))

 (:mode rustic-mode
        "M-RET" (cmd!
                 (let ((outdir (make-temp-file (getenv "XDG_RUNTIME_DIR") t))
                       (file (buffer-file-name)))
                   (shell-command
                    (format "rustc %s --outdir=%s" file outdir))
                   (file-expand-wildcards (format "%s/*" outdir))
                   )))

 (:mode dired-mode
        "."     nil
        ". ." #'dired-up-directory
        "/"     #'dired-mark-files-regexp
        "D"     nil
        "a"     nil
        "a a"   nil
        "a a" (cmd! (dired-mark-files-regexp (rx any)))
        "a e" (cmd! (dired-mark-files-regexp (rx ".el" eol)))
        "C-t"   (cmd! (if (dired-get-marked-files)
                          (dired-unmark-all-marks)
                        (dired-mark-files-regexp (rx any))))

        ;; "M" nil
        ;; "M"     (cmd! (message "%S" (dired-get-marked-files)))
        )

 (:when (modulep! :editor multiple-cursors)
   ;; "C-."      #'mc/mark-next-lines
   ;; "C-." nil                            ;FIXME
   "C-."      #'mc/mark-next-like-this

   (:prefix
    "s-SPC"
    "["       #'mc/edit-beginnings-of-lines
    "]"       #'mc/edit-ends-of-lines
    )
   )

 (:when (modulep! :checkers syntax)
   "M-]" #'next-error
   "M-[" #'previous-error
   "s-g s-g"  #'first-error
   "M-s-g"    nil                       ;TODO last error
   "<f12>"      #'flycheck-list-errors
   "s-l e"      #'flycheck-list-errors
   )

 (:after org
  :prefix "s-SPC"
  "n"         #'org-capture
  "s"         #'org-narrow-to-subtree
  "SPC"       #'org-roam-node-find
  )

 (:prefix
  "s-SPC"
  (:prefix
   "s-SPC" "c" #'doom/goto-private-config-file
   "s-SPC"     #'-refresh
   )
  "m"         #'+zen/toggle-fullscreen
  "TAB"         (cmd! (find-file initial-buffer-choice))
  "b"         #'doom-big-font-mode

  "q"         #'delete-other-windows
  "x"         #'doom/open-scratch-buffer
  "s-q"       #'delete-other-frames
  )

 (:map sh-mode-map
       "M-RET"  (cmd! (quote (+tmux/run "swaymsg focus"))
                      (+tmux/cd-to-here)
                      (+tmux/run)))

 (:map python-mode-map
       "M-RET" (cmd! (let ((PYTHON_RUNNING (string-match python-shell-buffer-name (format "%s" (process-list))))
                           (PYTHON_VISIBLE (string-match python-shell-buffer-name (format "%s" (window-list)))))
                       (unless (and PYTHON_VISIBLE PYTHON_RUNNING) (run-python))
                       ;; (message "%S" python-shell-buffer-name)
                       ;; (string-match (format "*%s*" python-shell-buffer-name) )
                       (python-shell-send-file (buffer-file-name))))
       )
 )

(after! consult
  (setq!
   consult-buffer-sources (quote
                           (consult--source-recent-file
                            consult--source-hidden-buffer
                            consult--source-modified-buffer
                            consult--source-buffer
                            consult--source-file-register
                            consult--source-bookmark
                            consult--source-project-buffer-hidden
                            consult--source-project-recent-file-hidden))))

(defun --read-key (key-sequence)
  "TODO"
  (interactive
   (list (read-key-sequence "Press key: ")))
  (let ((sym (key-binding key-sequence)))
    (cond
     ((null sym)
      (user-error "No command is bound to %s"
                  (key-description key-sequence)))
     (t
      (user-error "%s is bound to %s which is not a command"
                  (key-description key-sequence)
                  sym)))))

(after! modus-themes
  (unless (equal doom-theme 'modus-vivendi)
      (modus-themes-select 'modus-vivendi)))

(advice-add '+lookup/definition :around #'advice:after:+lookup/definition)

(defmacro HOME (EXPAND)
  (let ((HOME (getenv "HOME")))
     `(expand-file-name ,EXPAND ,HOME)))

(defmacro GIT (PATH &optional RELATIVE)
  `(message "TODO defmacro GIT"))

(setq! -generic-advice:buffer-save:is-file
       (quote (make-symbolic-link (buffer-file-name)
               (HOME "emacs.buffer-save") t)))

(defun -generic-advice (func &rest args)
  (let ((empty-file-name (null (buffer-file-name)))
        (file-buffer (not (string-match (buffer-name) (rx bol ?* (+ (any word space)) ?* eol))))
        (is-window-buffer (string-match (buffer-name) (format "%s" (window-list)))))
    (pcase major-mode
      ('save-buffer (unless empty-file-name
                      (when (and file-buffer is-window-buffer)
                        (make-symbolic-link (buffer-file-name) (HOME "emacs.buffer-save") t))
                      (apply func args)))
      (_ (apply func args)))))

(map! "s-<backspace>" #'delete-pair)

(advice-add 'save-buffer :around '-generic-advice)
;; (advice-remove 'save-buffer #'-generic-advice)

;; (save-buffer)
;; (advice-add '-header-title-format :around #')
;; (advice-add '-frame-title-format :around #')
