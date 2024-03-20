;;; $DOOMDIR/config.el -*- mode: emacs-lisp; lexical-binding: t; -*-

;; TODO update references to files when renaming
;; TODO tramp profile for all ssh hosts
;; TODO pcre2 regex builder
;; TODO focus-{in,out}-hook is depricated, find replacement
;; TODO sway-mode
;; TODO magit + yadm: list todos, but limit to files git
;; TODO change alpha when loosing frame focus ()
;; TODO delete sexp; then delete whitespace around point
;; TODO generate functions for all system excutables
;; TODO advice wrapping (format ...) adding f.ex. %b as buffer-name and %B as buffer-file-name

(setq-default
 org-babel-default-header-args '((:session . "none") (:results . "replace drawer") (:exports . "code") (:cache . "no") (:noweb . "no") (:hlines . "no") (:tangle . "no"))

 display-line-numbers-type nil

 comint-move-point-for-output t

 python-shell-interpreter "python3"
 )

(setq!

 server-use-tcp t
 server-port    6666

 query-all-font-backends t

 custom-file (expand-file-name "~/.local/doom/_custom.el")

 initial-buffer-choice (or (expand-file-name "~/org/roam/20221211091724-scratch.org")
                           initial-buffer-choice
                           (expand-file-name "notes.org" org-directory))

 ;; doom-face (font-spec :weight 'thin)

 doom-font-increment 1

 shift-select-mode nil

 comint-move-point-for-output t

 +snippets-dir (or (expand-file-name "snippets" (file-truename "~/.local/doom"))
                   (expand-file-name "snippets" (file-truename doom-user-dir)))

 async-bytecomp-package-mode t

 doom-modeline-major-mode-icon t

 doom-scratch-initial-major-mode (quote fundamental-mode)

 doom-projectile-cache-blacklist (quote "/tmp")

 bookmark-default-file (expand-file-name "_bookmarks.el" doom-user-dir)

 ;; compile-command "~/bin/c callback compile-command"

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

;; (setq-hook! 'comint-mode-hook
;;   comint-buffer-maximum-size    20000   ; Increase comint buffer size.
;;   comint-prompt-read-only       t)      ; Make the prompt read only.

;; ;; https://github.com/hlissner/.doom.d/blob/6af0a541e0b6b6ec9aee4cb9f05e5cbec0800d91/config.el
;; (add-to-list
;;  'default-frame-alist '(inhibit-double-buffering . t))

;; (add-to-list 'load-path (expand-file-name "~/.local/doom"))

;; (with-temp-buffer
;;   (org-babel-tangle-file (expand-file-name "_init.org" "~/.local/doom"))
;;   ;; (find-file (expand-file-name "_init.org" "~/.local/doom"))
;;   )

(defmacro show! (EVAL &rest RX)
 `(pcase (type-of (string-match (rx ,@RX) (format "%S" (window-list))))
    ((quote integer) nil)
    (t ,EVAL)))

(defun advice/save-file (func &rest args)
  ;; (message "advice/save-file: x%S" (string-match (rx bol "*") (buffer-file-name)))
  (let ((res (apply func args))) res))


(advice-add 'save-buffer :around 'advice/save-file)

(map! :map dired-mode-map
      "." nil
      "s-." #'treemacs--follow)


(map! :map global-map "s-o" (cmd! (show! (treemacs) "treemacs")))

(map! :map org-mode-map "s-SPC w" #'widen)

(map! :after projectile
      "s-p" nil
      (:prefix "s-p"
               "s-p" #'projectile-switch-project-by-name
               "s-f" #'projectile-find-file))


;; (customize-face )



(map! :map dired-mode-map "s-."  #'dired-up-directory)
(map! :map dired-mode-map  "y y"  nil)
(map! :map dired-mode-map  "y S-y"  nil)
(map! :map dired-mode-map  "S-s S-s" #'dired-do-symlink)
(map! :map dired-mode-map  "S-s s" #'dired-do-relsymlink)
(map! :map dired-mode-map  "r" #'dired-do-rename-regexp)
(map! :map +ansible-yaml-mode-map  :mode +ansible-yaml-mode
      "M-RET" (cmd! (message "TODO"))

      )

(map! :map dired-mode-map  "y y"  nil)
(map! :map dired-mode-map  "y S-y"  nil)
(map! :map dired-mode-map  "S-s S-s" nil)
(map! :map dired-mode-map  "S-s s" nil)
(map! :map dired-mode-map  "S-s S-s" nil)
(map! :map dired-mode-map  "S-s s" nil)
(map! :map dired-mode-map  "r" #'dired-do-rename-regexp)
(map! :map +ansible-yaml-mode-map  :mode +ansible-yaml-mode
      "M-RET" (cmd! (message "TODO"))
      )

(map! :map sh-mode-map
      "M-RET" (cmd! (compile (format "%s || bash %s"
                                     (expand-file-name (buffer-file-name))
                                     (expand-file-name (buffer-file-name)))))

      )



;; (map! :map dired-mode-map  "S-s d" (cmd! (shell-command-to-string (format "systemd-escape %s" (buffer-file-name)))))

;; (map! "s-SPC 0" #'doom/reset-font-size)

;; (setq modus-themes-common-palette-overrides
;;       '((fringe unspecified)))

(global-hide-mode-line-mode 1)

;; (global-hl-line-mode -1)

;; (blink-cursor-mode 1)

;; (setq-hook! (quote (prog-mode-hook))
;;   hide-mode-line-mode -1)

;; (use-package! hl-line
;;   :custom-face
;;   (hl-line-face (t ((:weight bold :background nil))))
;;   (treemacs-hl-line-face (font-spec :weight bold :background nil)))

(use-package! treemacs
  :hook ((treemacs-mode . hide-mode-line-mode)
         (treemacs-mode . hl-line-mode))
  :custom
  (mode-line-format nil))

(use-package! css
  :mode "\\.rasi\\'")

(map! "s-0"     #'balance-windows)
(map! "s-["     #'undo)
(map! "s-]"     #'undo-redo)
(map! "s-\\"    #'+tmux/cd-to-here)
(map! "s-g"     #'magit-status)
(map! :map org-mode-map "s-g" #'magit-status)

(map! "s-SPC ="     #'doom/increase-font-size)
(map! "s-SPC -"     #'doom/decrease-font-size)

(map! "s-[" #'undo)
(map! "s-]" #'undo-redo)

(map! "s-\\" #'+vterm/here)

;; (use-package! vterm  )

(use-package! ob-tmux
  :custom
  (org-babel-tmux-terminal "/bin/alacritty")
  ;; (org-babel-tmux-terminal-opts "-e /bin/tmux --")
  ;; (org-babel-tmux-terminal-opts "--")
  )
;; (map! "s-SPC s-SPC s-SPC s-SPC" (cmd! (let ((START)
;;                    (END)
;;                    (ARG)
;;                    (INTERACTIVE))
;;                (indent-rigidly START END ARG INTERACTIVE)))
;;  )

(after! tramp
  (setq! tramp-methods
         (quote (("adb"
                  (tramp-login-program "adb")
                  (tramp-login-args
                   (("-s" "%d")
                    ("shell")))
                  (tramp-direct-async t)
                  (tramp-tmpdir "/data/local/tmp")
                  (tramp-default-port 5555))
                 ("kubernetes"
                  (tramp-login-program "kubectl")
                  (tramp-login-args
                   (("exec")
                    ("%h")
                    ("-it")
                    ("--")
                    ("%l")))
                  (tramp-config-check tramp-kubernetes--current-context-data)
                  (tramp-direct-async
                   ("/bin/sh" "-c"))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-i" "-c")))
                 ("podman"
                  (tramp-login-program "podman")
                  (tramp-login-args
                   (("exec")
                    ("-it")
                    ("-u" "%u")
                    ("%h")
                    ("%l")))
                  (tramp-direct-async
                   ("/bin/sh" "-c"))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-i" "-c")))
                 ("docker"
                  (tramp-login-program "docker")
                  (tramp-login-args
                   (("exec")
                    ("-it")
                    ("-u" "%u")
                    ("%h")
                    ("%l")))
                  (tramp-direct-async
                   ("/bin/sh" "-c"))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-i" "-c")))
                 ("ftp")
                 ("sftp")
                 ("nextcloud")
                 ("mtp")
                 ("gdrive")
                 ("davs")
                 ("dav")
                 ("afp")
                 ("rclone"
                  (tramp-mount-args
                   ("--no-unicode-normalization" "--dir-cache-time" "0s"))
                  (tramp-copyto-args nil)
                  (tramp-moveto-args nil)
                  (tramp-about-args
                   ("--full")))
                 ("fcp"
                  (tramp-login-program "fsh")
                  (tramp-login-args
                   (("%h")
                    ("-l" "%u")
                    ("sh" "-i")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-i")
                   ("-c"))
                  (tramp-copy-program "fcp")
                  (tramp-copy-args
                   (("-p" "%k")))
                  (tramp-copy-keep-date t))
                 ("psftp"
                  (tramp-login-program "plink")
                  (tramp-login-args
                   (("-l" "%u")
                    ("-P" "%p")
                    ("-ssh")
                    ("-t")
                    ("%h")
                    ("\"")
                    ("env 'TERM=dumb' 'PROMPT_COMMAND=' 'PS1=#$ '")
                    ("%l")
                    ("\"")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c"))
                  (tramp-copy-program "pscp")
                  (tramp-copy-args
                   (("-l" "%u")
                    ("-P" "%p")
                    ("-sftp")
                    ("-p" "%k")
                    ("-q")))
                  (tramp-copy-keep-date t))
                 ("pscp"
                  (tramp-login-program "plink")
                  (tramp-login-args
                   (("-l" "%u")
                    ("-P" "%p")
                    ("-ssh")
                    ("-t")
                    ("%h")
                    ("\"")
                    ("env 'TERM=dumb' 'PROMPT_COMMAND=' 'PS1=#$ '")
                    ("%l")
                    ("\"")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c"))
                  (tramp-copy-program "pscp")
                  (tramp-copy-args
                   (("-l" "%u")
                    ("-P" "%p")
                    ("-scp")
                    ("-p" "%k")
                    ("-q")
                    ("-r")))
                  (tramp-copy-keep-date t)
                  (tramp-copy-recursive t))
                 ("plinkx"
                  (tramp-login-program "plink")
                  (tramp-login-args
                   (("-load")
                    ("%h")
                    ("-t")
                    ("\"")
                    ("env 'TERM=dumb' 'PROMPT_COMMAND=' 'PS1=#$ '")
                    ("%l")
                    ("\"")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c")))
                 ("plink"
                  (tramp-login-program "plink")
                  (tramp-login-args
                   (("-l" "%u")
                    ("-P" "%p")
                    ("-ssh")
                    ("-t")
                    ("%h")
                    ("\"")
                    ("env 'TERM=dumb' 'PROMPT_COMMAND=' 'PS1=#$ '")
                    ("%l")
                    ("\"")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c")))
                 ("krlogin"
                  (tramp-login-program "krlogin")
                  (tramp-login-args
                   (("%h")
                    ("-l" "%u")
                    ("-x")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c")))
                 ("ksu"
                  (tramp-login-program "ksu")
                  (tramp-login-args
                   (("%u")
                    ("-q")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c"))
                  (tramp-connection-timeout 10))
                 ("doas"
                  (tramp-login-program "doas")
                  (tramp-login-args
                   (("-u" "%u")
                    ("-s")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-args
                   ("-c"))
                  (tramp-connection-timeout 10)
                  (tramp-session-timeout 300)
                  (tramp-password-previous-hop t))
                 ("sudo"
                  (tramp-login-program "env")
                  (tramp-login-args
                   (("SUDO_PROMPT=P\"\"a\"\"s\"\"s\"\"w\"\"o\"\"r\"\"d\"\":")
                    ("sudo")
                    ("-u" "%u")
                    ("-s")
                    ("-H")
                    ("%l")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c"))
                  (tramp-connection-timeout 10)
                  (tramp-session-timeout 300)
                  (tramp-password-previous-hop t))
                 ("sg"
                  (tramp-login-program "sg")
                  (tramp-login-args
                   (("-")
                    ("%u")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-args
                   ("-c"))
                  (tramp-connection-timeout 10))
                 ("su"
                  (tramp-login-program "su")
                  (tramp-login-args
                   (("-")
                    ("%u")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c"))
                  (tramp-connection-timeout 10))
                 ("nc"
                  (tramp-login-program "telnet")
                  (tramp-login-args
                   (("%h")
                    ("%p")
                    ("%n")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c"))
                  (tramp-copy-program "nc")
                  (tramp-copy-args
                   (("-w" "1")
                    ("-v")
                    ("%h")
                    ("%r")))
                  (tramp-remote-copy-program "nc")
                  (tramp-remote-copy-args
                   (("-l")
                    ("-p" "%r")
                    ("%n"))))
                 ("telnet"
                  (tramp-login-program "telnet")
                  (tramp-login-args
                   (("%h")
                    ("%p")
                    ("%n")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c")))
                 ("sshx"
                  (tramp-login-program "ssh")
                  (tramp-login-args
                   (("-l" "%u")
                    ("-p" "%p")
                    ("%c")
                    ("-e" "none")
                    ("-t" "-t")
                    ("-o" "RemoteCommand=\"%l\"")
                    ("%h")))
                  (tramp-async-args
                   (("-q")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c")))
                 ("ssh"
                  (tramp-login-program "ssh")
                  (tramp-login-args
                   (("-l" "%u")
                    ("-p" "%p")
                    ("%c")
                    ("-e" "none")
                    ("%h")))
                  (tramp-async-args
                   (("-q")))
                  (tramp-direct-async t)
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c")))
                 ("remsh"
                  (tramp-login-program "remsh")
                  (tramp-login-args
                   (("%h")
                    ("-l" "%u")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c")))
                 ("rsh"
                  (tramp-login-program "rsh")
                  (tramp-login-args
                   (("%h")
                    ("-l" "%u")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c")))
                 ("rsync"
                  (tramp-login-program "ssh")
                  (tramp-login-args
                   (("-l" "%u")
                    ("-p" "%p")
                    ("%c")
                    ("-e" "none")
                    ("%h")))
                  (tramp-async-args
                   (("-q")))
                  (tramp-direct-async t)
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c"))
                  (tramp-copy-program "rsync")
                  (tramp-copy-args
                   (("-t" "%k")
                    ("-p")
                    ("-r")
                    ("-s")
                    ("-c")))
                  (tramp-copy-env
                   (("RSYNC_RSH")
                    ("ssh")
                    ("%c")))
                  (tramp-copy-keep-date t)
                  (tramp-copy-keep-tmpfile t)
                  (tramp-copy-recursive t))
                 ("scpx"
                  (tramp-login-program "ssh")
                  (tramp-login-args
                   (("-l" "%u")
                    ("-p" "%p")
                    ("%c")
                    ("-e" "none")
                    ("-t" "-t")
                    ("-o" "RemoteCommand=\"%l\"")
                    ("%h")))
                  (tramp-async-args
                   (("-q")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c"))
                  (tramp-copy-program "scp")
                  (tramp-copy-args
                   (("-P" "%p")
                    ("-p" "%k")
                    ("%x")
                    ("%y")
                    ("%z")
                    ("-q")
                    ("-r")
                    ("%c")))
                  (tramp-copy-keep-date t)
                  (tramp-copy-recursive t))
                 ("scp"
                  (tramp-login-program "ssh")
                  (tramp-login-args
                   (("-l" "%u")
                    ("-p" "%p")
                    ("%c")
                    ("-e" "none")
                    ("%h")))
                  (tramp-async-args
                   (("-q")))
                  (tramp-direct-async t)
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c"))
                  (tramp-copy-program "scp")
                  (tramp-copy-args
                   (("-P" "%p")
                    ("-p" "%k")
                    ("%x")
                    ("%y")
                    ("%z")
                    ("-q")
                    ("-r")
                    ("%c")))
                  (tramp-copy-keep-date t)
                  (tramp-copy-recursive t))
                 ("remcp"
                  (tramp-login-program "remsh")
                  (tramp-login-args
                   (("%h")
                    ("-l" "%u")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c"))
                  (tramp-copy-program "rcp")
                  (tramp-copy-args
                   (("-p" "%k")))
                  (tramp-copy-keep-date t))
                 ("rcp"
                  (tramp-login-program "rsh")
                  (tramp-login-args
                   (("%h")
                    ("-l" "%u")))
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c"))
                  (tramp-copy-program "rcp")
                  (tramp-copy-args
                   (("-p" "%k")
                    ("-r")))
                  (tramp-copy-keep-date t)
                  (tramp-copy-recursive t))
                 ("smb"
                  (tramp-tmpdir "/C$/Temp")
                  (tramp-case-insensitive t))
                 ("sshfs"
                  (tramp-mount-args
                   (("-C")
                    ("-p" "%p")
                    ("-o" "dir_cache=no")
                    ("-o" "transform_symlinks")
                    ("-o" "idmap=user,reconnect")))
                  (tramp-login-program "ssh")
                  (tramp-login-args
                   (("-q")
                    ("-l" "%u")
                    ("-p" "%p")
                    ("-e" "none")
                    ("-t" "-t")
                    ("%h")
                    ("%l")))
                  (tramp-direct-async t)
                  (tramp-remote-shell "/bin/sh")
                  (tramp-remote-shell-login
                   ("-l"))
                  (tramp-remote-shell-args
                   ("-c")))
                 ("sudoedit"
                  (tramp-sudo-login
                   (("sudo")
                    ("-u" "%u")
                    ("-S")
                    ("-H")
                    ("-p" "Password:")
                    ("--")))
                  (tramp-password-previous-hop t))))))
