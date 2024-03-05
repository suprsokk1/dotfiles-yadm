;;; $DOOMDIR/config.el -*- mode: emacs-lisp; lexical-binding: t; -*-

;; TODO pcre2 regex builder
;; TODO focus-{in,out}-hook is depricated, find replacement
;; TODO sway-mode
;; TODO magit + yadm: list todos, but limit to files git
;; TODO change alpha when loosing frame focus ()
;; TODO delete sexp; then delete whitespace around point

(setq-default
 org-babel-default-header-args '((:session . "none") (:results . "replace drawer") (:exports . "code") (:cache . "no") (:noweb . "no") (:hlines . "no") (:tangle . "no"))

 display-line-numbers-type nil

 comint-move-point-for-output t
 )

 (setq!
 query-all-font-backends t

 custom-file (expand-file-name "~/.local/doom/_custom.el")

 initial-buffer-choice (or (expand-file-name "~/org/roam/20221211091724-scratch.org")
                           initial-buffer-choice
                           (expand-file-name "notes.org" org-directory))

 shift-select-mode nil

 comint-move-point-for-output t

 +snippets-dir (or (expand-file-name "snippets" (file-truename "~/.local/doom"))
                   (expand-file-name "snippets" (file-truename doom-user-dir)))

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
 company-minimum-prefix-length (max 2)

 ;;wait `n' secs before lookup
 ;; company-idle-delay 2
 company-idle-delay 0

 org-log-state-notes-into-drawer t

 docker-compose-command "docker compose"

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
  (org-babel-tangle-file (expand-file-name "_init.org" "~/.local/doom"))
  ;; (find-file (expand-file-name "_init.org" "~/.local/doom"))
  )


(defun advice:after:+lookup/definition (FUNC &rest ARGS)
  "TODO"
  (let ((res (apply FUNC ARGS)))
    (message "res %s" res)))

;; (map! :mode ()  "M-RET" :desc "Default compile" #'M-RET)
(map! :prefix "s-SPC" "t w"  #'writeroom-mode)
(map! :desc "Next file in current directory" "s-\\" (cmd! (save-excursion (dired (dir!)) (dired-next-line 1) (dired-find-file))))
(map! :desc "Previous file in current directory" "s-'"  (cmd! (save-excursion (dired (dir!)) (dired-next-line -1) (dired-find-file))))
(map! "s-<backspace>" #'delete-pair)
(map! "s-x" #'eros-eval-last-sexp)
(map! "s-/" #'+default/search-buffer)
(map! "s-<return>" (cmd! (consult-buffer (quote ;FIXME
                                          (consult--source-bookmark
                                           consult--source-hidden-buffer
                                           consult--source-modified-buffer
                                           consult--source-buffer
                                           consult--source-recent-file
                                           consult--source-file-register
                                           consult--source-project-buffer-hidden
                                           consult--source-project-recent-file-hidden))))
      )

(map! "s-r"          (cmd! (consult-buffer (quote ;FIXME
                                       (consult--source-recent-file
                                        consult--source-bookmark
                                        consult--source-hidden-buffer
                                        consult--source-modified-buffer
                                        consult--source-buffer
                                        consult--source-file-register
                                        consult--source-project-buffer-hidden
                                        consult--source-project-recent-file-hidden)))))


(map! "s-["        nil)
(map! "s-]"        nil)

(map! "s-[" :map org-mode-map #'org-meta-leftshift)
(map! "s-]" :map org-mode-map #'org-meta-rightshift)

(map! "s-k"        #'delete-window)
(map! "M-s-k"      #'doom/kill-this-buffer-in-all-windows)

;; (mapcar
;;  (lambda (&rest BODY) (or (pcase (type-of BODY) (t nil))))
;;  (let ((END 10)
;;        (BEGINNING 0))
;;    (let ((_ BEGINNING))
;;      (while (not (eq _ END))
;;          (set (quote _) (+ _ 1))

;;      ))
;;  ))

(map! "s-n"        (cmd! (when (split-window-sensibly)(dired "."))))
(map! "M-s-n"      #'split-window-below)
(map! "s-{"        #'undo)
(map! "s-}"        #'undo-redo)
(map! "s-."        #'dired-jump)
(map! "M-s-."      (cmd! (message "TODO")))
(map! "s-0"        #'balance-windows)
(map! "M-s-e"      #'windmove-swap-states-right)
(map! "M-s-q"      #'windmove-swap-states-left)
(map! "M-s-s"      #'windmove-swap-states-down)
(map! "M-s-w"      #'windmove-swap-states-up)
(map! "s-e"        #'windmove-right)
(map! "s-q"        #'windmove-left)
(map! "s-s"        #'windmove-down)
(map! "s-w"        #'windmove-up)
(map! "M-s-["      #'winner-undo)
(map! "M-s-}"      #'winner-redo)
(map! "M-s-<return>" (cmd! (winner-remember) (message "winner-remember")))

(map! (:mode rustic-mode "M-RET" (cmd!
                                  (let ((outdir (make-temp-file (getenv "XDG_RUNTIME_DIR") t))
                                        (file (buffer-file-name)))
                                    (shell-command
                                     (format "rustc %s --outdir=%s" file outdir))
                                    (file-expand-wildcards (format "%s/*" outdir))))))

(map! (:mode dired-mode "."   nil))
(map! (:mode dired-mode :prefix "." "."  nil))
(map! (:mode dired-mode "." (cmd! (treemacs) ())))
(map! (:mode dired-mode "/"   #'dired-mark-files-regexp))
(map! (:mode dired-mode "D"   nil))
(map! (:mode dired-mode "a"   nil))
(map! (:mode dired-mode "C-t" (cmd! (if (dired-get-marked-files)) (dired-unmark-all-marks) (dired-mark-files-regexp (rx any))))) ;FIXME
(map! (:mode dired-mode :prefix "a" "a" nil))
(map! (:mode dired-mode :prefix "a" "a" (cmd! (dired-mark-files-regexp (rx any)))))
(map! (:mode dired-mode :prefix "a" "e" (cmd! (dired-mark-files-regexp (rx ".el" eol)))))

(map! (:when (modulep! :editor multiple-cursors)
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
       "s"         #'org-narrow-to-subtree
       (:after org-roam "SPC"
               #'org-roam-node-find
               (:prefix "n" "n" #'org-capture)))

      (:prefix
       "s-SPC"
       (:prefix
        "s-SPC" "c" #'doom/goto-private-config-file
        "s-SPC"     #'-refresh
        )
       "m"         #'+zen/toggle-fullscreen
       "TAB"       (cmd! (find-file initial-buffer-choice))
       "b"         #'doom-big-font-mode

       "q"         #'delete-other-windows
       ;; "x"         #'doom/open-scratch-buffer
       "x"         (cmd! (find-file (expand-file-name "~/org/roam/20221211091724-scratch.org")))
       "s-q"       #'delete-other-frames
       )

      (:map python-mode-map
            "M-RET" (cmd!
                     (when (executable-find "ipython")
                       (setq python-shell-interpreter "ipython"))
                      (let ((_ (string-match "\*Python\*" (format "%S" (window-list)))))
                        (or
                         ;; (run-python)   ;FIXME
                         (run-python nil nil (not _))))
                     (python-shell-send-buffer (buffer-file-name))
                     (let ((INITIAL-BUFFER (buffer-name)))
                       (save-excursion
                         (switch-to-buffer-other-window "*Python*" t)
                         (goto-char (point-max))
                         (recenter-top-bottom 2)
                         (switch-to-buffer-other-window INITIAL-BUFFER t))))))

(map! "n" #'self-insert-command)
(map! :prefix "s-SPC" (:prefix "s-SPC" "s-SPC" :desc "`yas-new-snippet' if region is active" (cmd! (when (region-active-p) (yas-new-snippet)))))
